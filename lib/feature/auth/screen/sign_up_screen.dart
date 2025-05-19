import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/style/global_text_style.dart';
import '../controller/signup_controller.dart';
import '../widget/custom_booton_widget.dart';
import '../widget/goggle_sign_in_button.dart';
import '../widget/ontap_row.dart';
import '../widget/text_field_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignInController controller = Get.put(SignInController());

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
                SizedBox(height: 24.h),
                CustomAuthField(
                  controller: controller.emailTEController,
                  hintText: 'Email',
                ),
                SizedBox(height: 16.h),
                Obx(
                  () => CustomAuthField(
                    obscureText: !controller.isPasswordVisible.value,
                    controller: controller.passwordTEController,
                    hintText: 'password',
                    suffixIcon: IconButton(
                      icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xff000000)
                            ..withValues(alpha: 0.38)),
                      onPressed: controller
                          .togglePasswordVisibility, // Toggle visibility
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      // Additional validation if needed
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Obx(
                  () => CustomAuthField(
                    obscureText: !controller.isConPasswordVisible.value,
                    controller: controller.conPasswordTEController,
                    hintText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                          controller.isConPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xff000000)
                            ..withValues(alpha: 0.38)),
                      onPressed: controller
                          .toggleConPasswordVisibility, // Toggle visibility
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      // Additional validation if needed
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 24.h),
                Obx(() => CustomButton(
                      onTap: () {
                        //Get.to(() => SubscriptionScreen());
                        controller.isLoading.value
                            ? null
                            : controller.handleSignUp();
                      },
                      title: controller.isLoading.value
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : Text('Sign Up',
                              style: globalTextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                    )),

                SizedBox(height: 12.h),
                // OR Divider
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Color(0xffC6C6C6),
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: globalTextStyle(color: Color(0xffD9D9D9)),
                        ),
                      ),
                      Expanded(child: Divider(color: Color(0xffC6C6C6))),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                // Google Sign In Button
                GoggleSignInButton(
                  onPressed: controller.handleGoogleSignUp,
                ),
                SizedBox(height: 12.h),
                OnTapRow(
                  onTap: () {
                    Get.back();
                  },
                  textOne: "have an account? ",
                  textTwo: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
