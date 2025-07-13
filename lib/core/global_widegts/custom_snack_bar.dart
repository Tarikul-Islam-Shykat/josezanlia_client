import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(bool isSuccess, String message) {
  Get.snackbar(
    isSuccess ? 'success'.tr : 'error'.tr,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    colorText: Colors.white,
    margin: EdgeInsets.all(10.0),
    borderRadius: 8.0,
    duration: Duration(seconds: 3),
    icon: Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white24,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            isSuccess ? Icons.done: Icons.close,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
