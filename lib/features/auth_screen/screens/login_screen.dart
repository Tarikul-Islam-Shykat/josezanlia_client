import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/screens/forget_pasword_screen.dart';
import '../../../core/const/app_loader.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());
  LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    image: const AssetImage(ImagePath.loginLogo),
                    height: 130.h,
                    width: 240.w,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  // Phone and Password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        borderSide: BorderSide(
                          color: const Color(
                            0xFFACACAC,
                          ).withValues(alpha: 0.20),
                        ),
                        fillColor: const Color(0xFFFFFFFF),
                        prefixIconPath: 'assets/images/timer.png',
                        textEditingController: controller.emailOrPhoneController,
                        keyboardType: TextInputType.emailAddress,
                        hitText: 'Email',
                        // keyboardType: TextInputType.phone,
                        // validator: _phoneValidator, // Commented out per request

                      ),
                      SizedBox(height: 15.h),
                      Obx(
                        () => CustomTextField(
                          borderSide: BorderSide(
                            color: const Color(
                              0xFFACACAC,
                            ).withValues(alpha: 0.20),
                          ),
                          fillColor: const Color(0xFFFFFFFF),
                          prefixIconPath: 'assets/images/lock.png',
                          textEditingController:
                              controller.passwordController,
                          hitText: 'Password',
                          obscureText: !controller.isPasswordVisible.value,
                          keyboardType: TextInputType.visiblePassword,
                          isForPassword: true,
                          onSuffixIconTap: () {
                            controller.togglePasswordVisibility();
                          },




                          // validator: _passwordValidator, // Commented out per request

                          // suffixIcon: IconButton(
                          //   icon: Icon(
                          //     controller.isPasswordVisible.value
                          //         ? Icons.visibility
                          //         : Icons.visibility_off,
                          //     color: const Color(0xFF4A4F5E),
                          //   ),
                          //   onPressed: controller.togglePasswordVisibility,
                          // ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        // Get.to(ResetPassword(phone: controller.phoneController.text));
                        Get.to(ForgetPasswordScreen());
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFF9B9B9B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Obx(() {
                    return controller.isLoginLoading.value ? loader() : CustomButton(
                      width: screenWidth * 0.9,
                      borderRadius: 10,
                      backgroundColor: const Color(0xFF0B3A3D),
                      text: 'Log in',
                      onPressed: () {
                        controller.loginUser();
                      },
                    );
                  }),
                  //   // this code is for only login validation
                  // Obx(
                  //   () => CustomButton(
                  //     onPressed: controller.isLoading.value ? () {} : _submit,
                  //     text:
                  //         controller.isLoading.value
                  //             ? 'Logging in...'
                  //             : 'Login',
                  //     textColor: Colors.white,
                  //     backgroundColor: const Color(0xFF0B3A3D),
                  //   width: screenWidth * 0.9,
                  //   borderRadius: 10,
                  //   ),
                  // ),
                  // SizedBox(height: screenHeight * 0.02),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Don’t have an account yet? ',
                  //       style: TextStyle(
                  //         fontSize: 14.sp,
                  //         color: const Color(0xFF4A4F5E),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Get.to(SignUpScreen());
                  //       },
                  //       child: Text(
                  //         'Sign Up',
                  //         style: TextStyle(
                  //           fontSize: 14.sp,
                  //           color: const Color(0xFF1F3892),
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
