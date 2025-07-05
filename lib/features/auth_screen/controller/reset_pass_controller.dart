import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:prettyrini/core/repository/network_caller/network_config.dart';
import 'package:prettyrini/route/route.dart';
import '../screens/utils/show_success_dialog.dart';

class ResetPassController extends GetxController{
  final NetworkConfig _networkConfig = NetworkConfig();
  final newPass = TextEditingController();
  final conPass = TextEditingController();
  RxBool isLoading = false.obs;
  
  Future<bool> resetPass(email, context)async{
    isLoading.value = true;
    try{
      Map<String,dynamic> data ={
        "email":email.toString(),
        "password": newPass.text.trim(),
      };
      log("ResetPass Data $data");
      final response = await _networkConfig.ApiRequestHandler(
          RequestMethod.POST,
          Urls.resetPassword,
          jsonEncode(data),
          is_auth: false
      );
      if(response != null && response["success"]== true){
        submit(context);
        //AppSnackbar.show(message: "${response["message"]}", isSuccess: true);
        return true;
      }else{
        AppSnackbar.show(message: "${response["message"]}", isSuccess: false);
        log("ResetPass Failed ${response["message"]}");
        return false;
      }
    }catch(e){
      log("ResetPass Response failed${e.toString()}");
      return false;
    }finally{
      isLoading.value = false;
    }
  }

  void submit(BuildContext context) {


    showSuccessDialog(
      buttonText: 'Done',
      context: context,
      title: 'Success',
      message: 'Your password is successfully changed!',
      image: Image.asset('assets/images/tick.png', height: 70.h, width: 70.w),
      onDonePressed: () {
        Get.offAllNamed(AppRoute.loginScreen);
        Get.snackbar(
          backgroundColor: Colors.green,
          colorText: Colors.white,
          'Successful!',
          'New Password Setup Successfully! Please Log In',
        );
      },
    );
  }

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }
}