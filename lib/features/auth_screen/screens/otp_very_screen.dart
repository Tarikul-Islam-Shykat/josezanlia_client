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
import '../../../core/const/app_loader.dart';
import '../controller/forget_pasword_controller.dart';

class OTPVerificationScreen extends StatelessWidget {

  OTPVerificationScreen({super.key});
  final ForgetPasswordController controller = Get.put(ForgetPasswordController());
  final String? email = Get.arguments["email"];

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



                SizedBox(height: 100.h),
                Obx(() {
                  return controller.isLoading.value
                      ? loader()
                      : CustomButton(
                    onPressed: () {
                      controller.verifyOTP(email.toString());

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
