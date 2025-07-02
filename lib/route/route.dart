import 'package:get/get.dart';
import 'package:prettyrini/features/Auth_Screen/screens/forget_pasword_screen.dart';
import 'package:prettyrini/features/Auth_Screen/screens/login_screen.dart';
import 'package:prettyrini/features/Auth_Screen/screens/profile/views/profile_screen.dart';
import 'package:prettyrini/features/invoice/view/invoice_screen.dart';
import 'package:prettyrini/features/invoice/view/top_up_invoice_screen.dart';
import 'package:prettyrini/features/splash_screen/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = '/splashScreen';
  static String loginScreen = "/loginScreen";
  static String forgetScreen = "/forgetScreen";
  static String profileScreen = "/profileScreen";
  static String invoiceScreen = "/invoiceScreen";
  static String topUpInvoiceScreen = "/topUpInvoiceScreen";

  static String getSplashScreen() => splashScreen;

  static String getLoginScreen() => loginScreen;

  static String getForgetScreen() => forgetScreen;

  static String getProfileScreen() => profileScreen;

  static String getInvoiceScreen() => invoiceScreen;

  static String getTopUpInvoiceScreen() => topUpInvoiceScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: forgetScreen, page: () => ForgetPasswordScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(
      name: invoiceScreen,
      page: () => InvoiceScreen(arguments: <String, Object>{}),
    ),
    GetPage(name: topUpInvoiceScreen, page: () => TopUpInvoiceScreen()),
  ];
}
