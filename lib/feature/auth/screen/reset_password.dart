import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/style/global_text_style.dart';

import '../controller/forget_pasword_controller.dart';

import '../widget/custom_booton_widget.dart';
import '../widget/text_field_widget.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final ForgetPasswordController controller =
      Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 90.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: 30,
                        width: 50,
                      ),
                      Text(
                        "Foot & Fitness",
                        style: globalTextStyle(
                          color: Color(0xff216CCE),
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 64.h),
                CustomAuthField(
                  controller: controller.passwordController,
                  hintText: 'password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    // Additional validation if needed
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                CustomAuthField(
                  controller: controller.rePasswordController,
                  hintText: 'Confirm Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    // Additional validation if needed
                    return null;
                  },
                ),
                SizedBox(height: 48.h),
                CustomButton(
                  onTap: () {
                    controller.resetPassword();
                  },
                  title: Text(
                    'Reset',
                    style:
                        globalTextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
