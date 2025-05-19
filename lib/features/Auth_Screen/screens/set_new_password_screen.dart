// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/controller/login_controller.dart';
import 'package:prettyrini/features/Auth_Screen/screens/login_screen.dart';
import 'package:prettyrini/features/Auth_Screen/screens/utils/show_success_dialog.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key});

  final LoginController controller = Get.put(LoginController());
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void _submit(BuildContext context) {
    // Optional validation (if needed)
    // final newPassword = controller.passwordController.text.trim();
    // final confirmPassword = confirmPasswordController.text.trim();

    // if (newPassword.isEmpty || confirmPassword.isEmpty) {
    //   Get.snackbar('Input Required', 'Please fill out all fields!',
    //     backgroundColor: Colors.red, colorText: Colors.white);
    //   return;
    // }

    // if (newPassword != confirmPassword) {
    //   Get.snackbar('Mismatch', 'Passwords do not match!',
    //     backgroundColor: Colors.red, colorText: Colors.white);
    //   return;
    // }

    showSuccessDialog(
      context: context,
      title: 'Success',
      message: 'Your password is successfully changed!',
      image: Image.asset('assets/images/tick.png', height: 70.h, width: 70.w),
      onDonePressed: () {
        Get.off(() => LoginScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize16 = screenWidth * 0.041;
    final lineHeightFactor = 1.5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(title: 'Set New Password'),

              SizedBox(height: 30.h),

              // Password Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Obx(
                  () => CustomTextField(
                    fillColor: Colors.white,
                    borderSide: BorderSide(
                      color: Color(0xFF8C8482).withOpacity(0.20),
                    ),
                    prefixIconPath: 'assets/images/lock.png',
                    width: screenWidth * 0.9,
                    hitText: 'New Password',
                    textEditingController: controller.passwordController,
                    fontSize: fontSize16,
                    fontWeight: FontWeight.w400,
                    lineHeight: lineHeightFactor,
                    obscureText: !controller.isPasswordVisible.value,
                    // suffixIcon: IconButton(
                    //   icon: Icon(
                    //     controller.isPasswordVisible.value
                    //         ? Icons.visibility_off
                    //         : Icons.visibility,
                    //     color: const Color(0xff6E32A5).withAlpha(160),
                    //   ),
                    //   onPressed: controller.togglePasswordVisibility,
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              // Confirm Password Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(
                  () => CustomTextField(
                    fillColor: Colors.white,
                    borderSide: BorderSide(
                      color: Color(0xFFACACAC).withOpacity(0.20),
                    ),
                    prefixIconPath: 'assets/images/lock.png',
                    width: screenWidth * 0.9,
                    hitText: 'Confirm Password',
                    textEditingController: confirmPasswordController,
                    fontSize: fontSize16,
                    fontWeight: FontWeight.w400,
                    lineHeight: lineHeightFactor,
                    obscureText: !controller.isPasswordVisible.value,
                    // suffixIcon: IconButton(
                    //   icon: Icon(
                    //     controller.isPasswordVisible.value
                    //         ? Icons.visibility_off
                    //         : Icons.visibility,
                    //     color: const Color(0xff6E32A5).withAlpha(160),
                    //   ),
                    //   onPressed: controller.togglePasswordVisibility,
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 250.h),

              CustomButton(
                onPressed: () => _submit(context),
                text: 'Change Password',
                // borderColor: Color(0xFF1F3892),
                textColor: Colors.white,
                backgroundColor: Color(0xFF0B3A3D),
                width: screenWidth * 0.9,
                borderRadius: 10,
              ),

              // Submit Button
              // CustomButton(
              //   backgroundColor: Color(0xFF0B3A3D),
              //   onPressed: () {
              //     if (controller.passwordController.text.isEmpty ||
              //         confirmPasswordController.text.isEmpty) {
              //       Get.snackbar('Error', 'Both fields are required');
              //       return;
              //     }
              //     if (controller.passwordController.text !=
              //         confirmPasswordController.text) {
              //       Get.snackbar('Error', 'Passwords do not match');
              //       return;
              //     }
              //     // Get.to(() => OTPVerificationScreen());
              //     Get.to(() => SuccessScreen());
              //   },
              //   text: 'Save',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
