import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/style/global_text_style.dart';

class CustomAuthField extends StatelessWidget {
  const CustomAuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false, this.onTap, // Default to TextInputType.text
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onTap:onTap,
        readOnly: readOnly,
        keyboardType: keyboardType, // Use optional keyboard type
        obscureText: obscureText,
        controller: controller,
        style: globalTextStyle(color: const Color(0xff000000)),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle: globalTextStyle(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 14.h,
          ),
          fillColor: Colors.transparent, // Make background transparent
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.5),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: 12.w,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
