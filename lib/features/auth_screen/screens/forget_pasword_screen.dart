import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_loader.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import '../controller/forget_pasword_controller.dart';


class ForgetPasswordScreen extends StatelessWidget {
  final ForgetPasswordController controller = Get.put(ForgetPasswordController());
  ForgetPasswordScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              SizedBox(height: screenHeight * 0.05),

              // Phone Number
              CustomTextField(
                borderSide: BorderSide(
                  color:Colors.grey.shade500,
                ),
                fillColor: Color(0xFFFFFFFF),
                prefixIconPath: ImagePath.mail,
                textEditingController: controller.emailTEC,
                hitText: 'Email',
              ),
              SizedBox(height: 250.h),

              SizedBox(height: 80.h),

              Obx(() {
                  return controller.isLoading.value?loader():CustomButton(
                    onPressed: () {
                      controller.sendOTPEmail();
                    },
                    text: 'Continue',
                    // borderColor: Color(0xFF1F3892),
                    textColor: Colors.white,
                    backgroundColor: Color(0xFF0B3A3D),
                    width: screenWidth * 0.9,
                    borderRadius: 10,
                  );
                }
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
