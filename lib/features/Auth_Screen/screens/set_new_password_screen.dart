// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/controller/login_controller.dart';
import 'package:prettyrini/features/Auth_Screen/screens/login_screen.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key});

  final LoginController controller = Get.put(LoginController());
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void _submit(BuildContext context) {
    // below this part is for only validation
    // final newPassword = controller.passwordController.text.trim();
    // final confirmPassword = confirmPasswordController.text.trim();

    // if (newPassword.isEmpty || confirmPassword.isEmpty) {
    //   Get.snackbar(
    //     'Input Required',
    //     'Please fill out all fields!',
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: Colors.redAccent,
    //     colorText: Colors.white,
    //   );
    //   return;
    // }

    // if (newPassword != confirmPassword) {
    //   Get.snackbar(
    //     'Mismatch',
    //     'Passwords do not match!',
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: Colors.redAccent,
    //     colorText: Colors.white,
    //   );
    //   return;
    // }

    // Show success dialog if all validations pass
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/tick.png',
                  height: 70.h,
                  width: 70.w,
                ),
                SizedBox(height: 10.h),
                Text(
                  'Success',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Your password is successfully changed!',
                  style: TextStyle(fontSize: 16.sp, color: Color(0xFF4A4F5E)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  width: screenWidth * 0.65,
                  backgroundColor: Color(0xFF0B3A3D),
                  borderRadius: 10,
                  text: 'Done',
                  onPressed: () {
                    Get.off(() => LoginScreen());
                  },
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        );
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
