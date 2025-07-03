import 'package:flutter/material.dart';
import 'package:shimmer_pro/shimmer_pro.dart';


boxShimmerPro({
  required double width,
  required double height,
}){
  return ShimmerPro.generated(
    depth: 50,
    light: ShimmerProLight.lighter,
    scaffoldBackgroundColor: Colors.white10,
    height: height,
    width: width,
    borderRadius: 10,
    child: null,
  );
}