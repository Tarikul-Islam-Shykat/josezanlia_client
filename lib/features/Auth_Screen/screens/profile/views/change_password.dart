import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/features/Auth_Screen/screens/profile/controller/profile_controller.dart';

class ChangePassword extends StatelessWidget {
  final controller = Get.put(ProfileController());
  ChangePassword({super.key});

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // currentPasswordController.text = controller.currentPassword.value;
    // newPasswordController.text = controller.newPassword.value;
    // confirmPasswordController.text = controller.confirmPassword.value;

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(backgroundColor: Colors.white);
  }
}
