import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/features/chat/view/chat_view.dart';
import 'package:prettyrini/features/profile/views/profile_edit.dart';
import '../../../../../core/global_widegts/custom_cached_image.dart';
import '../../chat_app/view/chat_screen.dart';
import '../controller/user_info_controller.dart';
import 'change_password.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(UserProfileController());

  //final controller = Get.find<ProfileController>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("WrProfileScreen initialized");
    }

    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const Text(
              'Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            Obx(() {
              return controller.userProfile.value != null
                  ? CustomCachedImage(
                    imageUrl:
                        controller.userProfile.value.profileImage.toString(),
                    type: CustomImageType.avatar,
                    radius: 50,
                  )
                  : CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.grey.shade200,
                    child: Image.asset(
                      'assets/images/user11.png',
                      height: 100.h,
                      width: 100.w,
                    ),
                  );
            }),

            SizedBox(height: 16.h),
            Obx(
              () => Text(
                controller.userProfile.value.userName.toString(),
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () => Text(
                controller.userProfile.value.email.toString(),
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                // boxShadow: const [
                //   BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 6,
                //     offset: Offset(0, 2),
                //   ),
                // ],
              ),
              child: Column(
                children: [
                  CustomButton(
                    prefixIconPath: 'assets/images/edit.png',
                    suffixIcon: Transform.rotate(
                      angle: 3.14159,
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Get.to(() => EditProfile());
                    },
                    text: 'Edit Profile',
                    textColor: Colors.black,
                    borderRadius: 12.r,
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    prefixIconPath: 'assets/images/lock1.png',
                    suffixIcon: Transform.rotate(
                      angle: 3.14159,
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Get.to(() => ChangePasswordView());
                    },
                    text: 'Change Password',
                    textColor: Colors.black,
                    borderRadius: 12.r,
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    prefixIconPath: 'assets/images/timer1.png',
                    borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    text:
                        "${controller.userProfile.value.consumer!.first.meterNumber}",
                    textColor: Colors.black,
                    borderRadius: 12.r,
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    prefixIconPath: 'assets/images/logout.png',
                    suffixIcon: Transform.rotate(
                      angle: 3.14159,
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/help.png',
                                height: 80.h,
                                width: 80.w,
                              ),

                              // Image.asset(
                              //   'assets/images/help_icon.svg',
                              //   height: 80.h,
                              //   width: 80.w,
                              // ),
                              Text(
                                'Are You Sure?',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Do you want to log out?',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                      controller.logout();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                    ),
                                    child: Text(
                                      'Log Out',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back(); // Close dialog
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: appGreenColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 10.h,
                                      ),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      );
                    },
                    text: 'Log Out',
                    textColor: Colors.black,
                    borderRadius: 12.r,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  prefixIconPath: 'assets/images/chat.png',
                  width: screenWidth * 0.45,
                  backgroundColor: appGreenColor,
                  borderRadius: 10.r,
                  onPressed: () {
                    Get.to(() => ChatPage());
                  },
                  text: 'Message',
                ),
                SizedBox(width: 5.w),
                CustomButton(
                  prefixIconPath: 'assets/images/smart_phone.png',
                  width: screenWidth * 0.45,
                  backgroundColor: appGreenColor,
                  borderRadius: 10.r,
                  onPressed: () {},
                  text: 'Call',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
