import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/features/Auth_Screen/controller/auth_controller.dart';
import 'package:prettyrini/features/Auth_Screen/screens/set_new_password_screen.dart';

import '../../../core/const/app_loader.dart';

class OTPVerificationScreen extends StatelessWidget {
  final controller = Get.find<AuthController>();

  OTPVerificationScreen({super.key});




  // OTP validation
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFE9EBF0),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                CustomAppBar(title: 'Verification Code', onBackPressed: () {
                  controller.otpController.clear();
                },),

                SizedBox(height: 30.h),
                // OTP input using Pinput
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Pinput(
                    controller: controller.otpController,
                    length: 4,
                    defaultPinTheme: controller.defaultPinTheme,
                    onCompleted: (pin) {
                      if (kDebugMode) {
                        log('OTP entered: $pin');
                      }
                    },
                  ),
                ),

                Obx(() {
                  return controller.isResendVisible.value
                      ? GestureDetector(
                    onTap: () {
                      controller.resendOTP();
                    },
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Color(0xFF1F3892),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : Text(
                    "Resend code in ${controller.formattedTime}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  );
                }),


                SizedBox(height: 100.h),

                // Verification button
                // ElevatedButton(
                //   onPressed: _verifyOTP,
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color(0xFF1F3892),
                //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //   ),
                //   child: Text(
                //     'Verification',
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                Obx(() {
                  return controller.isVerifyOTPLoading.value
                      ? loader()
                      : CustomButton(
                    // onPressed: _submit,
                    onPressed: () {
                      controller.verifyOTP();

                      // controller.resendOTP();

                      //Get.to(() => SetNewPasswordScreen());
                    },
                    text: 'Verify',
                    // borderColor: Color(0xFF1F3892),
                    textColor: Colors.white,
                    backgroundColor: appGreenColor,
                    width: screenWidth * 0.9,
                    borderRadius: 10,
                  );
                }),
                SizedBox(height: screenHeight * 0.03),

                // Resend OTP link
              ],
            ),

          ),
        ),
      ),
    );
  }
}

void _resendOTP() {
  if (kDebugMode) {
    log('Resending OTP...');
  }
}
