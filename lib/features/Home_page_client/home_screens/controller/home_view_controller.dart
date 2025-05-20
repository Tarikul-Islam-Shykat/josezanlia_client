import 'package:get/get.dart';

class WaterBillController extends GetxController {
  final RxString userName = 'Adam'.obs;
  final RxString meterNumber = 'A73353'.obs;
  final Rx<DateTime> expiryDate = DateTime(2025, 4, 4).obs;
  final RxDouble penaltyCharge = 50.0.obs;
  final RxString currency = 'MZN'.obs;

  final RxDouble currentReading = 44.22.obs;
  final RxDouble lastMonthReading = 50.22.obs;
  final RxDouble pricePerUnit = 70.0.obs;
  final RxDouble minimumFee = 300.0.obs;
  final RxDouble totalBill = 200.0.obs;
  final RxString billStatus = 'DUE'.obs;

  final RxList recentPayments =
      [
        {
          'provider': 'ComunAgua Water Bill',
          'date': DateTime(2025, 7, 4),
          'status': 'Paid',
        },
      ].obs;

  final RxInt notificationCount = 2.obs;
}
