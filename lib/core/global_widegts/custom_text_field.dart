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
    //this.width,
    this.height,
    this.maxLines = 1,
    this.isPassword = true,
    this.prefixIconPath,
    this.readOnly = false,
    this.fillColor,
    this.textColor,
    this.borderSide,
    this.onSuffixIconTap,
    this.isForPassword = false, this.onTap, this.keyboardType,
  });

  final String? hitText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final TextEditingController textEditingController;
  final bool obscureText;
  final Widget? suffixIcon;
  //final double? width;
  final double? height;
  final int? maxLines;
  final bool isPassword;
  final String? prefixIconPath;
  final bool readOnly;
  final Color? fillColor;
  final Color? textColor;
  final BorderSide? borderSide;
  final void Function()? onSuffixIconTap;
  final bool isForPassword;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        onTap: onTap,
        keyboardType:keyboardType ,
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
          //prefixText: hitText != null ? '$hitText ' : null,
          prefixStyle: TextStyle(
              fontSize: fontSize ?? 16.sp,
              fontWeight: fontWeight ?? FontWeight.w400,
              color: Colors.black.withValues(alpha: 0.5)// Match hintStyle for consistency
          ),
          hintText: hitText, // Remove hintText to avoid placeholder behavior
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

          suffixIcon: isForPassword ? GestureDetector(onTap: onSuffixIconTap,
            child: obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility),

          ) : null,

          //suffixIcon: obscureText ? suffixIcon : Icon(Icons.visibility_off),
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
