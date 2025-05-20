import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';
import 'package:prettyrini/features/Auth_Screen/screens/login_screen.dart';
import 'package:prettyrini/features/Auth_Screen/screens/profile/controller/profile_controller.dart';
import 'package:prettyrini/features/Auth_Screen/screens/profile/views/change_password.dart';
import 'package:prettyrini/features/Auth_Screen/screens/profile/views/profile_edit.dart';
import 'package:prettyrini/features/chat/view/chat_view.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              const Text(
                'Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.grey.shade200,
                  child:
                      controller.profileImage.value != null
                          ? ClipOval(
                            child: Image.file(
                              controller.profileImage.value!,
                              height: 100.h,
                              width: 100.w,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Image.asset(
                                    'assets/images/Ellipse.png',
                                    height: 100.h,
                                    width: 100.w,
                                  ),
                            ),
                          )
                          : Image.asset(
                            'assets/images/Ellipse.png',
                            height: 100.h,
                            width: 100.w,
                          ),
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => Text(
                  controller.userName.value,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  controller.phoneNumber.value,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
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
                        Get.to(() => ProfileEdit());
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
                        Get.to(() => ChangePassword());
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
                      text: '636348727',
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
                            contentPadding: EdgeInsets.all(20.w),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/help.png',
                                  height: 80.h,
                                  width: 80.w,
                                ),
                                Text(
                                  'Are You Sure?',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Do you want to log out?',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Get.back();
                                        Get.to(() => LoginScreen());
                                        Get.snackbar(
                                          'Logged Out',
                                          'You have been logged out successfully',
                                        );
                                        // Add actual logout logic here (e.g., navigate to login screen)
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
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20.w,
                                          vertical: 10.h,
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
                                        backgroundColor: const Color(
                                          0xFF1A3C3E,
                                        ),
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
                    width: screenWidth * 0.4,
                    backgroundColor: const Color(0xFF0B3A3D),
                    borderRadius: 10.r,
                    onPressed: () {

                      Get.to(() => ChatView());

                    },
                    text: 'Message',
                  ),
                  SizedBox(width: 5.w),
                  CustomButton(
                    prefixIconPath: 'assets/images/smart_phone.png',
                    width: screenWidth * 0.4,
                    backgroundColor: const Color(0xFF0B3A3D),
                    borderRadius: 10.r,
                    onPressed: () {},
                    text: 'Call',
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
