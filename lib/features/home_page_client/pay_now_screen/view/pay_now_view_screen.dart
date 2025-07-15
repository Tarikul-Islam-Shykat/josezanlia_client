import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/icons_path.dart';
import 'package:prettyrini/features/Home_page_client/pay_now_screen/controller/pay_now_controller.dart';

class PaymentScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

    PaymentScreen({super.key});

  String _getTranslatedMethod(String method) {
    switch (method) {
      case 'M-Pesa':
        return 'm_pesa'.tr;
      case 'E-Mola':
        return 'e_mola'.tr;
      case 'Bank Transfer':
        return 'bank_transfer'.tr;
      default:
        return method;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Image.asset(
              'assets/images/background_image.png',
              fit: BoxFit.cover,
            ),
          ),

          // Payment selection UI
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and title
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF187C82).withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'payment'.tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Payment method selection
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'select_payment_method'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // M-Pesa Option
                      _buildPaymentOption('M-Pesa', IconsPath.mPesaIcon),

                      const SizedBox(height: 12),

                      // E-Mola Option
                      _buildPaymentOption('E-Mola', IconsPath.eMolaIcon),

                      const SizedBox(height: 12),

                      // Bank Transfer Option
                      _buildPaymentOption('Bank Transfer', IconsPath.bankIcon),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method, String logoPath) {
    return Obx(() {
      final isSelected = controller.selectedMethod.value == method;

      return GestureDetector(
        onTap: () => controller.selectPaymentMethod(method),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.green : Color(0x338C8482),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 40,
                  // padding: const EdgeInsets.all(),
                  decoration: BoxDecoration(
                    // color: bgColor,
                    // borderRadius: BorderRadius.circular(6),
                  ),
                  child: Image.asset(logoPath, height: 35, width: 35),
                ),
                const SizedBox(width: 12),
                Text(
                  _getTranslatedMethod(method),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Color(0xFF0B3A3D),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
