import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var fileName = ''.obs;
  var isLoading = false.obs;

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final regExp = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$');
    return regExp.hasMatch(value) ? null : 'Enter a valid email address';
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      fileName.value = result.files.single.name;
    } else {
      Get.snackbar('Error', 'No file selected', backgroundColor: Colors.red);
    }
  }

  Future<void> saveData() async {
    isLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameController.text);
    prefs.setString('email', emailController.text);
    prefs.setString('phone', phoneController.text);
    prefs.setString('dob', dobController.text);
    prefs.setString('password', passwordController.text);
    prefs.setString('confirmPassword', confirmPasswordController.text);
    prefs.setString('profile', 'Personal Use');

    await Future.delayed(Duration(seconds: 2));

    isLoading.value = false;
    Get.snackbar(
      'Success',
      'Account created successfully!',

      backgroundColor: Colors.green,
    );
  }
}
