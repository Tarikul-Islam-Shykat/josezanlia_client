import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/features/Auth_Screen/screens/login_screen.dart';
import 'package:prettyrini/features/Auth_Screen/screens/sign_up_screen.dart';

class SigninLoginScreen extends StatelessWidget {
  const SigninLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFCCD3E4),
      body: Column(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0,
                  vertical: screenHeight * 0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/splash1.png',
                      width: screenWidth,
                    ),
                    SizedBox(height: 30.h),

                    Image.asset(
                      'assets/images/only_logo.png',
                      height: 40.h,
                      width: 40.w,
                    ),
                    SizedBox(height: 30.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4F5E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'rMembr',
                          style: TextStyle(
                            color: Color(0xFF1F3892),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    Text(
                      'Capture the past, embrace the present, \nshare memories that connect hearts',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xFF4A4F5E),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    Column(
                      children: [
                        CustomButton(
                          onPressed: () {
                            Get.to(LoginScreen());
                          },
                          text: 'Log in',
                          // borderColor: Color(0xFF1F3892),
                          textColor: Color(0xFFFFFFFF),
                          backgroundColor: Color(0xFF1F3892),
                          width: screenWidth * 0.9,
                          borderRadius: 30,
                        ),
                        SizedBox(height: 15.h),

                        CustomButton(
                          onPressed: () {
                            Get.to(SignUpScreen());
                          },
                          text: 'Sign Up',
                          // borderColor: Color(0xFF1F3892),
                          textColor: Color(0xFF1F3892),
                          backgroundColor: Colors.white,
                          width: screenWidth * 0.9,
                          borderRadius: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
