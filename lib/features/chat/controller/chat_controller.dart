import 'package:get/get.dart';
import 'package:flutter/material.dart';



class ChatController extends GetxController {
  var messages = <Message>[].obs;
  final messageController = Rx<TextEditingController>(TextEditingController());

  void sendMessage() {
    final text = messageController.value.text.trim();
    if (text.isNotEmpty) {
      messages.add(
        Message(
          text: text,
          time: _getCurrentTime(),
          isSender: true,
        ),
      );
      messageController.value.clear();
      // Simulate admin reply
      Future.delayed(Duration(seconds: 1), () {
        messages.add(
          Message(
            text: "Hi... i want to know more about your services and other facilities",
            time: _getCurrentTime(),
            isSender: false,
          ),
        );
      });
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }
}

class Message {
  final String text;
  final String time;
  final bool isSender;

  Message({required this.text, required this.time, required this.isSender});
}
