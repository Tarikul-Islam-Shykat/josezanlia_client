import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/icons_path.dart';
import 'package:prettyrini/features/Auth_Screen/screens/utils/show_success_dialog.dart';
import 'package:prettyrini/route/route.dart';

class PaymentDetailsScreen extends StatelessWidget {
  // final PaymentController controller = Get.put(PaymentController());
  final String paymentMethod;

  const PaymentDetailsScreen({super.key, required this.paymentMethod});

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
                      _buildPaymentOption('86 12 34 456', IconsPath.eMolaIcon),

                      const SizedBox(height: 12),

                      // E-Mola Option
                      _buildPaymentOption('636348727', IconsPath.timerIcon),

                      const SizedBox(height: 12),

                      // Bank Transfer Option
                      _buildPaymentOption('July 2025', IconsPath.calenderIcon),
                      const SizedBox(height: 12),
                      _buildPaymentOption('635 MZN', IconsPath.sendMoneyIcon),

                      const SizedBox(height: 12),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0x338C8482),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 30,

                                decoration: BoxDecoration(),
                                child: Image.asset(
                                  IconsPath.eMolaIcon,
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Enter my Mobile number',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF8C8482),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      _submit(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B3A3D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Confirm to Pay',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
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
    return
    // final isSelected = controller.selectedMethod.value == method;
    GestureDetector(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0x338C8482), width: 2),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withValues(alpha: 0.1),
          //     spreadRadius: 1,
          //     blurRadius: 2,
          //     offset: const Offset(0, 1),
          //   ),
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 30,

                decoration: BoxDecoration(),
                child: Image.asset(logoPath, height: 35, width: 35),
              ),
              const SizedBox(width: 12),
              Text(
                method,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    showSuccessDialog(
      buttonText: 'Done',
      context: context,
      title: 'Success',
      message: 'Your payment is successfully Complete!',
      image: Image.asset('assets/images/tick.png', height: 70.h, width: 70.w),
      onDonePressed: () {
        Get.toNamed(AppRoute.invoiceScreen);
      },
    );
  }
}
