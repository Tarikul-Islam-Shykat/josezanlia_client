import 'dart:developer';

import 'package:get/get.dart';
import 'dart:io';

class ChangePasswordController extends GetxController {
  var currentPassword = ''.obs;
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;
  var profileImage = Rxn<File>();

  bool updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    /*
    if (newPassword.isEmpty ||
        confirmPassword.isEmpty ||
        currentPassword.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return false;
    }
    if (newPassword != confirmPassword) {
      Get.snackbar('Error', 'New password and confirm password do not match');
      return false;
    }
    if (newPassword.length < 6) {
      Get.snackbar('Error', 'New password must be at least 6 characters long');
      return false;
    }
    */
    // Simulate password update logic (e.g., API call)
    this.currentPassword.value = currentPassword;
    this.newPassword.value = newPassword;
    this.confirmPassword.value = confirmPassword;
    log('Password updated - Current: $currentPassword, New: $newPassword');
    return true;
  }
}
