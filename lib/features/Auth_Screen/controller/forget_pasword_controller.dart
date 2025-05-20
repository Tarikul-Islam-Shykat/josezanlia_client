import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:prettyrini/features/Auth_Screen/screens/forget_pasword_screen.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  final ForgetPasswordController controller = Get.put(
    ForgetPasswordController(),
  );
  // TextEditingController otpController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController rePasswordController = TextEditingController();
  void sendemail() async {
    if (phoneNumberController.text.isNotEmpty) {
      try {
        EasyLoading.show(status: "Processing...");
        final response = await http.post(
          Uri.parse('${Urls.baseUrl}/auth/forgot-password'),
          // headers: {"Authorization": token},
          body: {'Phone': phoneNumberController.text},
        );

        if (kDebugMode) {
          print(response.body);
        }
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['success'] == true) {
            Get.snackbar("Success", "Phone Verify successfully");
            // Get.to(() => OTPVerificationScreen(Phone: phoneNumberController.text));
            Get.to(() => ForgetPasswordScreen());
          } else {
            Get.snackbar("Error", "Something went wrong");
          }
        } else {
          if (kDebugMode) {
            print('Request failed with status: ${response.statusCode}');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      Get.snackbar("Error", "Please enter email");
    }
  }

  // void verifyOtp() async {
  //   if (otpController.text.length == 4) {
  //     try {
  //       EasyLoading.show(status: "Processing...");

  //       // Debugging: Print OTP and email before sending request
  //       if (kDebugMode) {
  //         print("Request URL: ${Urls.baseUrl}/auth/verify-otp");
  //       }
  //       if (kDebugMode) {
  //         print(
  //           "Request Body: ${jsonEncode({'email': emailController.text.trim(), 'otp': int.parse(otpController.text.trim())})}",
  //         );
  //       }

  //       final response = await http.post(
  //         Uri.parse('${Urls.baseUrl}/auth/verify-otp'),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "application/json",
  //         },
  //         body: jsonEncode({
  //           'email': emailController.text.trim(),
  //           'otp': int.parse(otpController.text.trim()),
  //         }),
  //       );

  //       if (kDebugMode) {
  //         print("Response: ${response.body}");
  //       }

  //       if (response.statusCode == 200) {
  //         var data = jsonDecode(response.body);
  //         if (data['success'] == true) {
  //           Get.snackbar("Success", "OTP verified successfully");
  //           Get.to(() => ResetPassword());
  //         } else {
  //           Get.snackbar("Error", data['message'] ?? "Invalid OTP");
  //         }
  //       } else {
  //         if (kDebugMode) {
  //           print('Request failed with status: ${response.statusCode}');
  //         }
  //         Get.snackbar("Error", "Request failed. Try again.");
  //       }
  //     } catch (e) {
  //       if (kDebugMode) {
  //         print("Error: $e");
  //       }
  //       Get.snackbar("Error", "Something went wrong.");
  //     } finally {
  //       EasyLoading.dismiss();
  //     }
  //   } else {
  //     Get.snackbar("Error", "Please enter OTP");
  //   }
  // }

  // void resetPassword() async {
  //   if (passwordController.text.length >= 7) {
  //     try {
  //       EasyLoading.show(status: "Processing...");
  //       final response = await http.post(
  //         Uri.parse('${Urls.baseUrl}/auth/reset-password'),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "application/json",
  //         },
  //         body: jsonEncode({
  //           'email': emailController.text.trim(),
  //           'password': passwordController.text.trim(),
  //         }),
  //       );

  //       if (kDebugMode) {
  //         print("Response: ${response.body}");
  //       }

  //       if (response.statusCode == 200) {
  //         var data = jsonDecode(response.body);
  //         if (data['success'] == true) {
  //           Get.snackbar("Success", "Password reset successfully");
  //           Get.offAll(() => LoginScreen());
  //         } else {
  //           Get.snackbar("Error", data['message'] ?? "Something went wrong");
  //         }
  //       } else {
  //         if (kDebugMode) {
  //           print('Request failed with status: ${response.statusCode}');
  //         }
  //         Get.snackbar("Error", "Request failed. Try again.");
  //       }
  //     } catch (e) {
  //       Get.snackbar("Error", "Something went wrong.");
  //     } finally {
  //       EasyLoading.dismiss();
  //     }
  //   } else {
  //     Get.snackbar("Error", "Password must be at least 8 characters long.");
  //   }
  // }
}
