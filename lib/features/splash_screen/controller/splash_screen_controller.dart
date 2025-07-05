// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';

// import 'package:get/get.dart';
// import 'package:prettyrini/feature/partner_screens_section/features/partner_home_pages/partner_home_screen/view/partner_home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import '../../../core/network_caller/endpoints.dart';
// import '../../auth/screen/login_screen.dart';
// import '../../auth/screen/profile_setup_screen.dart';

// class SplashScreenController extends GetxController {
//   var userImage = "".obs;
//   var firstname = ''.obs;
//   var lastName = ''.obs;
//   void checkIsLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString("token") ?? "";
//     if (kDebugMode) {
//       print("token1$token");
//     }
//     if (token.isEmpty) {
//       Get.offAll(() => PartnerHomeScreen());
//     } else {
//       try {
//         // Make the GET request
//         final response = await http.get(
//           Uri.parse('${Urls.baseUrl}/auth/get-me'),
//           headers: {"Authorization": token},
//         );

//         if (kDebugMode) {
//           print(response.body);
//         }
//         if (response.statusCode == 201) {
//           var data = jsonDecode(response.body);
//           if (data['data']['isCompleted'] == true) {
//             userImage.value = data['data']['profileImage'] ?? "";
//             firstname.value = data['data']['firstName'];
//             lastName.value = data['data']['lastName'];

//             //Get.offAll(() => NavBarView());
//           } else {
//             Get.offAll(() => ProfileSetupScreen());
//           }
//         } else {
//           if (kDebugMode) {
//             print('Request failed with status: ${response.statusCode}');
//           }
//           Get.offAll(() => LoginScreen());
//         }
//       } catch (e) {
//         // Handle any errors that occur during the request
//         if (kDebugMode) {
//           print('Error: $e');
//         }
//       }
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     checkIsLogin();
//   }
// }

import 'dart:async';

import 'package:get/get.dart';
import 'package:prettyrini/features/Auth_Screen/screens/login_screen.dart';
import 'package:prettyrini/route/route.dart';

import '../../../core/repository/services_class/local_service/shared_preferences_helper.dart';
import '../../nav_bar/view/nav_bar_view.dart';

class SplashScreenController extends GetxController {
  void checkIsLogin() async {
    Timer(const Duration(seconds: 3), () async {
      //Check if the token exists in shared preferences
      String? token = await SharedPreferencesHelper.getAccessToken();
      //f token exists, the user is logged in
      if (token != null && token.isNotEmpty) {
      //Redirect to the main screen (e.g., Bottom Navbar or Home)
      Get.offAll(BottomNavbar());
     // Get.offAll(LoginScreen());
       }else{
        Get.toNamed(AppRoute.loginScreen);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    checkIsLogin();
  }
}
