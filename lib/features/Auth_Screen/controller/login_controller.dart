import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _prefillPhone();
  }

  Future<void> _prefillPhone() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? phone = prefs.getString('user_phone');
      if (phone != null && phone.isNotEmpty) {
        phoneController.text = phone;
        if (kDebugMode) {
          print('Pre-filled phone: $phone');
        }
      } else {
        if (kDebugMode) {
          print('No phone found in SharedPreferences');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error pre-filling phone: $e');
      }
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> handleLogin() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Basic phone number validation: numeric and minimum length
    if (!RegExp(r'^\d{10,15}$').hasMatch(phone)) {
      Get.snackbar(
        'Error',
        'Please enter a valid phone number (10-15 digits)',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;
      EasyLoading.show(status: 'Logging in...');

      final response = await http.post(
        Uri.parse('${Urls.baseUrl}/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'phone': phone, 'password': password}),
      );

      if (kDebugMode) {
        print('Response: ${response.body}');
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLogin', true);
          await prefs.setString('user_phone', phone);
          // Store user type if provided by API
          String? userType = data['user_type'];
          if (userType != null) {
            await prefs.setString('user_type', userType);
          }

          Get.snackbar(
            'Success',
            'Login successful',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );

          // Navigate based on user type
          if (userType == 'Consumer') {
            // Get.to(() => HomeScreen());
          } else if (userType == 'Business') {
            // Get.to(() => PartnerBottomNavBarScreen());
          } else {
            Get.snackbar(
              'Error',
              'Invalid user type',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        } else {
          Get.snackbar(
            'Error',
            data['message'] ?? 'Invalid credentials',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Request failed with status: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      if (kDebugMode) {
        print('Login error: $e');
      }
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  Future<void> handleGoogleSignIn() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Error',
        'Google Sign-In not implemented yet',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      if (kDebugMode) {
        print('Google Sign-In placeholder executed');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google Sign-In failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      if (kDebugMode) {
        print('Google Sign-In error: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
