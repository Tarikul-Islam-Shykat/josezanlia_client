import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/style/global_text_style.dart';

import '../controller/forget_pasword_controller.dart';
import '../widget/custom_booton_widget.dart';
import '../widget/text_field_widget.dart';

class OtpVeryScreen extends StatelessWidget {
  OtpVeryScreen({super.key});

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
                  controller: controller.otpController,
                  hintText: 'OTP',
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Didn't get OTP? ",
                      style: globalTextStyle(
                          color: const Color(0xff000710),
                          fontWeight: FontWeight.w400,
                          fontSize: 12.h),
                    ),
                    InkWell(
                      onTap: () {
                        controller.sendemail();
                      },
                      child: Text(
                        'Resent',
                        style: globalTextStyle(
                            color: const Color(0xff000710),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.h),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48.h),
                CustomButton(
                  onTap: () {
                    controller.verifyOtp();
                  },
                  title: Text(
                    'Verify',
                    style: globalTextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
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
