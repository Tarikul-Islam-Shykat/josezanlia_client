// controllers/history_controller.dart
import 'package:get/get.dart';
import 'package:prettyrini/core/repository/network_caller/endpoints.dart';
import 'package:prettyrini/core/repository/network_caller/network_config.dart';
import 'package:prettyrini/features/invoice/controller/invoice_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/history_model.dart';

class HistoryController extends GetxController {
  final InvoiceController invoiceController = Get.put(InvoiceController());


  Future<HistoryModel> fetchHistory() async {
    final networkcon = NetworkConfig();
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '684aa2023386147b777055fb';
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
