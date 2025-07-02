import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/controller/auth_controller.dart';


import '../../../../../core/const/app_loader.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final AuthController controller = Get.put(AuthController());

  // void _submit(BuildContext context) {
  //   // Optional validation (if needed)
  //   // final newPassword = controller.passwordController.text.trim();
  //   // final confirmPassword = confirmPasswordController.text.trim();
  //
  //   // if (newPassword.isEmpty || confirmPassword.isEmpty) {
  //   //   Get.snackbar('Input Required', 'Please fill out all fields!',
  //   //     backgroundColor: Colors.red, colorText: Colors.white);
  //   //   return;
  //   // }
  //
  //   // if (newPassword != confirmPassword) {
  //   //   Get.snackbar('Mismatch', 'Passwords do not match!',
  //   //     backgroundColor: Colors.red, colorText: Colors.white);
  //   //   return;
  //   // }
  //
  //   showSuccessDialog(
  //     buttonText: 'Done',
  //     context: context,
  //     title: 'Success',
  //     message: 'Your password is successfully changed!',
  //     image: Image.asset('assets/images/tick.png', height: 70.h, width: 70.w),
  //     onDonePressed: () {
  //       Get.off(() => LoginScreen());
  //     },
  //   );
  // }

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
              CustomAppBar(title: 'Change Password'),

              SizedBox(height: 30.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Obx(
                      () => CustomTextField(
                    fillColor: Colors.white,
                    borderSide: BorderSide(
                      color: Color(0xFF8C8482).withOpacity(0.20),
                    ),
                    prefixIconPath: 'assets/images/lock.png',
                    //width: screenWidth * 0.9,
                    hitText: 'Current Password',
                    textEditingController: controller.changeOldPasswordController,
                    fontSize: fontSize16,
                    fontWeight: FontWeight.w400,
                    lineHeight: lineHeightFactor,
                    obscureText: !controller.isPasswordVisible.value,
                    isForPassword: true,
                    onSuffixIconTap: () {
                      controller.togglePasswordVisibility();
                    },

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
                    //width: screenWidth * 0.9,
                    hitText: 'New Password',
                    textEditingController: controller.changeNewPasswordController,
                    fontSize: fontSize16,
                    fontWeight: FontWeight.w400,
                    lineHeight: lineHeightFactor,
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    isForPassword: true,
                    onSuffixIconTap: () {
                      controller.toggleConfirmPasswordVisibility();
                    },
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
              // SizedBox(height: 10.h),
              // // Confirm Password Field
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.w),
              //   child: Obx(
              //         () => CustomTextField(
              //       fillColor: Colors.white,
              //       borderSide: BorderSide(
              //         color: Color(0xFFACACAC).withOpacity(0.20),
              //       ),
              //       prefixIconPath: 'assets/images/lock.png',
              //       width: screenWidth * 0.9,
              //       hitText: 'Confirm Password',
              //       textEditingController: confirmPasswordController,
              //       fontSize: fontSize16,
              //       fontWeight: FontWeight.w400,
              //       lineHeight: lineHeightFactor,
              //       obscureText: !controller.isPasswordVisible.value,
              //       // suffixIcon: IconButton(
              //       //   icon: Icon(
              //       //     controller.isPasswordVisible.value
              //       //         ? Icons.visibility_off
              //       //         : Icons.visibility,
              //       //     color: const Color(0xff6E32A5).withAlpha(160),
              //       //   ),
              //       //   onPressed: controller.togglePasswordVisibility,
              //       // ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 250.h),

              Obx(() {
                return controller.isChangePasswordLoading.value ? loader() : CustomButton(
                  onPressed: () {
                    controller.changePassword();

                  },
                  text: 'Update',
                  // borderColor: Color(0xFF1F3892),
                  textColor: Colors.white,
                  backgroundColor: appGreenColor,
                  width: screenWidth * 0.9,
                  borderRadius: 10,
                );
              }),

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
