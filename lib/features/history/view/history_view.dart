// views/history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/history_controller.dart';
import '../widget/history_item_tile.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('History', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.historyItems.length,
          itemBuilder: (context, index) {
            final item = controller.historyItems[index];
            return HistoryItemTile(title: item.title, date: item.date);
          },
        ),
      ),
    );
  }
}
