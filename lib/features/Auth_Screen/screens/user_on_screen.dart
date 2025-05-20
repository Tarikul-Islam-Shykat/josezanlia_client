import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/features/Auth_Screen/controller/user_on_controller.dart';
import 'package:prettyrini/features/splash_screen/screen/signin_login_screen.dart';

class UserOnScreen extends StatelessWidget {
  UserOnScreen({super.key});
  final controller = Get.put(UserOnController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCD3E4),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),

            Image.asset('assets/images/logo.png', height: 130.h, width: 200.w),

            SizedBox(height: 30.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(color: Color(0xFF4A4F5E), fontSize: 20.sp),
                ),
                SizedBox(width: 5.w),
                Text(
                  'rMembr',
                  style: TextStyle(color: Color(0xFF1F3892), fontSize: 20.sp),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            Text(
              textAlign: TextAlign.center,
              'Preserve your legacy. Share your memories. Always.',
              style: TextStyle(color: Color(0xFF4A4F5E), fontSize: 20.sp),
            ),
            SizedBox(height: 50.h),

            // Role options
            Obx(
              () => _buildRoleOption(
                icon: Icons.person,
                label: "I'm a user",
                selected: controller.selectedRole.value == 'user',
                onTap: () => controller.selectRole('user'),
              ),
            ),
            SizedBox(height: 15.h),
            Obx(
              () => _buildRoleOption(
                icon: Icons.person_2_outlined,
                label: "I'm a Partner",
                selected: controller.selectedRole.value == 'partner',
                onTap: () => controller.selectRole('partner'),
              ),
            ),
            SizedBox(height: 60.h),

            // Next button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F3892),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                onPressed: () {
                  Get.to(() => SigninLoginScreen());
                  if (kDebugMode) {
                    print("Selected role: ${controller.selectedRole.value}");
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Contact us
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Text.rich(
                TextSpan(
                  text: 'Need help or have questions? ',
                  style: TextStyle(color: Colors.black87, fontSize: 14.sp),
                  children: [
                    TextSpan(
                      text: 'Contact us.',
                      style: TextStyle(
                        color: Color(0xFF1F3892),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF9FA8C8) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? const Color(0xFF1F3892) : Color(0xFF1F3892),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 16.w),
            Icon(icon, size: 24.sp, color: Color(0xFF1F3892)),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Color(0xFF2A3766),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Radio(
              value: true,
              groupValue: selected,
              onChanged: (_) => onTap(),
              activeColor: Color(0xFF1F3892),
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
