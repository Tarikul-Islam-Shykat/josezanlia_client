import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:prettyrini/features/Auth_Screen/screens/profile/controller/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:prettyrini/features/Auth_Screen/screens/profile/views/profile_screen.dart';

class ProfileEdit extends StatelessWidget {
  final controller = Get.put(ProfileController());
  ProfileEdit({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialize text controllers with current values from ProfileController
    nameController.text = controller.userName.value;
    phoneController.text = controller.phoneNumber.value;

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'Edit Profile'),
            Stack(
              children: [
                Obx(
                  () =>
                      controller.profileImage.value != null
                          ? ClipOval(
                            child: Image.file(
                              controller.profileImage.value!,
                              height: 100.h,
                              width: 100.w,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Image.asset(
                                    'assets/images/edit_profile.png',
                                    height: 100.h,
                                    width: 100.w,
                                  ),
                            ),
                          )
                          : Image.asset(
                            'assets/images/edit_profile.png',
                            height: 100.h,
                            width: 100.w,
                          ),
                ),
                Positioned(
                  bottom: 20.h,
                  right: -3,
                  child: GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        controller.updateProfileImage(File(image.path));
                      }
                    },
                    child: Image.asset(
                      'assets/images/camera.png',
                      height: 20.h,
                      width: 25.w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Obx(
              () => Text(
                controller.userName.value,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () => Text(
                controller.phoneNumber.value,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              hitText: '',
              fontWeight: FontWeight.bold,
              readOnly: true,
              borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
              fillColor: Colors.white,
              width: screenWidth * 0.9,
              textEditingController: nameController,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              hitText: '',
              fontWeight: FontWeight.bold,
              readOnly: true,
              borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
              fillColor: Colors.white,
              width: screenWidth * 0.9,
              textEditingController: phoneController,
            ),
            SizedBox(height: 150.h),
            CustomButton(
              backgroundColor: const Color(0xFF0B3A3D),
              width: screenWidth * 0.9,
              onPressed: () {
                Get.to(() => ProfileScreen());
                controller.updateProfile(
                  name: nameController.text,
                  phone: phoneController.text,
                );
                Get.snackbar('Success', 'Profile updated successfully');
              },
              text: 'Update',
            ),
          ],
        ),
      ),
    );
  }
}
