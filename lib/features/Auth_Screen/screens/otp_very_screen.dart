import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/features/Auth_Screen/screens/set_new_password_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String? phone;

  const OTPVerificationScreen({super.key, this.phone, required String Phone});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

void _resendOTP() {
  if (kDebugMode) {
    log('Resending OTP...');
  }
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 22, color: Color(0xFF4A4F5E)),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xFF4A4F5E), width: 1),
      borderRadius: BorderRadius.circular(12),
    ),
  );

  // OTP validation
  // void _verifyOTP() {
  //   String otp = _otpController.text;

  //   if (otp.length == 4) {
  //     if (kDebugMode) {
  //       print('OTP entered: $otp');
  //     }

  //     // Show Success Screen in a dialog
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           backgroundColor: Color(0xFFFFFFFF),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           content: Container(
  //             padding: EdgeInsets.all(20),
  //             width: double.maxFinite,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Success Icon
  //                 // CircleAvatar(
  //                 //   radius: 30,
  //                 //   backgroundColor: Color(0xFFE9EBF0),
  //                 //   child: Icon(Icons.check, color: Color(0xFF1F3892), size: 40),
  //                 // ),
  //                 Image.asset(
  //                   'assets/images/tick.png',
  //                   height: 60.h,
  //                   width: 60.w,
  //                 ),
  //                 SizedBox(height: 20.h),

  //                 // Success Text
  //                 Text(
  //                   'Success',
  //                   style: TextStyle(
  //                     fontSize: 20.sp,
  //                     fontWeight: FontWeight.bold,
  //                     color: Color(0xFF000000),
  //                   ),
  //                 ),
  //                 SizedBox(height: 10.h),
  //                 Text(
  //                   'Your verification was successful!',
  //                   style: TextStyle(fontSize: 16.sp, color: Color(0xFF4A4F5E)),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 SizedBox(height: 20.h),

  //                 // Continue Button
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     Get.back();
  //                     Get.to(LoginScreen());
  //                   },
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: Color(0xFF1F3892),
  //                     padding: EdgeInsets.symmetric(
  //                       horizontal: 60,
  //                       vertical: 15,
  //                     ),
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(30),
  //                     ),
  //                   ),
  //                   child: Text(
  //                     'Continue',
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } else {
  //     // Show error if OTP is not valid
  //     Get.snackbar(
  //       'Error',
  //       'Please enter a valid 4-digit OTP.',
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red,
  //     );
  //   }
  // }

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
                CustomAppBar(title: 'Verification Code'),

                SizedBox(height: 30.h),
                // OTP input using Pinput
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Pinput(
                    controller: _otpController,
                    length: 4,
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (pin) {
                      if (kDebugMode) {
                        log('OTP entered: $pin');
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Resend code in',
                      style: TextStyle(color: Color(0xFF9B9B9B)),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '00:12',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
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
                CustomButton(
                  // onPressed: _submit,
                  onPressed: () {
                    Get.to(() => SetNewPasswordScreen());
                  },
                  text: 'Verify',
                  // borderColor: Color(0xFF1F3892),
                  textColor: Colors.white,
                  backgroundColor: Color(0xFF0B3A3D),
                  width: screenWidth * 0.9,
                  borderRadius: 10,
                ),
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
