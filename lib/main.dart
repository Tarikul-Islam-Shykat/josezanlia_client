import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/features/chat/controller/chats_controller.dart';
import 'core/const/app_colors.dart';
import 'route/route.dart';
import 'core/localization/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? lang = prefs.getString('locale');
  configEasyLoading();
  Get.put(ChatController());
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MyApp(lang: lang));
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.grayColor
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.green
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({super.key, this.lang});
  final String? lang;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Josezanlia_Client',
            translations: AppTranslations(),
            locale:
                lang != null
                    ? Locale(lang!.split('_')[0], lang!.split('_')[1])
                    : Locale('pt', 'BR'),
            fallbackLocale: const Locale('en', 'US'),
            getPages: AppRoute.routes,
            initialRoute: AppRoute.splashScreen,
            builder: EasyLoading.init(),

            //home: SplashScreen(),
          ),
    );
  }
}
