import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    var screenWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      backgroundColor: AppColors.bgColor,
      child: Center(
        child: Image.asset(
          ImagePath.logo,
          width: screenWidth * .5,
        ),
      ),
    );
  }
}
