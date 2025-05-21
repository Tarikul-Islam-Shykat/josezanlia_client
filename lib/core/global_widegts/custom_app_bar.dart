// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.showBackButton = true,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 30.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (centerTitle)
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF2F2F2F),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (!centerTitle)
              Positioned(
                left: showBackButton ? 55.w : 16.w,
                child: Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF2F2F2F),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (showBackButton)
              Positioned(
                left: 12.w,
                child: GestureDetector(
                  onTap: onBackPressed ?? () => Get.back(),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: const Color(0xFF187C82).withOpacity(0.19),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF0B3A3D),
                      size: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
