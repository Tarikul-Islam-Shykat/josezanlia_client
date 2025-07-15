// ignore_for_file: unnecessary_null_comparison


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/const/app_loader.dart';
import 'package:prettyrini/core/style/global_text_style.dart';
import 'package:prettyrini/features/chat/controller/chats_controller.dart';
import 'package:prettyrini/features/profile/controller/user_info_controller.dart';

class ChatScreen extends StatelessWidget {
  final String receiverId;
  final String name;
  final String? imageUrl;
  final TextEditingController _messageController = TextEditingController();

  final ChatController _chatController = Get.put(ChatController());
  final UserProfileController controller = Get.find<UserProfileController>();

  ChatScreen({
    super.key,
    required this.receiverId,
    required this.name,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    _chatController.fetchChats(receiverId);

    return Scaffold(
      backgroundColor: appGreenColor,
      body: Column(
        children: [
          _buildTopBar(name, imageUrl!, context),
          Expanded(
            child: Obx(() {
              if (_chatController.isLoadingChats.value) {
                return Center(child: loader2());
              }
              if (_chatController.chats.isEmpty) {
                return const Center(child: Text("No messages found."));
              }
              return ListView.builder(
                itemCount: _chatController.chats.length,
                itemBuilder: (context, index) {
                  final chat = _chatController.chats[index];
                  final isMine =
                      chat['senderId'] ==
                      controller.userProfile.value.consumer?[0].userId;
                  return Align(
                    alignment:
                        isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMine ? Colors.blueAccent : Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        chat['message'] ?? '',
                        style: globalTextStyle(
                          color:
                              isMine
                                  ? AppColors.whiteColor
                                  : AppColors.whiteColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white30),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                top: 20,
                right: 10,
                left: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                        onPressed: () {
                          final message = _messageController.text.trim();
                          if (message.isNotEmpty) {
                            _chatController.sendMessage(receiverId, message);
                            _messageController.clear();
                          }
                        },
                      ),
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

  Widget _buildTopBar(String name, String imaegPath, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              imaegPath == null
                  ? CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(ImagePath.userProfile),
                  )
                  : ClipOval(
                    child: Image.network(
                      imaegPath,
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(ImagePath.userProfile),
                        );
                      },
                    ),
                  ),
              SizedBox(width: 10),
              Text(
                name,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
