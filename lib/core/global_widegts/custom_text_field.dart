// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hitText,
    required this.textEditingController,
    this.fontSize,
    this.fontWeight,
    this.lineHeight,
    this.obscureText = false,
    this.suffixIcon,
    this.width,
    this.height,
    this.maxLines = 8,
    this.isPassword = true,
    this.prefixIconPath,
    this.readOnly = false,
    this.fillColor,
    this.textColor,
    this.borderSide,
  });

  final String? hitText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final TextEditingController textEditingController;
  final bool obscureText;
  final Widget? suffixIcon;
  final double? width;
  final double? height;
  final int? maxLines;
  final bool isPassword;
  final String? prefixIconPath;
  final bool readOnly;
  final Color? fillColor;
  final Color? textColor;
  final BorderSide? borderSide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40.h,
      width: width ?? 273.w,
      child: TextField(
        controller: textEditingController,
        obscureText: obscureText,
        readOnly: readOnly,
        maxLines: obscureText ? 1 : maxLines,
        style: TextStyle(
          fontSize: fontSize ?? 16.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: textColor ?? Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.w,
            horizontal: 10.w,
          ),
          prefixText: hitText != null ? '$hitText ' : null,
          prefixStyle: TextStyle(
            fontSize: fontSize ?? 16.sp,
            fontWeight: fontWeight ?? FontWeight.w400,
            color: Colors.black.withOpacity(
              0.5,
            ), // Match hintStyle for consistency
          ),
          hintText: null, // Remove hintText to avoid placeholder behavior
          prefixIcon:
              prefixIconPath != null
                  ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Image.asset(
                      prefixIconPath!,
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.contain,
                    ),
                  )
                  : null,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: borderSide ?? BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: borderSide ?? BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: borderSide ?? BorderSide.none,
          ),
          filled: true,
          fillColor: fillColor ?? const Color(0xffF0EAFB),
        ),
      ),
    );
  }
}
