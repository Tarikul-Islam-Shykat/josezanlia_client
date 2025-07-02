// views/history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/features/home/view/invoice_screen.dart';

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
        title: const Text(
          'History',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.historyItems.length,
          itemBuilder: (context, index) {
            final item = controller.historyItems[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => InvoiceScreen());
              },
              child: HistoryItemTile(title: "ComunAgua Water Bill", date: item.paymentMonth),
            );
          },
        ),
      ),
    );
  }
}
