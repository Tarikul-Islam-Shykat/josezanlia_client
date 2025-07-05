import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_loader.dart';
import 'package:prettyrini/core/const/icons_path.dart';
import 'package:prettyrini/core/style/global_text_style.dart';
import 'package:prettyrini/features/Auth_Screen/screens/utils/show_success_dialog.dart';
import 'package:prettyrini/features/Home_page_client/Add_request_page/controller/request_controller.dart';
import 'package:prettyrini/features/Home_page_client/pay_now_screen/controller/pay_now_controller.dart';
import 'package:prettyrini/features/invoice/controller/invoice_controller.dart';
import 'package:prettyrini/route/route.dart';

class RequestTopUpScreen extends StatelessWidget {
  RequestTopUpScreen({super.key});
  final TopUpController controller = Get.put(TopUpController());

  final InvoiceController guidelineController = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background_image.png',
                ), // Change to your image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      // top: 60.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF187C82).withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 18,
                                ),
                                onPressed: () => Get.back(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Top Up',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // TabBar
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B3A3D),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap:
                                        () =>
                                            controller.changeTab('Add Request'),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            controller.selectedTab.value ==
                                                    'Add Request'
                                                ? Colors.white
                                                : const Color(0xFF0B3A3D),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Add Request',
                                        style: TextStyle(
                                          color:
                                              controller.selectedTab.value ==
                                                      'Add Request'
                                                  ? const Color(0xFF0B3A3D)
                                                  : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap:
                                        () => controller.changeTab('Payment'),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            controller.selectedTab.value ==
                                                    'Payment'
                                                ? Colors.white
                                                : const Color(0xFF0B3A3D),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Payment',
                                        style: TextStyle(
                                          color:
                                              controller.selectedTab.value ==
                                                      'Payment'
                                                  ? const Color(0xFF0B3A3D)
                                                  : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        // Tab Content
                        Obx(
                          () =>
                              controller.selectedTab.value == 'Add Request'
                                  ? _buildAddRequestContent()
                                  : BuildPaymentContent(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRequestContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Request to Admin to Approve',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.transactionIdController,
            decoration: InputDecoration(
              hintText: 'Transaction ID', // Placeholder text
              border: const OutlineInputBorder(),
              prefixIcon: const SizedBox(
                height: 18,
                width: 18,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(image: AssetImage(IconsPath.timerIcon)),
                ),
              ), // Added an icon
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );

              if (result != null && result.files.single.path != null) {
                // Store the selected PDF file path
                controller.selectedPdfPath.value = result.files.single.path!;
              }
            },
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(Icons.attach_file, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Obx(() {
                      final fileName =
                          controller.selectedPdfPath.value.isNotEmpty
                              ? controller.selectedPdfPath.value.split('/').last
                              : 'Attachment (PDF only)';
                      return Text(
                        fileName,
                        style: TextStyle(
                          color:
                              fileName == 'Attachment (PDF only)'
                                  ? Colors.grey
                                  : Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Top Up Guidelines',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child:
                guidelineController.guidelineDescription != null
                    ? SizedBox(
                      width: double.infinity,
                      child: SelectableText.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Html(
                                data: guidelineController.guidelineDescription,
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(14.sp),
                                    color: Colors.black87,
                                  ),
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Validation: Check if both fields are filled
              if (controller.transactionIdController.text.trim().isEmpty ||
                  controller.selectedPdfPath.value.isEmpty) {
                Get.snackbar(
                  'Incomplete Request',
                  'Please enter Transaction ID and attach a PDF file',
                  // backgroundColor: Colors.red.withOpacity(0.8),
                  colorText: Colors.black,
                  snackPosition: SnackPosition.TOP,
                  snackStyle: SnackStyle.FLOATING,
                );
                return;
              }
              await _submit(Get.context!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B3A3D),
              minimumSize: const Size(double.infinity, 50), // Full width button
            ),
            child: Obx(
              () =>
                  controller.isLoading.value
                      ? Center(child: loader())
                      : Text(
                        'Submit',
                        style: globalTextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (controller.isLoading.value) return;
    controller.isLoading.value = true;
    try {
      await controller.fileupload(controller.transactionIdController.text);
      showSuccessDialog(
        buttonText: 'Done',
        context: context,
        title: 'Success',
        message: 'Please allow up to 24 hours for your receipt to be approved.',
        image: Image.asset('assets/images/tick.png', height: 70.h, width: 70.w),
        onDonePressed: () {
          Get.toNamed(AppRoute.topUpInvoiceScreen);
        },
      );
    } finally {
      controller.isLoading.value = false;
    }
  }

  BuildPaymentContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Your Payment Method',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }

  Widget _buildPaymentOption(String method, String logoPath) {
    final PaymentController controller = Get.put(PaymentController());
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
