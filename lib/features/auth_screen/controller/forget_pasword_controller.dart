import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:prettyrini/core/repository/network_caller/network_config.dart';
import 'package:prettyrini/route/route.dart';

class ForgetPasswordController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();
  TextEditingController emailTEC = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<bool>sendOTPEmail()async{
    isLoading.value = true;
    try{
      Map<String,dynamic>data ={
        "email":emailTEC.text,
      };
      final response = await _networkConfig.ApiRequestHandler(
          RequestMethod.POST,
          Urls.sendOTPForgot,
          jsonEncode(data),
          is_auth: false
      );
      if(response != null && response["success"] == true){
        AppSnackbar.show(message: "${response["message"]}", isSuccess: true);
        Get.toNamed(
          arguments:{
            "email":emailTEC.text
          },
            AppRoute.otpVeryScreen,
        );
        log("${response["message"]}");
        return true;
      }else{
        AppSnackbar.show(message: "${response["message"]}", isSuccess: false);
        log("${response["message"]}");
        return false;
      }
    }catch(e){
      log("response failed ${e.toString()}");
      return false;
    }finally{
      isLoading.value = false;
    }
  }

  Future<bool> verifyOTP(email) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> requestBody = {
        "email": email.toString().trim(),
        "otp": int.tryParse(otpController.text.trim()),
      };
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.verifyOTP,
        json.encode(requestBody),
        is_auth: false,
      );
      if (response != null && response['success'] == true) {
        AppSnackbar.show(message: "${response['message']}", isSuccess: true);
        Get.toNamed(
          arguments: {
            "email":email
          },
            AppRoute.resetPasswordScreen);
        return true;
      } else{
       AppSnackbar.show(message: "${response["message"]}", isSuccess: false);
       log("${response["message"]}");
       return false;
      }
    } catch (e) {
      log("Response failed ${e.toString()}");
      return false;
    } finally {
      isLoading.value = false;
    }
  }


  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 22, color: Color(0xFF4A4F5E)),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xFF4A4F5E), width: 1),
      borderRadius: BorderRadius.circular(12),
    ),
  );

  Timer? _timer;
  final timeLeft = 600.obs;
  final isResendVisible = false.obs;

  void startTimer() {
    timeLeft.value = 600;
    isResendVisible.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        isResendVisible.value = true;
        _timer?.cancel();
      }
    });
  }
  String get formattedTime {
    // final minutes = timeLeft.value ~/ 60;
    // final seconds = timeLeft.value % 60;
    // return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    final minutes = (timeLeft.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (timeLeft.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }


// void sendemail() async {
  //   if (emailTEC.text.isNotEmpty) {
  //     try {
  //       EasyLoading.show(status: "Processing...");
  //       final response = await http.post(
  //         Uri.parse('${Urls.baseUrl}/auth/forgot-password'),
  //         // headers: {"Authorization": token},
  //         body: {'email': emailTEC.text},
  //       );
  //
  //       if (kDebugMode) {
  //         print(response.body);
  //       }
  //       if (response.statusCode == 200) {
  //         var data = jsonDecode(response.body);
  //         if (data['success'] == true) {
  //           Get.snackbar("Success", "Phone Verify successfully");
  //           // Get.to(() => OTPVerificationScreen(Phone: phoneNumberController.text));
  //           Get.to(() => ForgetPasswordScreen());
  //         } else {
  //           Get.snackbar("Error", "Something went wrong");
  //         }
  //       } else {
  //         if (kDebugMode) {
  //           print('Request failed with status: ${response.statusCode}');
  //         }
  //       }
  //     } catch (e) {
  //       if (kDebugMode) {
  //         print('Error: $e');
  //       }
  //     } finally {
  //       EasyLoading.dismiss();
  //     }
  //   } else {
  //     Get.snackbar("Error", "Please enter email");
  //   }
  // }

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
