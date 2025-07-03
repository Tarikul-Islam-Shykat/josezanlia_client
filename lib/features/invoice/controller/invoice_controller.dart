import 'dart:developer';

import 'package:get/get.dart';
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:prettyrini/core/repository/network_caller/network_config.dart';

class InvoiceController extends GetxController {
  @override
  void onInit() {
    super.onInit();
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

  String? policyDescription;
  String? guidelineDescription;
  bool isLoading = false;

  Future<void> loadPolicyAndGuideline() async {
    isLoading = true;
    try {
      final policy = await getPolicy();
      if (policy['success'] == true &&
          policy['data'] is List &&
          policy['data'].isNotEmpty) {
        policyDescription = policy['data'][0]['description'] ?? '';
      }

      final guideline = await getGuideline();
      if (guideline['success'] == true &&
          guideline['data'] is List &&
          guideline['data'].isNotEmpty) {
        guidelineDescription = guideline['data'][0]['description'] ?? '';
        log('Guideline Description: $guidelineDescription');
      }
    } catch (e, stack) {
      log('Error loading policy or guideline: $e\n$stack');
    } finally {
      isLoading = false;
    }
  }
}
