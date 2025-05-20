// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/screens/otp_very_screen.dart';

import '../controller/login_controller.dart';
import 'login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final LoginController controller = Get.put(LoginController());
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // String? _passwordValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your password';
  //   }
  //   if (value.length < 6) {
  //     return 'Password must be at least 6 characters';
  //   }
  //   return null;
  // }

  // String? _confirmPasswordValidator(String? value) {
  //   if (value != newPasswordController.text) {
  //     return 'Passwords do not match';
  //   }
  //   return null;
  // }

  // void _submit() {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           backgroundColor: Colors.transparent,
  //           child: Container(
  //             padding: EdgeInsets.all(20),
  //             width: double.maxFinite,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Image.asset(
  //                   'assets/images/tick.png',
  //                   height: 60.h,
  //                   width: 60.w,
  //                 ),
  //                 SizedBox(height: 20.h),

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
  //     Get.snackbar(
  //       'Input Required',
  //       'Please fill out all fields correctly!',
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.redAccent,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar(title: 'Reset Password'), // Text(
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
                  textEditingController: phoneController,
                  hitText: 'Phone Number',
                  // bacgroundColor: Colors.white,
                  // validator: _passwordValidator,
                  obscureText: true,
                  width: screenWidth * 0.9,
                ),
                SizedBox(height: 250.h),

                SizedBox(height: 80.h),

                CustomButton(
                  // onPressed: _submit,
                  onPressed: () {
                    Get.to(
                      () => OTPVerificationScreen(
                        Phone: controller.phoneController.text,
                      ),
                    );
                    Get.snackbar(
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      'OTP Send',
                      'Please check your device',
                    );
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
      ),
    );
  }
}
