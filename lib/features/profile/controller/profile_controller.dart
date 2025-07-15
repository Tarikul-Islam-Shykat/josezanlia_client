import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/global_widegts/app_snackbar.dart';
import '../../../core/global_widegts/custom_snack_bar.dart';
import '../../../core/repository/network_caller/endpoints.dart';
import '../../../core/repository/services_class/local_service/shared_preferences_helper.dart';
import '../../nav_bar/view/nav_bar_view.dart';
import '../../profile/controller/user_info_controller.dart';

class EditProfileController extends GetxController {
  Rx<TextEditingController> nameTEC = TextEditingController().obs;
  Rx<TextEditingController> phoneTEC = TextEditingController().obs;
  Rx<TextEditingController> dobTEC = TextEditingController().obs;

  final UserProfileController userController = Get.put(UserProfileController());



  final _picker = ImagePicker();

  RxBool isUploading = false.obs;
  RxDouble uploadProgress = 0.0.obs;
  RxString imageSizeText = ''.obs;
  Rx<File?> profileImage = Rx<File?>(null);
  RxString userImage = ''.obs;
  RxString userName = ''.obs;
  RxString phoneNumber = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  final isUpdateProfileLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getDataFromSharePref();
    _initializeProfileFields();

  }

  void updateProfileImage(File image) {
    profileImage.value = image;
    log('Profile image updated: ${image.path}');
  }

  Future<void> getDataFromSharePref() async {
    userName.value = await SharedPreferencesHelper.getUserFirstName() ?? '';
    phoneNumber.value =
        await SharedPreferencesHelper.getUserPhoneNumber() ?? '';
    userImage.value = await SharedPreferencesHelper.getUserProfileImage() ?? '';

    if (kDebugMode) {
      debugPrint("User Image: ${userName.value}");
    }


   // workerId.value = await SharedPreferencesHelper.getUserWorkerId() ?? '';



    if (kDebugMode) {
      print("Profile User Profile Image at Profile Controller: ${await SharedPreferencesHelper.getUserProfileImage()}");
    }




    // nameController.text = userName.value;
    // phoneController.text = phoneNumber.value;

    if (kDebugMode) {
      print("Profile Edit User Name: ${userName.value}");
      print("Profile Edit User Phone Number: ${phoneNumber.value}");
      print("Profile Edit User Image: ${userImage.value}");
    }
  }









  void _initializeProfileFields() {
    final user = userController.userProfile.value.consumer?.first;





    if (user != null) {
      nameTEC.value.text = user.firstName ?? '';
      phoneTEC.value.text = userController.userProfile.value.phone ?? '';

      if (userController.userProfile.value.dob != null) {
        try {
          DateTime parsedDate = DateTime.parse(
            userController.userProfile.value.dob.toString(),
          );
          selectedDate.value = parsedDate;
          dobTEC.value.text = _formatDate(parsedDate);
        } catch (_) {
          dobTEC.value.text = '';
        }
      }
    }
  }

  Future<void> pickProfileImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        File? compressedImage = await _compressImage(imageFile);
        if (compressedImage != null) {
          profileImage.value = compressedImage;
          await _updateImageSizeText(compressedImage);
          AppSnackbar.show(
            message: 'profile_picture_selected_successfully'.tr,
            isSuccess: true,
          );
        }
      }
    } catch (e) {
      log("Failed to pick image: ${e.toString()}");
    }
  }

  Future<void> pickProfileImageFormCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        File? compressedImage = await _compressImage(imageFile);
        if (compressedImage != null) {
          profileImage.value = compressedImage;
          await _updateImageSizeText(compressedImage);
          AppSnackbar.show(
            message: 'profile_picture_captured_successfully'.tr,
            isSuccess: true,
          );
        }
      }
    } catch (e) {
      log("Failed to capture image: ${e.toString()}");
    }
  }

  Future<File?> _compressImage(File imageFile) async {
    try {
      int originalSize = await imageFile.length();
      if (originalSize <= 250 * 1024) return imageFile;

      String targetPath = imageFile.path
          .replaceAll(".jpg", "_compressed.jpg")
          .replaceAll("jpeg", "_compressed.jpeg")
          .replaceAll("png", "_compressed.jpg");

      Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: 800,
        minHeight: 800,
        quality: 85,
        format: CompressFormat.jpeg,
      );

      if (compressedBytes == null) return null;

      int quality = 85;
      int currentSize = compressedBytes.length;
      while (currentSize > 250 * 1024 && quality > 50) {
        quality -= 10;
        compressedBytes = await FlutterImageCompress.compressWithFile(
          imageFile.absolute.path,
          minWidth: 600,
          minHeight: 600,
          quality: quality,
          format: CompressFormat.jpeg,
        );
        if (compressedBytes != null) {
          currentSize = compressedBytes.length;
        } else {
          break;
        }
      }

      if (compressedBytes == null) return null;

      File compressedFile = File(targetPath);
      await compressedFile.writeAsBytes(compressedBytes);

      return compressedFile;
    } catch (e) {
      log("Compression error: $e");
      return null;
    }
  }

  Future<void> _updateImageSizeText(File imageFile) async {
    try {
      int sizeInBytes = await imageFile.length();
      double sizeInKB = sizeInBytes / 1024;

      if (sizeInKB < 1024) {
        imageSizeText.value = "${sizeInKB.toStringAsFixed(1)} KB";
      } else {
        double sizeInMB = sizeInKB / 1024;
        imageSizeText.value = "${sizeInMB.toStringAsFixed(1)} MB";
      }
    } catch (_) {
      imageSizeText.value = "Size unknown";
    }
  }

  Future<bool> uploadProfileImage() async {

    if (profileImage.value == null) {
      AppSnackbar.show(message: 'please_select_a_picture'.tr, isSuccess: false);
      return false;
    }

    try {
      isUploading.value = true;

      final request = http.MultipartRequest(
        "PUT",
        Uri.parse(
          "${Urls.updateProfile}/${userController.userProfile.value.consumer!.first.id}",
        ),
      );

      SharedPreferences sh = await SharedPreferences.getInstance();
      String? token = sh.getString("token");

      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        "Authorization": "$token",
      });

      DateTime parsedDob = DateFormat("dd/MM/yyyy").parse(dobTEC.value.text);
      var dobIso = parsedDob.toUtc().toIso8601String();

      Map<String, dynamic> userData = {
        "dob": dobIso,
        "firstName": nameTEC.value.text,
        "phone": phoneTEC.value.text,
      };

      request.fields["data"] = jsonEncode(userData);

      var imageBytes = await profileImage.value!.readAsBytes();
      var multipartFile = http.MultipartFile.fromBytes(
        "image",
        imageBytes,
        filename: "profile_${DateTime.now().millisecondsSinceEpoch}.jpg",
      );

      request.files.add(multipartFile);

      var streamedResponse = await request.send();

      for (int i = 0; i <= 100; i += 10) {
        uploadProgress.value = i.toDouble();
        await Future.delayed(Duration(milliseconds: 50));
      }

      final response = await http.Response.fromStream(streamedResponse);
      final responseJson = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseJson["success"] == true) {
        AppSnackbar.show(
          message: 'profile_updated_successfully'.tr,
          isSuccess: true,
        );
        Get.back();
        clearImage();
        return true;
      } else {
        AppSnackbar.show(
          message: "${responseJson["message"]}",
          isSuccess: false,
        );
        return false;
      }
    } catch (e) {
      log("Upload failed: ${e.toString()}");
      return false;
    } finally {
      isUploading.value = false;
    }
  }




  void updateProfile() async {

    if (kDebugMode) {


      print("Profile Image: ${profileImage.value?.path}");
      print("First Name: ${nameTEC.value.text} Phone: ${phoneTEC.value.text}");
    }


    log(
      'Profile updated - Name: ${userName.value}, Phone: ${phoneNumber.value}',
    );

    if (profileImage.value == null) {
      showSnackBar(false, 'please_select_an_image'.tr);
      return;
    }

    isUpdateProfileLoading.value = true;



      try {
        final token = await SharedPreferencesHelper.getAccessToken();
        if (token == null) {
          Get.snackbar('auth_error'.tr, 'no_access_token_found'.tr);
          return;
        }

        var request = http.MultipartRequest('PUT', Uri.parse(Urls.updateProfileConsumer));
        request.headers['Authorization'] = token;
        request.headers["Content-Type"] = "application/json";

        Map<String, dynamic> dataFields = {
          //"address": "Dattapara",
          //"lat": 40.03,
          //"lng": 140.03,
          //"dob": "2025-06-02T10:00:00.000Z",
          "firstName": nameTEC.value.text,
          "phone": phoneTEC.value.text,
        };

        if (kDebugMode) {
          print("Edit Profile Data Field: $dataFields");
        }

        // Serialize the map to a JSON string
        String jsonData = jsonEncode(dataFields);
        request.fields['data'] = jsonData;

        var imageFile = profileImage.value!;
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile(
          'image',
          stream,
          length,
          filename: basename(imageFile.path),
        );
        request.files.add(multipartFile);

        final response = await request.send();
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          showSnackBar(true, 'profile_updated_successfully'.tr);
          Get.offAll(() => BottomNavbar());
        } else {
          showSnackBar(false, 'profile_update_failed'.tr);
        }

      } catch (e) {
        showSnackBar(false, 'at_catch'.trArgs([e.toString()]));
      } finally {
        isUpdateProfileLoading.value = false;
      }








    // try {
    //   final token = await SharedPreferencesHelper.getAccessToken();
    //   if (token == null) {
    //     Get.snackbar('Auth Error', 'No access token found');
    //     return;
    //   }
    //
    //   var request = http.MultipartRequest('PUT', Uri.parse(Urls.updateProfile));
    //   request.headers['Authorization'] = token;
    //   request.headers["Content-Type"] = "application/json";
    //
    //   Map<String, dynamic> dataFields = {
    //     //"address": "Dattapara",
    //     //"lat": 40.03,
    //     //"lng": 140.03,
    //     //"dob": "2025-06-02T10:00:00.000Z",
    //     "firstName": nameController.text.trim(),
    //     //"lastName": "Islam",
    //     "phone": phoneController.text.trim(),
    //   };
    //
    //   if (kDebugMode) {
    //     print("Edit Profile Data Field: $dataFields");
    //   }
    //
    //   // Serialize the map to a JSON string
    //   String jsonData = jsonEncode(dataFields);
    //   request.fields['data'] = jsonData;
    //
    //   var imageFile = profileImage.value!;
    //   var stream = http.ByteStream(imageFile.openRead());
    //   var length = await imageFile.length();
    //   var multipartFile = http.MultipartFile(
    //     'image',
    //     stream,
    //     length,
    //     filename: basename(imageFile.path),
    //   );
    //   request.files.add(multipartFile);
    //
    //   final response = await request.send();
    //   final responseBody = await response.stream.bytesToString();
    //
    //   if (response.statusCode == 200) {
    //     showSnackBar(true, 'Profile updated successfully');
    //     Get.offAll(() => WrNavBarView());
    //   } else {
    //     showSnackBar(false, "Profile update failed");
    //   }
    //
    // } catch (e) {
    //   showSnackBar(false, "At Catch: ${e.toString()}");
    // } finally {
    //   isUpdateProfileLoading.value = false;
    // }
  }














  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      dobTEC.value.text = _formatDate(pickedDate);
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void clearImage() {
    profileImage.value = null;
    imageSizeText.value = '';
    uploadProgress.value = 0.0;
  }

  @override
  void dispose() {
    super.dispose();
    nameTEC.value.dispose();
    phoneTEC.value.dispose();
    dobTEC.value.dispose();
  }
}
