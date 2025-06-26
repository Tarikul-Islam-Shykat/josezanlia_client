// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/screens/otp_very_screen.dart';

import '../controller/auth_controller.dart';
import 'login_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final String email;
  final AuthController controller = Get.put(AuthController());

  ForgetPasswordScreen({this.email = "", super.key});


  @override
  Widget build(BuildContext context) {
    controller.emailOrPhoneController.value = TextEditingValue(text: email);
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(title: 'Reset Password', onBackPressed: () {
                Get.back();
              },), // Text(
              //   'Reset Password',
              //   style: TextStyle(
              //     fontSize: 28.sp,
              //     fontWeight: FontWeight.bold,
              //     color: Color(0xFF4A4F5E),
              //   ),
              // ),
              SizedBox(height: screenHeight * 0.05),

              // Phone Number
              CustomTextField(
                borderSide: BorderSide(
                  color: Color(0xFFACACAC).withValues(alpha: 0.20),
                ),
                fillColor: Color(0xFFFFFFFF),
                prefixIconPath: ImagePath.mail,
                textEditingController: controller.emailOrPhoneController,
                hitText: 'Phone Number',
                // bacgroundColor: Colors.white,
                // validator: _passwordValidator,
                obscureText: true,

              ),
              SizedBox(height: 250.h),

              SizedBox(height: 80.h),

              CustomButton(
                // onPressed: _submit,
                onPressed: () {






                  // Get.to(
                  //       () =>
                  //       OTPVerificationScreen(
                  //         Phone: controller.emailOrPhoneController.text,
                  //       ),
                  // );
                  // Get.snackbar(
                  //   backgroundColor: Colors.green,
                  //   colorText: Colors.white,
                  //   'OTP Send',
                  //   'Please check your device',
                  // );
                },
                text: 'Continue',
                // borderColor: Color(0xFF1F3892),
                textColor: Colors.white,
                backgroundColor: Color(0xFF0B3A3D),
                width: screenWidth * 0.9,
                borderRadius: 10,
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
