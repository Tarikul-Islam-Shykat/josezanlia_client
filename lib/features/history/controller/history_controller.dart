// controllers/history_controller.dart
import 'package:get/get.dart';

class HistoryItem {
  final String title;
  final String date;

  HistoryItem({required this.title, required this.date});
}

class HistoryController extends GetxController {
  final historyItems = <HistoryItem>[
    HistoryItem(title: "ComunAgua Water Bill", date: "4 July 2025"),
    HistoryItem(title: "ComunAgua Water Bill", date: "4 July 2025"),
    HistoryItem(title: "ComunAgua Water Bill", date: "4 July 2025"),
    HistoryItem(title: "ComunAgua Water Bill", date: "4 July 2025"),
    HistoryItem(title: "ComunAgua Water Bill", date: "4 July 2025"),
    HistoryItem(title: "ComunAgua Water Bill", date: "4 July 2025"),
  ].obs;
}
