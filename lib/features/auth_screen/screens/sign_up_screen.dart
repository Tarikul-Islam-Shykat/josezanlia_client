import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/controller/signup_controller.dart';
import 'package:prettyrini/features/Auth_Screen/screens/login_screen.dart';
import 'package:prettyrini/features/Auth_Screen/screens/otp_very_screen.dart';

class SignUpScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFE9EBF0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F3892),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Name
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Name', style: TextStyle(color: Color(0xFF4A4F5E))),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                hitText: 'Full Name',
                textEditingController: controller.nameController,
              ),
              SizedBox(height: 0.1.h),

              // Email
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(color: Color(0xFF4A4F5E)),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                hitText: 'Email',
                textEditingController: controller.emailController,
                // validator: controller.emailValidator,
              ),
              SizedBox(height: 0.1.h),

              // Phone
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Phone Number',
                  style: TextStyle(color: Color(0xFF4A4F5E)),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                hitText: 'Phone Number',
                textEditingController: controller.phoneController,
              ),
              SizedBox(height: 0.1.h),

              // Date of Birth
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Date of Birth',
                  style: TextStyle(color: Color(0xFF4A4F5E)),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                hitText: 'Date of Birth',
                textEditingController: controller.dobController,
              ),
              SizedBox(height: 0.1.h),

              // Profile Type
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile Type',
                  style: TextStyle(color: Color(0xFF4A4F5E)),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem(
                    value: 'Personal Use',
                    child: Text('Personal Use'),
                  ),
                  DropdownMenuItem(
                    value: 'Broker/Merchant',
                    child: Text('Broker/Merchant'),
                  ),
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  labelText: 'Select Profile',
                  labelStyle: TextStyle(color: Color(0xFF4A4F5E)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF4A4F5E), width: 1),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/arrow_down.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // ID-Verified
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ID-Verified',
                  style: TextStyle(color: Color(0xFF4A4F5E)),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              GestureDetector(
                onTap: controller.pickFile,
                child: Container(
                  width: screenWidth,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF4A4F5E), width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upload your ID',
                          style: TextStyle(color: Color(0xFF4A4F5E)),
                        ),
                        Image.asset(
                          'assets/images/upload.png',
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Password
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(color: Color(0xFF4A4F5E)),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Obx(
                () => CustomTextField(
                  hitText: 'Password',
                  obscureText: !controller.isPasswordVisible.value,
                  textEditingController: controller.passwordController,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
              ),
              SizedBox(height: 0.1.h),

              // Confirm Password
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm Password',
                  style: TextStyle(color: Color(0xFF4A4F5E)),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Obx(
                () => CustomTextField(
                  hitText: 'Confirm Password',
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  textEditingController: controller.confirmPasswordController,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfirmPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: controller.toggleConfirmPasswordVisibility,
                  ),
                ),
              ),

              SizedBox(height: 0.1.h),

              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(
                                (dynamic phoneNumberController) =>
                                    OTPVerificationScreen(

                                    ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1F3892),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
              ),

              SizedBox(height: screenHeight * 0.05),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF4A4F5E),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => LoginScreen()),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF1F3892),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
