// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/screens/forget_pasword_screen.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  // Commented out validators per request
  /*
  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
      return 'Enter a valid phone number (10-15 digits)';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  */
  // below this code is for only validation
  /*
  void _submit() {
    // Since validators are commented out, directly call handleLogin
    // If validators are enabled later, uncomment the validation check
    
    if (_formKey.currentState?.validate() ?? false) {
      controller.handleLogin();
    } else {
      Get.snackbar(
        'Input Required',
        'Please fill out all fields correctly!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
    
    controller.handleLogin();
  }
  */

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Form(
                key: _formKey,
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
                          textEditingController: controller.phoneController,
                          hitText: 'Water Meter / Phone Number',
                          // keyboardType: TextInputType.phone,
                          // validator: _phoneValidator, // Commented out per request
                          width: screenWidth * 0.9,
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
                            // validator: _passwordValidator, // Commented out per request
                            width: screenWidth * 0.9,
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
                            color: Color(0xFF9B9B9B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CustomButton(
                      width: screenWidth * 0.9,
                      borderRadius: 10,
                      backgroundColor: const Color(0xFF0B3A3D),
                      text: 'Log in',
                      onPressed: () {},
                    ),
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
      ),
    );
  }
}
