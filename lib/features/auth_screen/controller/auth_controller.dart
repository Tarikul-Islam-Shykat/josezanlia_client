import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/global_widegts/custom_snack_bar.dart';
import '../../../core/repository/network_caller/network_config.dart';
import '../../../core/repository/services_class/local_service/shared_preferences_helper.dart';
import '../../nav_bar/view/nav_bar_view.dart';
import '../screens/login_screen.dart';
import '../screens/otp_very_screen.dart';
import '../screens/set_new_password_screen.dart';
import '../screens/utils/show_success_dialog.dart';

class AuthController extends GetxController {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final changeNewPasswordController = TextEditingController();
  final changeOldPasswordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;
  final isLoginLoading = false.obs;
  final isForgotPasswordLoading = false.obs;
  final isResetPasswordLoading = false.obs;
  final isVerifyOTPLoading = false.obs;
  final isChangePasswordLoading = false.obs;
  final NetworkConfig _networkConfig = NetworkConfig();


  Future<void> loginUser() async {
    String emailOrPhone = emailOrPhoneController.text.trim();
    if (emailOrPhone.isEmpty) {
      showSnackBar(false, "Please enter your email or phone number.");
      return;
    }

    // Validate email or phone
    if (emailOrPhone.contains('@')) {
      // It's an email
      if (!GetUtils.isEmail(emailOrPhone)) {
        showSnackBar(false, "Please enter a valid email address.");
        return;
      }
    } else {
      // It's a phone number
      if (!GetUtils.isPhoneNumber(emailOrPhone)) {
        showSnackBar(false, "Please enter a valid phone number.");
        return;
      }
    }

    // Validate password
    String password = passwordController.text.trim();
    if (password.length < 8) {
      showSnackBar(false, "Password must be at least 8 characters long.");
      return;
    }
    // if (!password.contains(RegExp(r'[A-Z]')) ||
    //     !password.contains(RegExp(r'[a-z]'))) {
    //   showSnackBar(
    //     false,
    //     "Password must contain both uppercase and lowercase letters.",
    //   );
    //   return;
    // }

    try {
      isLoginLoading.value = true;
      // json
      final Map<String, dynamic> requestBody = {
        "email": emailOrPhoneController.text.trim(),
        "password": passwordController.text.trim(),
      };

      if (kDebugMode) {
        print("LogInController login user Request Body: $requestBody");
      }

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.login,
        json.encode(requestBody),
        is_auth: false,
      );

      if (kDebugMode) {
        print("LoginController login Response: $response");
      }

      if (response['success'] == true) {
        final token = response['data']['token'];
        if (token != null) {
          SharedPreferencesHelper.saveAccessToken(token);
          showSnackBar(true, response['message']);
          Get.offAll(() => BottomNavbar());
        } else {
          showSnackBar(false, "Token not found in response.");
        }
      } else if (response['success'] == false) {
        showSnackBar(false, response['message']);
      }
    } catch (e) {
      showSnackBar(false, "At Catch: ${e.toString()}");
    } finally {
      isLoginLoading.value = false;
    }
  }

  Future<void> changePassword() async {
    String newPassword = changeNewPasswordController.text.trim();
    String currentPassword = changeOldPasswordController.text.trim();

    if (newPassword.length < 8) {
      showSnackBar(false, "New password must be at least 8 characters long.");
      return;
    }
    if (currentPassword.length < 8) {
      showSnackBar(
        false,
        "Current password must be at least 8 characters long.",
      );
      return;
    }
    if (newPassword == currentPassword) {
      showSnackBar(
        false,
        "New password cannot be the same as the current password.",
      );
      return;
    }

    if (kDebugMode) {
      print("LogInController Change Password Request Body: $newPassword");
      print("LogInController Current Password Request Body: $currentPassword");
    }

    try {
      isChangePasswordLoading.value = true;
      // json
      final Map<String, dynamic> requestBody = {
        "oldPassword": currentPassword,
        "newPassword": newPassword,
      };

      if (kDebugMode) {
        print("LogInController forgot Password Request Body: $requestBody");
      }

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.PUT,
        Urls.changePass,
        json.encode(requestBody),
        is_auth: true,
      );

      if (kDebugMode) {
        print("LoginController login Response: $response");
      }

      if (response['success'] == true) {
        showSnackBar(true, response['message']);
        Navigator.of(Get.context!).pop();
      } else if (response['success'] == false) {
        showSnackBar(false, response['message']);
      }
    } catch (e) {
      showSnackBar(false, "At Catch: ${e.toString()}");
    } finally {
      isChangePasswordLoading.value = false;
    }
  }

  // Future<void> _prefillPhone() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? phone = prefs.getString('user_phone');
  //     if (phone != null && phone.isNotEmpty) {
  //       phoneController.text = phone;
  //       if (kDebugMode) {
  //         print('Pre-filled phone: $phone');
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print('No phone found in SharedPreferences');
  //       }
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error pre-filling phone: $e');
  //     }
  //   }
  // }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  //
  // Future<void> handleLogin() async {
  //   final phone = phoneController.text.trim();
  //   final password = passwordController.text.trim();
  //
  //   if (phone.isEmpty || password.isEmpty) {
  //     Get.snackbar(
  //       'Error',
  //       'Please fill all fields',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     return;
  //   }
  //
  //   // Basic phone number validation: numeric and minimum length
  //   if (!RegExp(r'^\d{10,15}$').hasMatch(phone)) {
  //     Get.snackbar(
  //       'Error',
  //       'Please enter a valid phone number (10-15 digits)',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     return;
  //   }
  //
  //   if (password.length < 6) {
  //     Get.snackbar(
  //       'Error',
  //       'Password must be at least 6 characters',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     return;
  //   }
  //
  //   try {
  //     isLoading.value = true;
  //     EasyLoading.show(status: 'Logging in...');
  //
  //     final response = await http.post(
  //       Uri.parse('${Urls.baseUrl}/auth/login'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode({'phone': phone, 'password': password}),
  //     );
  //
  //     if (kDebugMode) {
  //       print('Response: ${response.body}');
  //     }
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       if (data['success'] == true) {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setBool('isLogin', true);
  //         await prefs.setString('user_phone', phone);
  //         // Store user type if provided by API
  //         String? userType = data['user_type'];
  //         if (userType != null) {
  //           await prefs.setString('user_type', userType);
  //         }
  //
  //         Get.snackbar(
  //           'Success',
  //           'Login successful',
  //           backgroundColor: Colors.green,
  //           colorText: Colors.white,
  //           snackPosition: SnackPosition.TOP,
  //         );
  //
  //         // Navigate based on user type
  //         if (userType == 'Consumer') {
  //           // Get.to(() => HomeScreen());
  //         } else if (userType == 'Business') {
  //           // Get.to(() => PartnerBottomNavBarScreen());
  //         } else {
  //           Get.snackbar(
  //             'Error',
  //             'Invalid user type',
  //             backgroundColor: Colors.red,
  //             colorText: Colors.white,
  //             snackPosition: SnackPosition.TOP,
  //           );
  //         }
  //       } else {
  //         Get.snackbar(
  //           'Error',
  //           data['message'] ?? 'Invalid credentials',
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white,
  //           snackPosition: SnackPosition.TOP,
  //         );
  //       }
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Request failed with status: ${response.statusCode}',
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         snackPosition: SnackPosition.TOP,
  //       );
  //       if (kDebugMode) {
  //         print('Request failed with status: ${response.statusCode}');
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Something went wrong. Please try again later.',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     if (kDebugMode) {
  //       print('Login error: $e');
  //     }
  //   } finally {
  //     isLoading.value = false;
  //     EasyLoading.dismiss();
  //   }
  // }
  //
  // Future<void> handleGoogleSignIn() async {
  //   try {
  //     isLoading.value = true;
  //     await Future.delayed(const Duration(seconds: 2));
  //     Get.snackbar(
  //       'Error',
  //       'Google Sign-In not implemented yet',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     if (kDebugMode) {
  //       print('Google Sign-In placeholder executed');
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Google Sign-In failed',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     if (kDebugMode) {
  //       print('Google Sign-In error: $e');
  //     }
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // @override
  // void onClose() {
  //   phoneController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
}
