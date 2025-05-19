import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prettyrini/core/global_widegts/custom_button.dart';

void showSuccessDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onDonePressed,
  required Widget image,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              image, // 👈 Dynamic image shown here
              SizedBox(height: 10.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                message,
                style: TextStyle(fontSize: 16.sp, color: Color(0xFF4A4F5E)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              CustomButton(
                width: screenWidth * 0.65,
                backgroundColor: Color(0xFF0B3A3D),
                borderRadius: 10,
                text: 'Done',
                onPressed: onDonePressed,
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      );
    },
  );
}
