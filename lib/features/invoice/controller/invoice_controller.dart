import 'dart:developer';

import 'package:get/get.dart';
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:prettyrini/core/repository/network_caller/network_config.dart';

class InvoiceController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadPolicy();
    loadGuideline();
  }

  Future<Map<String, dynamic>> getPolicy() async {
    final netcon = NetworkConfig();
    final response = await netcon.ApiRequestHandler(
      RequestMethod.GET,
      Urls.policy,
      '',
      is_auth: true,
    );

    return response ?? {'Failure': 'Dissapointed!'};
  }

  String? policyDescription;

  Future<void> loadPolicy() async {
    final policy = await getPolicy();
    if (policy['success'] == true &&
        policy['data'] is List &&
        policy['data'].isNotEmpty) {
      policyDescription = policy['data'][0]['description'] ?? '';
      update();
    }
  }

  Future<Map<String, dynamic>> getGuideline() async {
    final netcon = NetworkConfig();
    final response = await netcon.ApiRequestHandler(
      RequestMethod.GET,
      Urls.guidelines,
      '',
      is_auth: true,
    );

    return response ?? {'Failure': 'Dissapointed!'};
  }

  String? guidelineDescription;

  Future<void> loadGuideline() async {
    final guideline = await getGuideline();
    if (guideline['success'] == true &&
        guideline['data'] is List &&
        guideline['data'].isNotEmpty) {
      guidelineDescription = guideline['data'][0]['description'] ?? '';
      update();
      log('Guideline Description: $guidelineDescription');
    }
  }
}
