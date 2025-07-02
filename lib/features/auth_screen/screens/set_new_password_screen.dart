
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/controller/auth_controller.dart';
import 'package:prettyrini/features/Auth_Screen/screens/login_screen.dart';
import 'package:prettyrini/features/Auth_Screen/screens/utils/show_success_dialog.dart';

import '../../../core/const/app_loader.dart';
import '../../../core/global_widegts/custom_snack_bar.dart';
import '../controller/reset_pass_controller.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key});
  final ResetPassController controller = Get.put(ResetPassController());
  final String email = Get.arguments["email"];

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

                    hitText: 'New Password',
                    textEditingController: controller.newPass,
                    fontSize: fontSize16,
                    fontWeight: FontWeight.w400,
                    lineHeight: lineHeightFactor,
                    obscureText: !controller.isPasswordVisible.value,
                    isForPassword: true,
                    onSuffixIconTap: () {
                      controller.togglePasswordVisibility();
                    },
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

                    hitText: 'Confirm Password',
                    textEditingController: controller.conPass,
                    fontSize: fontSize16,
                    fontWeight: FontWeight.w400,
                    lineHeight: lineHeightFactor,
                    obscureText: !controller.isPasswordVisible.value,
                    isForPassword: true,
                    onSuffixIconTap: () {
                      controller.toggleConfirmPasswordVisibility();
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xff6E32A5).withAlpha(160),
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 250.h),

              Obx(() {
                return controller.isLoading.value ? loader() : CustomButton(
                  onPressed: () {
                    if (controller.newPass.text.isEmpty) {
                      showSnackBar(false, 'New password cannot be empty.');
                    } else if (controller.newPass.text.length < 8) {
                      showSnackBar(false, 'New password must be at least 8 characters long.');
                    } else if (controller.conPass.text.isEmpty) {
                      showSnackBar(false, 'Confirm password cannot be empty.');
                    } else if (controller.conPass.text.length < 8) {
                      showSnackBar(false, 'Confirm password must be at least 8 characters long.');
                    } else if (controller.newPass.text != controller.conPass.text) {
                      showSnackBar(false, 'Passwords do not match.');
                    }
                    else {
                      controller.resetPass(email.toString(),context);
                    }
                  },
                  text: 'Change Password',
                  // borderColor: Color(0xFF1F3892),
                  textColor: Colors.white,
                  backgroundColor: appGreenColor,
                  width: screenWidth * 0.9,
                  borderRadius: 10,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
