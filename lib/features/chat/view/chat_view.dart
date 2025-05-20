import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/chat_controller.dart';


class ChatView extends StatelessWidget {
  final controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFDA6200).withValues(alpha: 0.20),
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Text("Admin", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Chat messages
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages.reversed.toList()[index];
                    return Align(
                      alignment: message.isSender ? Alignment.centerRight : Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment:
                        message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!message.isSender)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundImage: AssetImage('assets/images/user_profile.png'), // your avatar
                              ),
                            ),
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: message.isSender ? Colors.blue : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    message.text,
                                    style: TextStyle(
                                      color: message.isSender ? Colors.white : Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        message.time,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: message.isSender ? Colors.white70 : Colors.grey,
                                        ),
                                      ),
                                      if (message.isSender)
                                        const SizedBox(width: 4),
                                      if (message.isSender)
                                        Icon(Icons.done_all,
                                            size: 14, color: Colors.white70),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (message.isSender)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundImage: AssetImage('assets/images/user_profile.png'), // your avatar
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),

            // Input field
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => TextField(
                      controller: controller.messageController.value,
                      decoration: InputDecoration(
                        hintText: "Write your message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    )),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: controller.sendMessage,
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
