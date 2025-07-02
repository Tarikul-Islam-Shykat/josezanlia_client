import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';

import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    // var screenHeight = MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFFFFFFF),
      child: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      ImagePath.logo,
                      width: 140,
                      height: 140,
                      // height: screenHeight * 0.5,
                    ),
                    Text(
                      'ComunÁgua',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.sp,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Disponível todos os dias,\na qualquer hora',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Color(0xFFC0561E),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: SpinKitCircle(color: Color(0xFF0B3A3D), size: 80.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
