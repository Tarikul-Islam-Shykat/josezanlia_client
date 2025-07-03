import 'package:get/get.dart';
import 'package:prettyrini/features/Auth_Screen/screens/forget_pasword_screen.dart';
import 'package:prettyrini/features/Auth_Screen/screens/login_screen.dart';
import 'package:prettyrini/features/Auth_Screen/screens/profile/views/profile_screen.dart';
import 'package:prettyrini/features/invoice/view/invoice_screen.dart';
import 'package:prettyrini/features/invoice/view/top_up_invoice_screen.dart';
import 'package:prettyrini/features/home/view/invoice_screen.dart';
import 'package:prettyrini/features/home/view/top_up_invoice_screen.dart';
import 'package:prettyrini/features/splash_screen/screen/splash_screen.dart';

import '../features/Auth_Screen/screens/otp_very_screen.dart';
import '../features/Auth_Screen/screens/set_new_password_screen.dart';
import '../features/nav_bar/view/nav_bar_view.dart';
import '../features/profile/views/profile_screen.dart';

class AppRoute {
  static String splashScreen = '/splashScreen';
  static String loginScreen = "/loginScreen";
  static String forgetScreen = "/forgetScreen";
  static String otpVeryScreen = "/otpVeryScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";

  static String profileScreen = "/profileScreen";
  static String invoiceScreen = "/invoiceScreen";
  static String topUpInvoiceScreen = "/topUpInvoiceScreen";
  static String bottomNavBarScreen = "/bottomNavBarScreen";

  static String getSplashScreen() => splashScreen;
  static String getLoginScreen() => loginScreen;
  static String getForgetScreen() => forgetScreen;
  static String getOtpVeryScreen() => otpVeryScreen;
  static String getResetPasswordScreen() => resetPasswordScreen;

  static String getProfileScreen() => profileScreen;
  static String getInvoiceScreen() => invoiceScreen;
  static String getTopUpInvoiceScreen() => topUpInvoiceScreen;
  static String getBottomNavBarScreen() => bottomNavBarScreen;
  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: forgetScreen, page: () => ForgetPasswordScreen()),
    GetPage(name: otpVeryScreen, page: () => OTPVerificationScreen()),
    GetPage(name: resetPasswordScreen, page: () => SetNewPasswordScreen()),

    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(
      name: invoiceScreen,
      page: () => InvoiceScreen(arguments: <String, Object>{}),
    ),
    GetPage(name: topUpInvoiceScreen, page: () => TopUpInvoiceScreen()),
    GetPage(name: bottomNavBarScreen, page: () => BottomNavbar()),
  ];
}
