// views/history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_loader.dart';
import 'package:prettyrini/features/invoice/view/invoice_screen.dart';

import '../controller/history_controller.dart';
import '../widget/history_item_tile.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'history'.tr,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? Center(child: loaderCubeGrid())
                : ListView.builder(
                  itemCount: controller.historyItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.historyItems[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => InvoiceScreen(
                            arguments: {
                              'id': item.id,
                              'paymentMonth': item.paymentMonth,
                              'currentReading': item.currentReading,
                              'previousReading': item.previousReading,
                              'penalty': item.penalty,
                              'totalAmount': item.totalAmount,
                              'status': item.status,
                              'createdAt': item.createdAt,
                              'consumption': item.consumption,
                              'minimumBill': item.minimumBill,
                              'perUnitCharge': item.perUnitCharge,
                              'penaltyCharge': item.penaltyCharge,
                            },
                          ),
                          transition: Transition.fadeIn,
                        );
                      },
                      child: HistoryItemTile(
                        title: 'comunagua_water_bill'.tr,
                        date: item.paymentMonth,
                        status: item.status,
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
