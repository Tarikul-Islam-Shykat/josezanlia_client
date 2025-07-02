import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'dart:io';

import '../../../../../core/global_widegts/custom_snack_bar.dart';
import '../../../../../core/repository/network_caller/endpoints.dart';
import '../../../../../core/repository/services_class/local_service/shared_preferences_helper.dart';

// class ProfileController extends GetxController {
//   var userName = 'Michel Adam'.obs;
//   var phoneNumber = '01813277700'.obs;
//   var profileImage = Rxn<File>();
//
//   void updateProfileImage(File image) {
//     profileImage.value = image;
//     log('Profile image updated: ${image.path}');
//   }
//
//   void updateProfile({String? name, String? phone}) {
//     if (name != null && name.isNotEmpty) {
//       userName.value = name;
//     }
//     if (phone != null && phone.isNotEmpty) {
//       phoneNumber.value = phone;
//     }
//     log(
//       'Profile updated - Name: ${userName.value}, Phone: ${phoneNumber.value}',
//     );
//   }
// }


class ProfileController extends GetxController {
  RxString userName = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString userImage = ''.obs;
  final isUpdateProfileLoading = false.obs;
  var profileImage = Rxn<File>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void updateProfileImage(File image) {
    profileImage.value = image;
    log('Profile image updated: ${image.path}');
  }

  void updateProfile() async {
    log(
      'Profile updated - Name: ${userName.value}, Phone: ${phoneNumber.value}',
    );

    if (profileImage.value == null) {
      showSnackBar(false, 'Please select an image');
      return;
    }

    isUpdateProfileLoading.value = true;

    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null) {
        Get.snackbar('Auth Error', 'No access token found');
        return;
      }

      var request = http.MultipartRequest('PUT', Uri.parse(Urls.updateProfile));
      request.headers['Authorization'] = token;
      request.headers["Content-Type"] = "application/json";

      Map<String, dynamic> dataFields = {
        //"address": "Dattapara",
        //"lat": 40.03,
        //"lng": 140.03,
        //"dob": "2025-06-02T10:00:00.000Z",
        "firstName": nameController.text.trim(),
        //"lastName": "Islam",
        "phone": phoneController.text.trim(),
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
        showSnackBar(true, 'Profile updated successfully');
        Get.offAll(() => BottomAppBar());
      } else {
        showSnackBar(false, "Profile update failed");
      }

    } catch (e) {
      showSnackBar(false, "At Catch: ${e.toString()}");
    } finally {
      isUpdateProfileLoading.value = false;
    }
  }

  @override
  void onInit() {

    if (kDebugMode) {
      print("WrProfileController initialized");
    }




    // TODO: implement onInit

    //getDataFromSharePref();

    super.onInit();
  }

  void getDataFromSharePref() async {
    userName.value = await SharedPreferencesHelper.getUserFirstName() ?? '';
    phoneNumber.value =
        await SharedPreferencesHelper.getUserPhoneNumber() ?? '';
    userImage.value = await SharedPreferencesHelper.getUserProfileImage() ?? '';



    if (kDebugMode) {
      print("Profile User Profile Image at Profile Controller: ${await SharedPreferencesHelper.getUserProfileImage()}");
    }




    nameController.text = userName.value;
    phoneController.text = phoneNumber.value;

    if (kDebugMode) {
      print("Profile Edit User Name: ${userName.value}");
      print("Profile Edit User Phone Number: ${phoneNumber.value}");
      print("Profile Edit User Image: ${userImage.value}");
    }
  }
}
