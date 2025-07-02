// import 'package:get/get.dart';
// import 'package:prettyrini/features/Home_page_client/pay_now_screen/view/e_mola_payment.dart';

// class PaymentController extends GetxController {
//   final selectedMethod = 'M-Pesa'.obs;

//   void selectPaymentMethod(String method) {
//     selectedMethod.value = method;
//     // Navigate to payment details screen
//     Get.to(() => EMolaPayment(paymentMethod: method));
//   }
// }

import 'package:get/get.dart';
import 'package:prettyrini/features/Home_page_client/pay_now_screen/view/bank_transfer_payment.dart';
import 'package:prettyrini/features/Home_page_client/pay_now_screen/view/e_mola_payment.dart';
import 'package:prettyrini/features/Home_page_client/pay_now_screen/view/m_pesa_payment.dart';

class PaymentController extends GetxController {
  final selectedMethod = ''.obs;

  void selectPaymentMethod(String method) {
    selectedMethod.value = method;

    // Navigate based on selected method
    switch (method) {
      case 'M-Pesa':
        Get.to(() => MPesaPayment(paymentMethod: method));
        break;
      case 'E-Mola':
        Get.to(() => EMolaPayment(paymentMethod: method));
        break;
      case 'Bank Transfer':
        Get.to(() => BankTransferPayment(paymentMethod: method));
        break;
      default:
        break;
    }
  }
}
