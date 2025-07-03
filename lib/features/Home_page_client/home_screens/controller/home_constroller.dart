import 'dart:developer';
import 'package:get/get.dart';
import '../../../../core/repository/network_caller/endpoints.dart';
import '../../../../core/repository/network_caller/network_config.dart';
import '../model/get_all_reading_model.dart';

class ConsumerReadingController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();

  RxList<ConsumerReadingModel> readingList = <ConsumerReadingModel>[].obs;
  RxBool isLoading = false.obs;

RxString selectMonth = ''.obs;


  RxInt totalRecords = 0.obs;
  RxInt currentPage = 1.obs;



  Future<bool> getConsumerReadings(id) async {
    isLoading.value = true;
    try {
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        "${Urls.getConsumerReading}/$id",
        {},
        is_auth: true,
      );

      if (response != null && response["success"] == true) {
        final List<dynamic> rawList = response["data"]["data"];
        readingList.value =
            rawList.map((e) => ConsumerReadingModel.fromJson(e)).toList();

        // Sort by month descending (latest first)
        readingList.sort((a, b) => b.paymentMonth!.compareTo(a.paymentMonth!));

        if (readingList.isNotEmpty) {
          selectMonth.value = readingList.first.paymentMonth!;
        }

        totalRecords.value = response["data"]["meta"]["total"] ?? 0;
        currentPage.value = response["data"]["meta"]["page"] ?? 1;

        return true;
      } else {
        log("Failed: ${response["message"]}");
        return false;
      }
    } catch (e) {
      log("Exception: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  ConsumerReadingModel? get selectedReading =>
      readingList.firstWhereOrNull((e) => e.paymentMonth == selectMonth.value);

  void goToPreviousMonth() {
    final index = readingList.indexWhere((e) => e.paymentMonth == selectMonth.value);
    if (index != -1 && index < readingList.length - 1) {
      selectMonth.value = readingList[index + 1].paymentMonth!;
    }
  }

  void goToNextMonth() {
    final index = readingList.indexWhere((e) => e.paymentMonth == selectMonth.value);
    if (index > 0) {
      selectMonth.value = readingList[index - 1].paymentMonth!;
    }
  }
  String get currentMonthLabel {
    if (selectMonth.isEmpty) return '';
    try {
      final parts = selectMonth.split('-');
      if (parts.length == 2) {
        final month = int.parse(parts[1]);
        final year = parts[0];
        const monthNames = [
          '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ];
        return '${monthNames[month]} $year';
      }
    } catch (_) {}
    return selectMonth.value;
  }

}
