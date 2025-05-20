import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/icons_path.dart';
import 'package:prettyrini/features/Home_page_client/pay_now_screen/controller/pay_now_controller.dart';

class PaymentScreen extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());

  PaymentScreen({Key? key}) : super(key: key);

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
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Payment',
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
                      const Text(
                        'Select Your Payment Method',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // M-Pesa Option
                      _buildPaymentOption(
                        'M-Pesa',
                        IconsPath.mPesaIcon,
                        Colors.green[50]!,
                      ),

                      const SizedBox(height: 12),

                      // E-Mola Option
                      _buildPaymentOption(
                        'E-Mola',
                        IconsPath.eMolaIcon,
                        Colors.orange[50]!,
                      ),

                      const SizedBox(height: 12),

                      // Bank Transfer Option
                      _buildPaymentOption(
                        'Bank Transfer',
                        IconsPath.bankIcon,
                        Colors.blue[50]!,
                      ),
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

  Widget _buildPaymentOption(String method, String logoPath, Color bgColor) {
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
              color: isSelected ? Colors.green : Colors.grey[300]!,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
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
                  width: 36,
                  height: 36,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Image.asset(logoPath, height: 24, width: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  method,
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
                      color: Colors.green,
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
