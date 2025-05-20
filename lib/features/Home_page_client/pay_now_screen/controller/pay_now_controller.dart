import 'package:get/get.dart';
import 'package:prettyrini/features/Home_page_client/pay_now_screen/view/payment_details_screen.dart';

// class PaymentController extends GetxController {
//   final selectedMethod = 'M-Pesa'.obs;

//   void selectPaymentMethod(String method) {
//     selectedMethod.value = method;
//   }
// }

class PaymentController extends GetxController {
  final selectedMethod = 'M-Pesa'.obs;

  void selectPaymentMethod(String method) {
    selectedMethod.value = method;
    // Navigate to payment details screen
    Get.to(() => PaymentDetailsScreen(paymentMethod: method));
  }
}
