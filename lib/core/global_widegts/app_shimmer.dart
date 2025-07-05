import 'package:flutter/material.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

boxShimmerPro({required double width, required double height}) {
  return ShimmerPro.generated(
    light: ShimmerProLight.darker,
    scaffoldBackgroundColor: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rectangular box with reduced height
        ShimmerPro.sized(
          light: ShimmerProLight.darker,
          scaffoldBackgroundColor: Colors.white,
          height: height * 0.6, // reduced height
          width: width,
          borderRadius: 8,
        ),
        const SizedBox(height: 10), // slightly smaller spacing
        // Text line effects
        ShimmerPro.text(
          light: ShimmerProLight.darker,
          scaffoldBackgroundColor: Colors.white,
          width: width * 0.9,
          depth: 12, // slightly smaller text depth
        ),
        const SizedBox(height: 6), // slightly smaller spacing
        ShimmerPro.text(
          light: ShimmerProLight.darker,
          scaffoldBackgroundColor: Colors.white,
          width: width * 0.6,
          depth: 12, // slightly smaller text depth
        ),
      ],
    ),
  );
}
