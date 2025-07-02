import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/core/global_widegts/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


import '../../../../../core/const/app_loader.dart';
import '../controller/profile_controller.dart';

class ProfileEdit extends StatelessWidget {
  final controller = Get.put(ProfileController());
  ProfileEdit({super.key});



  @override
  Widget build(BuildContext context) {
    // Initialize text controllers with current values from ProfileController


    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'Edit Profile'),
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  controller.updateProfileImage(File(image.path));
                }
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Obx(
                        () =>
                        CircleAvatar(
                          radius: 50.r, // Adjust radius as needed
                          backgroundImage: controller.profileImage.value != null
                              ? FileImage(controller.profileImage.value!)
                              : AssetImage('assets/images/worker_edit_profile.png') as ImageProvider,
                          child: controller.profileImage.value == null
                              ? null // No child if image is from asset
                              : ClipOval( // Clip if image is from file to ensure circular shape
                            child: Image.file(
                              controller.profileImage.value!,
                              height: 100.h,
                              width: 100.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                'assets/images/worker_edit_profile.png',
                                height: 100.h,
                                width: 100.w,
                              ),
                            ),
                          ),
                        ),
                  ),
                  Positioned(
                    bottom: 20.h,
                    right: -10,
                    child: Image.asset(
                      'assets/images/worker_camera.png',
                      height: 20.h,
                      width: 25.w,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Obx(() => Text(
                controller.userName.value,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() => Text(
                controller.phoneNumber.value,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              hitText: 'Name',
              fontWeight: FontWeight.bold,
              readOnly: false,
              borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
              fillColor: Colors.white,
              //width: screenWidth * 0.9,
              textEditingController: controller.nameController,
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              hitText: 'Phone Number',
              fontWeight: FontWeight.bold,
              readOnly: false,
              borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
              fillColor: Colors.white,
              //width: screenWidth * 0.9,
              textEditingController:controller.phoneController,
            ),
            SizedBox(height: 150.h),
            Obx(() {
              return controller.isUpdateProfileLoading.value ? loader() : CustomButton(
                backgroundColor: appGreenColor,
                width: screenWidth * 0.9,
                onPressed: () {
                  controller.updateProfile();
                  //Get.snackbar('Success', 'Profile updated successfully');
                },
                text: 'Update',
              );
            }),
          ],
        ),
      ),
    );
  }
}
