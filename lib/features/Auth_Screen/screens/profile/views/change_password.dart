import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/screens/profile/controller/change_password_controller.dart';
import 'package:prettyrini/features/Auth_Screen/screens/profile/views/profile_screen.dart';

class ChangePassword extends StatelessWidget {
  final controller = Get.put(ChangePasswordController());
  ChangePassword({super.key});

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialize text controllers with current values
    currentPasswordController.text = controller.currentPassword.value;
    newPasswordController.text = controller.newPassword.value;
    confirmPasswordController.text = controller.confirmPassword.value;

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(title: 'Change Password'),

              SizedBox(height: 30.h),
              CustomTextField(
                hitText: 'Current Password',
                borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                fillColor: Colors.white,
                width: screenWidth * 0.9,
                textEditingController: currentPasswordController,
                obscureText: true,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                hitText: 'New Password',
                borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                fillColor: Colors.white,
                width: screenWidth * 0.9,
                textEditingController: newPasswordController,
                obscureText: true,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                hitText: 'Confirm Password',
                borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                fillColor: Colors.white,
                width: screenWidth * 0.9,
                textEditingController: confirmPasswordController,
                obscureText: true,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 150.h),
              CustomButton(
                backgroundColor: const Color(0xFF0B3A3D),
                width: screenWidth * 0.9,
                onPressed: () {
                  Get.to(() => ProfileScreen());
                  final success = controller.updatePassword(
                    currentPassword: currentPasswordController.text,
                    newPassword: newPasswordController.text,
                    confirmPassword: confirmPasswordController.text,
                  );
                  if (success) {
                    Get.snackbar('Success', 'Password updated successfully');
                  }
                },
                text: 'Update',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
