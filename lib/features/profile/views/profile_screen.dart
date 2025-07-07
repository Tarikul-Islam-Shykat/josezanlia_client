import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
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
            Text(
              'profile'.tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  : Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.person, color: Colors.white, size: 50),
                    ),
                  );
            }),

            SizedBox(height: 16.h),
            Obx(
              () => Text(
                controller.userProfile.value.consumer![0].firstName.toString(),
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
                    text: 'edit_profile'.tr,
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
                    text: 'change_password'.tr,
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
                    prefixIconPath: 'assets/images/language.png',
                    borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      var locale = Get.locale;
                      if (locale?.languageCode == 'en') {
                        Get.updateLocale(const Locale('pt', 'BR'));
                      } else {
                        Get.updateLocale(const Locale('en', 'US'));
                      }
                    },
                    text: 'change_language'.tr,
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
                                'are_you_sure'.tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'do_you_want_to_logout'.tr,
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
                                      'logout'.tr,
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
                                      'cancel'.tr,
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
                    text: 'logout'.tr,
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
                  text: 'message'.tr,
                ),
                SizedBox(width: 5.w),
                CustomButton(
                  prefixIconPath: 'assets/images/smart_phone.png',
                  width: screenWidth * 0.45,
                  backgroundColor: appGreenColor,
                  borderRadius: 10.r,
                  onPressed: () {},
                  text: 'call'.tr,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
