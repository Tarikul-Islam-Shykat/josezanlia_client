import 'dart:developer';
import 'package:get/get.dart';
import '../../../../core/repository/network_caller/endpoints.dart';
import '../../../../core/repository/network_caller/network_config.dart';
import '../model/get_all_reading_model.dart';


class ConsumerReadingController extends GetxController {
  final NetworkConfig _networkConfig = NetworkConfig();

  RxList<ConsumerReadingModel> readingList = <ConsumerReadingModel>[].obs;
  RxBool isLoading = false.obs;

  // Optional: pagination info
  RxInt totalRecords = 0.obs;
  RxInt currentPage = 1.obs;
  onInit(){
    super.onInit();
    getConsumerReadings();
  }

  Future<bool> getConsumerReadings() async {
    isLoading.value = true;

    try {
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        Urls.getConsumerReading,
        {},
        is_auth: true,
      );

      if (response != null && response["success"] == true) {
        final List<dynamic> rawList = response["data"]["data"];
        readingList.value =
            rawList.map((e) => ConsumerReadingModel.fromJson(e)).toList();

        // update meta
        totalRecords.value = response["data"]["meta"]["total"] ?? 0;
        currentPage.value = response["data"]["meta"]["page"] ?? 1;

        log("Consumer readings loaded: ${readingList.length}");
        return true;
      } else {
        log("Failed to fetch readings: ${response["message"]}");
        return false;
      }
    } catch (e) {
      log("Exception in getConsumerReadings: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
