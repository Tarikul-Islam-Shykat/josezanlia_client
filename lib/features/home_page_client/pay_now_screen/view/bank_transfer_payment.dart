import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/icons_path.dart';
import 'package:prettyrini/features/Auth_Screen/screens/utils/show_success_dialog.dart';
import 'package:prettyrini/features/profile/controller/user_info_controller.dart';
import 'package:prettyrini/route/route.dart';

class BankTransferPayment extends StatelessWidget {
  final UserProfileController userController = Get.put(UserProfileController());
  final String paymentMethod;

  BankTransferPayment({super.key, required this.paymentMethod});
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      _buildPaymentOption('86 12 34 456', IconsPath.bankIcon),

                      const SizedBox(height: 12),

                      // E-Mola Option
                      _buildPaymentOption(
                        (userController.userProfile.value.consumer != null &&
                                userController
                                    .userProfile
                                    .value
                                    .consumer!
                                    .isNotEmpty)
                            ? userController
                                    .userProfile
                                    .value
                                    .consumer![0]
                                    .meterNumber ??
                                ''
                            : '',
                        IconsPath.timerIcon,
                      ),

                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(now.year, now.month),
                            firstDate: DateTime(now.year - 5, 1),
                            lastDate: DateTime(now.year + 5, 12),
                            initialDatePickerMode: DatePickerMode.year,
                            selectableDayPredicate: (date) => date.day == 1,
                            helpText: 'select_month'.tr,
                          );
                          if (picked != null) {}
                        },
                        child: _buildPaymentOption(
                          "${_getTranslatedMonthName(now.month)} ${now.year}",
                          IconsPath.calenderIcon,
                        ),
                      ),
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
                              SizedBox(
                                width: 40,
                                height: 30,
                                child: Image.asset(
                                  IconsPath.sendMoneyIcon,
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'amount'.tr,
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF8C8482),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'MZN',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

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
                                  IconsPath.bankIcon,
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'enter_my_mobile_number'.tr,
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF8C8482),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
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
                    child: Text(
                      'confirm_to_pay'.tr,
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
      buttonText: 'done'.tr,
      context: context,
      title: 'success'.tr,
      message: 'payment_successful'.tr,
      image: Image.asset('assets/images/tick.png', height: 70.h, width: 70.w),
      onDonePressed: () {
        Get.toNamed(AppRoute.invoiceScreen);
      },
    );
  }

  String _getTranslatedMonthName(int month) {
    switch (month) {
      case 1:
        return 'january'.tr;
      case 2:
        return 'february'.tr;
      case 3:
        return 'march'.tr;
      case 4:
        return 'april'.tr;
      case 5:
        return 'may'.tr;
      case 6:
        return 'june'.tr;
      case 7:
        return 'july'.tr;
      case 8:
        return 'august'.tr;
      case 9:
        return 'september'.tr;
      case 10:
        return 'october'.tr;
      case 11:
        return 'november'.tr;
      case 12:
        return 'december'.tr;
      default:
        return '';
    }
  }
}
