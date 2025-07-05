// controllers/history_controller.dart
import 'dart:developer';

import 'package:get/get.dart';
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:prettyrini/core/repository/network_caller/network_config.dart';
import 'package:prettyrini/features/invoice/controller/invoice_controller.dart';
import 'package:prettyrini/features/profile/controller/user_info_controller.dart';
import '../model/history_model.dart';

class HistoryController extends GetxController {
  final InvoiceController invoiceController = Get.put(InvoiceController());
  final UserProfileController userController =
      Get.find<UserProfileController>();

  Future<HistoryModel> fetchHistory() async {
    final networkcon = NetworkConfig();
    final consumerList = userController.userProfile.value.consumer;
    final id =
        (consumerList != null &&
                consumerList.isNotEmpty &&
                consumerList[0].id != null)
            ? consumerList[0].id
            : 0;
    final url = '${Urls.history}/$id';
    final response = await networkcon.ApiRequestHandler(
      RequestMethod.GET,
      url,
      null,
      is_auth: true,
    );
    if (response != null) {
      return HistoryModel.fromJson(response);
    } else {
      return HistoryModel(
        success: false,
        message: "Failed to fetch data",
        data: HistoryData(data: []),
      );
    }
  }

  final historyItems = <PaymentRecord>[].obs;

  RxBool isLoading = false.obs;

  Future<void> loadHistory() async {
    isLoading.value = true;
    // Wait for user profile to be loaded
    while (userController.isLoading.value) {
      await Future.delayed(Duration(milliseconds: 500));
      log('Waiting for user profile to load...');
    }
    log('User profile loaded, proceeding to fetch history.');
    final historyModel = await fetchHistory();
    if (historyModel.success) {
      historyItems.value = historyModel.data.data;
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    loadHistory();
    super.onInit();
    invoiceController.loadPolicyAndGuideline();
  }
}
