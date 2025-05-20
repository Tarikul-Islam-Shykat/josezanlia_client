// controllers/notification_controller.dart
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final notifications = List.generate(
    5,
        (index) => {
      'title': 'New Update is Available.',
      'message':
      'Please update your app. For better use & comfort to update it.',
      'date': '05 Jan 2024',
      'time': '10:00 AM',
    },
  ).obs;
}
