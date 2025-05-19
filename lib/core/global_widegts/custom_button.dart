import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final Widget? child;
  final String? prefixIconPath;
  final Widget? suffixIcon;
  final BorderSide? borderSide;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFA16DB6),
    this.textColor = Colors.white,
    this.borderRadius = 20,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.height = 50,
    this.width = double.infinity,
    this.child,
    this.prefixIconPath,
    this.suffixIcon,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
        border:
            borderSide != null
                ? Border.all(
                  color: borderSide!.color,
                  width: borderSide!.width,
                  style: borderSide!.style,
                )
                : null,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child:
              child ??
              (prefixIconPath != null && suffixIcon != null
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            prefixIconPath!,
                            height: 24.h,
                            width: 24.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            text,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      suffixIcon!,
                    ],
                  )
                  : Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: textColor,
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
