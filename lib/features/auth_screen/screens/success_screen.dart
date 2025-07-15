// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/features/Auth_Screen/screens/login_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.8, // Adjust width
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image at the top
          Image.asset(
            'assets/images/tick.png',
            width: 30,
            height: 30,
          ),
          SizedBox(height: 20.h),

          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFF1F3892),
            child: Icon(Icons.check, color: Colors.white, size: 40),
          ),
          SizedBox(height: 20.h),

          Text(
            'success'.tr,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F3892),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'verification_successful'.tr,
            style: TextStyle(fontSize: 16.sp, color: Color(0xFF4A4F5E)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),

          ElevatedButton(
            onPressed: () {
              Get.to(LoginScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1F3892),
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text('continue_button'.tr, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
