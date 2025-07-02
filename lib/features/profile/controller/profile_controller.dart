import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prettyrini/features/profile/controller/user_info_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/global_widegts/app_snackbar.dart';
import '../../../core/repository/network_caller/endpoints.dart';


class EditProfileController extends GetxController{
  Rx<TextEditingController> nameTEC = TextEditingController().obs;
  Rx<TextEditingController> phoneTEC = TextEditingController().obs;
  Rx<TextEditingController> dobTEC = TextEditingController().obs;
  final UserProfileController userController = Get.put(UserProfileController());

  final _picker = ImagePicker();
  RxBool isUploading = false.obs;
  var uploadProgress =0.0.obs;
  var imageSizeText ="".obs;
  Rx<File?>profileImage = Rx<File?>(null);


  Future<void> pickProfileImage()async{
    try{
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if(pickedFile !=null){
        File imageFile = File(pickedFile.path);

        File? compressedImage = await _compressImage(imageFile);
        if(compressedImage != null){
          profileImage.value = compressedImage;
          await _updateImageSizeText(compressedImage);
          AppSnackbar.show(message: "Profile picture selected success", isSuccess: true);
        }else{
          log("Failed to compress image");
        }
      }
    }catch(e){
      log("Failed Pick Image ${e.toString()}");
    }
  }

  Future<void> pickProfileImageFormCamera()async{
    try{
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if(pickedFile != null){
        File imageFile = File(pickedFile.path);

        File? compressedImage = await _compressImage(imageFile);
        if(compressedImage != null){
          profileImage.value = compressedImage;
          await _updateImageSizeText(compressedImage);
          AppSnackbar.show(message: "Profile picture captured successfully", isSuccess: true);
        }else{
          log("Failed to compress image");
        }
      }
    }catch(e){
      log("Failed capturing profile image ${e.toString()}");
    }
  }

  Future<File?>_compressImage(File imageFile)async{
    try{
      int originalSize = await imageFile.length();
      log("Original image size:${(originalSize/1024).toStringAsFixed(2)} KB");
      if(originalSize<= 250 * 1024){
        return imageFile;
      }

      String targetPath = imageFile.path.
      replaceAll(".jpg", "_compressed.jpg").
      replaceAll("jpeg", "_compressed.jpeg").
      replaceAll("png", "_compressed.jpg");

      Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: 800,
        minHeight: 800,
        quality: 85,
        format: CompressFormat.jpeg,
      );
      if(compressedBytes == null){
        log("Failed to compress image");
        return null;
      }

      //if still to large try with lower quality
      int currentSize = compressedBytes.length;
      int quality = 85;
      while (currentSize> 250 * 1024 && quality>50){
        quality -=10;
        log("Trying with quality:${quality}");
        compressedBytes = await FlutterImageCompress.compressWithFile(
          imageFile.absolute.path,
          minWidth: 600,
          minHeight: 600,
          quality: quality,
          format: CompressFormat.jpeg,
        );
        if(compressedBytes != null){
          currentSize = compressedBytes.length;
        }else{
          break;
        }
      }
      if(compressedBytes == null){
        log("failed to compress image to required size");
        return null;
      }
      // Write compressed image to file
      File compressedFile = File(targetPath);
      await compressedFile.writeAsBytes(compressedBytes);

      int finalSize = compressedBytes.length;
      log("Compressed image size: ${(finalSize / 1024).toStringAsFixed(2)} KB");

      return compressedFile;
    }catch(e){
      log("Error compressing image: $e");
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
    } catch (e) {
      imageSizeText.value = "Size unknown";
    }
  }


  Future<bool> uploadProfileImage()async{
    if(profileImage.value == null){
      AppSnackbar.show(message: "Please select a Picture", isSuccess: false);
      return false;
    }
    try{
      isUploading.value = true;
      final request = http.MultipartRequest(
          "PUT", 
          Uri.parse("${Urls.updateProfile}/${userController.userProfile.value.consumer!.first.id}")
      );
      SharedPreferences local = await SharedPreferences.getInstance();
      String? token = local.getString("token");

      request.headers.addAll({
        "Content-Type":"multipart/form-data",
        "Authorization": "$token"
      });
      DateTime parsedDob = DateFormat("dd/MM/yyyy").parse(dobTEC.value.text);
      var dobIso = parsedDob.toUtc().toIso8601String();
      Map<String,dynamic> userData ={
        "dob": dobIso,
        "firstName": nameTEC.value.text,
        "phone":phoneTEC.value.text

      };
      log("Profile picture upload request $userData");
      request.fields["data"] = jsonEncode(userData);

      var imageBytes = await profileImage.value!.readAsBytes();

      var multipartFile = http.MultipartFile.fromBytes(
        "image",
        imageBytes,
        filename: "profile_${DateTime.now().millisecondsSinceEpoch}.jpg",
      );
      request.files.add(multipartFile);

      var streamedResponse = await request.send();
      for(int i = 0; i<=100;i +=10){
        uploadProgress.value = i.toDouble();
        await Future.delayed(Duration(milliseconds: 50));
      }
      final response =await http.Response.fromStream(streamedResponse);
      final responseJson = jsonDecode(response.body);
      log("Profile picture upload response $responseJson");
      log("Status code ${response.statusCode}");
      if((response.statusCode == 200 || response.statusCode == 201) && responseJson["success"]== true){
        AppSnackbar.show(message: "Profile picture Upload success", isSuccess: true);
        Get.back();
        clearImage();

        return true;
      }else{
        AppSnackbar.show(message: "${responseJson["message"]}", isSuccess: false);
        log("failed :${responseJson["message"]}");
        return false;
      }
    }catch(e){
      log("Failed to Update ${e.toString()}");
      return false;
    }finally{
      isUploading.value = false;
    }
  }





  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  void pickDate(BuildContext context)async{
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if(pickedDate != null){
      selectedDate.value = pickedDate;
      dobTEC.value.text = _formatDate(pickedDate);
    }

  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
  // Clear selected image
  void clearImage() {
    profileImage.value = null;
    imageSizeText.value = '';
    uploadProgress.value = 0.0;
  }

  @override
  void dispose() {
    super.dispose();
    nameTEC.value.dispose();
    dobTEC.value.dispose();
  }

}



