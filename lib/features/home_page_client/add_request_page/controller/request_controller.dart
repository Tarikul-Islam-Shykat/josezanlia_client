import 'dart:developer';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:path/path.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// Controller for managing the selected tab
class TopUpController extends GetxController {
  var selectedTab = 'Add Request'.obs;
  var isLoading = false.obs;

  TextEditingController transactionIdController = TextEditingController();

  var selectedPdfPath = ''.obs;

  Future<Map<String, dynamic>> uploadPdf(
    String filePath,
    dynamic transactionId,
  ) async {
    final file = File(filePath);
    final uri = Uri.parse('${Urls.uploadPDF}/$transactionId');
    var request = http.MultipartRequest('PUT', uri);

    // Add file to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // Field name for the file in the API
        file.path,
        filename: basename(file.path),
      ),
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': token ?? '',
    });
    try {
      isLoading.value = true;
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return {
          'success': false,
          'message': 'Upload failed with status: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error during upload: $e'};
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fileupload(dynamic transactionId) async {
    if (selectedPdfPath.value.isNotEmpty) {
      final response = await uploadPdf(selectedPdfPath.value, transactionId);
      if (response['success'] == true) {
        log('PDF uploaded successfully');
      } else {
        log('PDF upload failed: ${response['message']}');
      }
    } else {
      log('No PDF file selected to upload');
    }
  }

  // RxString is used to make the variable observable

  void changeTab(String tabName) {
    selectedTab.value = tabName; // Update the selected tab
  }
}
