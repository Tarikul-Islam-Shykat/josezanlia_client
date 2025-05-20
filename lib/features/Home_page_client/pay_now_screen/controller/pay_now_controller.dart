import 'package:get/get.dart';

class PaymentController extends GetxController {
  final selectedMethod = 'M-Pesa'.obs;

  void selectPaymentMethod(String method) {
    selectedMethod.value = method;
  }
}
