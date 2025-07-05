// ignore_for_file: unnecessary_null_comparison

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:prettyrini/core/const/app_colors.dart';
// import 'package:prettyrini/core/const/image_path.dart';
//
// import '../../../../core/const/app_loader.dart';
// import '../../../../core/style/global_text_style.dart';
// import '../controller/chats_controller.dart';
//
//
// class ChatScreen extends StatelessWidget {
//  // final String receiverId;
//   final String name;
//   final String? imageUrl;
//   final TextEditingController _messageController = TextEditingController();
//
//   final ChatController _chatController = Get.put(ChatController());
//
//   ChatScreen({
//     super.key,
//    // required this.receiverId,
//     required this.name,
//     this.imageUrl,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     //_chatController.fetchChats();
//
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: Column(
//         children: [
//           _buildTopBar(name, imageUrl!, context),
//           Expanded(
//             child: Obx(() {
//               if (_chatController.isLoadingChats.value) {
//                 return Center(child: loader2());
//               }
//               if (_chatController.chats.isEmpty) {
//                 return const Center(child: Text("No messages found."));
//               }
//               return ListView.builder(
//                 itemCount: _chatController.chats.length,
//                 itemBuilder: (context, index) {
//                   final chat = _chatController.chats[index];
//                   //final isMine = chat['senderId'] != receiverId;
//                   final isMine = true;
//                   return Align(
//                     alignment:
//                         isMine ? Alignment.centerRight : Alignment.centerLeft,
//                     child: Container(
//                       margin: const EdgeInsets.all(8),
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: isMine ? Colors.grey : Colors.blue,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         chat['message'] ?? '',
//                         style: globalTextStyle(
//                           color:
//                               isMine
//                                   ? AppColors.whiteColor
//                                   : AppColors.whiteColor,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//           Container(
//             decoration: BoxDecoration(color: Colors.grey.shade800),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 bottom: 20,
//                 top: 20,
//                 right: 10,
//                 left: 10,
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       style: TextStyle(color: Colors.white),
//                       controller: _messageController,
//                       decoration: InputDecoration(
//                         fillColor: AppColors.primaryColor.withValues(
//                           alpha: 0.1,
//                         ),
//                         filled: true,
//                         hintText: "Type a message...",
//                         hintStyle: TextStyle(color: Colors.white),
//                         border: InputBorder.none,
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 20,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide(
//                             color: AppColors.primaryColor,
//                             width: 0,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide(
//                             color: AppColors.primaryColor,
//                             width: 0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: AppColors.primaryColor),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(3.0),
//                       child: IconButton(
//                         icon: Icon(Icons.send, color: Colors.white),
//                         onPressed: () {
//                           final message = _messageController.text.trim();
//                           if (message.isNotEmpty) {
//                             _chatController.sendMessage(message);
//                             _messageController.clear();
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTopBar(String name, String imaegPath, BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         color: AppColors.primaryColor,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         children: [
//           SizedBox(height: 60.0),
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   //_chatController.fetchUserList();
//                   Get.back();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade800,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Icon(Icons.arrow_back, color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               imaegPath == null
//                   ? CircleAvatar(
//                     radius: 30,
//                     backgroundImage: AssetImage(ImagePath.userProfile),
//                   )
//                   : ClipOval(
//                     child: Image.network(
//                       imaegPath,
//                       width: 60,
//                       height: 60,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return CircleAvatar(
//                           radius: 30,
//                           backgroundImage: AssetImage(
//                             ImagePath.userProfile,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//               SizedBox(width: 10),
//               Text(
//                 name,
//                 textAlign: TextAlign.end,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16.sp,
//                 ),
//               ),
//               Spacer(),
//             ],
//           ),
//           SizedBox(height: 5),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../core/repository/services_class/local_service/shared_preferences_helper.dart';
import '../controller/chats_controller.dart';
import '../model/message_model.dart';

// class ChatPage extends StatelessWidget {
//   final ChatController controller = Get.put(ChatController());
//
//   ChatPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Chat'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         // actions: [
//         //   Obx(() => controller.isConnected.value
//         //       ? const Icon(Icons.wifi, color: Colors.green)
//         //       : const Icon(Icons.wifi_off, color: Colors.red)),
//         //   const SizedBox(width: 16),
//         //   Obx(() => controller.unreadCount.value > 0
//         //       ? Badge(
//         //     label: Text(controller.unreadCount.value.toString()),
//         //     child: const Icon(Icons.notifications),
//         //   )
//         //       : const Icon(Icons.notifications_none)),
//         //   const SizedBox(width: 16),
//         // ],
//       ),
//       body: Column(
//         children: [
//           // Messages List
//           Expanded(
//             child: Obx(() {
//               if (controller.messages.isEmpty) {
//                 return const Center(
//                   child: Text('No messages yet'),
//                 );
//               }
//               return ListView.builder(
//                 controller: controller.scrollController,
//                 itemCount: controller.messages.length,
//                 itemBuilder: (context, index) {
//                   final message = controller.messages[index];
//                   final isMe = message.senderId == controller.currentUserId;
//                   return _buildMessageBubble(message, isMe);
//                 },
//               );
//             }),
//           ),
//           // Message Input
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageBubble(MessageModel message, bool isMe) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           if (!isMe) ...[
//             CircleAvatar(
//               backgroundImage: message.sender?.profileImage.isNotEmpty == true
//                   ? NetworkImage(message.sender!.profileImage)
//                   : null,
//               child: message.sender?.profileImage.isEmpty == true
//                   ? const Icon(Icons.person)
//                   : null,
//             ),
//             const SizedBox(width: 8),
//           ],
//           Flexible(
//             child: Column(
//               crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//               children: [
//                 if (!isMe && message.sender?.consumer.isNotEmpty == true)
//                   Text(
//                     '${message.sender!.consumer.first.firstName} ${message.sender!.consumer.first.lastName}',
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   decoration: BoxDecoration(
//                     color: isMe ? Colors.blue : Colors.grey[300],
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   child: Text(
//                     message.message,
//                     style: TextStyle(
//                       color: isMe ? Colors.white : Colors.black,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       DateFormat('HH:mm').format(message.timestamp),
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     if (isMe) ...[
//                       const SizedBox(width: 4),
//                       Icon(
//                         message.isRead ? Icons.done_all : Icons.done,
//                         size: 16,
//                         color: message.isRead ? Colors.blue : Colors.grey,
//                       ),
//                     ],
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (isMe) ...[
//             const SizedBox(width: 8),
//             const CircleAvatar(
//               child: Icon(Icons.person),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, -3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: controller.messageController,
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(24),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//               ),
//               onSubmitted: (_) => controller.sendMessage(),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Obx(() => FloatingActionButton(
//             mini: true,
//             onPressed: controller.isConnected.value
//                 ? controller.sendMessage
//                 : null,
//             backgroundColor: controller.isConnected.value
//                 ? Colors.blue
//                 : Colors.grey,
//             child: const Icon(Icons.send, color: Colors.white),
//           )),
//         ],
//       ),
//     );
//   }
// }


class ChatPage extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Chat'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: Obx(() {
              if (controller.messages.isEmpty) {
                return const Center(
                  child: Text('No messages yet'),
                );
              }
              return ListView.builder(
                controller: controller.scrollController,
                reverse: true, // This makes the list show newest messages at bottom
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  final isMe = message.senderId == controller.currentUserId;
                  return _buildMessageBubble(message, isMe);
                },
              );
            }),
          ),
          // Message Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? profileImage, bool isAdmin) {
    if (isAdmin) {
      // Admin avatar - use asset image
      return CircleAvatar(
        backgroundImage: AssetImage('assets/images/logo.png'),
        backgroundColor: Colors.transparent,
      );
    } else {
      // User avatar - check if there's a profile image from SharedPreferences
      return FutureBuilder<String?>(
        future: _getUserProfileImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // User has profile image saved in SharedPreferences
            return CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data!),
              backgroundColor: Colors.grey[300],
            );
          } else if (profileImage?.isNotEmpty == true) {
            // Fallback to sender's profile image from message
            return CircleAvatar(
              backgroundImage: NetworkImage(profileImage!),
              backgroundColor: Colors.grey[300],
            );
          } else {
            // Default avatar
            return CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, color: Colors.grey),
            );
          }
        },
      );
    }
  }

  Future<String?> _getUserProfileImage() async {
    // Replace 'profile_image' with your actual SharedPreferences key
    return await SharedPreferencesHelper.getUserProfileImage();
  }

  Widget _buildMessageBubble(MessageModel message, bool isMe) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            _buildAvatar(message.sender?.profileImage, true), // Admin asset image
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe && message.sender?.consumer.isNotEmpty == true)
                  Text(
                    '${message.sender!.consumer.first.firstName} ${message.sender!.consumer.first.lastName}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    message.message,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(message.timestamp),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      Icon(
                        message.isRead ? Icons.done_all : Icons.done,
                        size: 16,
                        color: message.isRead ? Colors.blue : Colors.grey,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            _buildAvatar(null, false), // Your avatar from SharedPreferences
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => controller.sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          Obx(() => FloatingActionButton(
            mini: true,
            onPressed: controller.isConnected.value
                ? controller.sendMessage
                : null,
            backgroundColor: controller.isConnected.value
                ? Colors.blue
                : Colors.grey,
            child: const Icon(Icons.send, color: Colors.white),
          )),
        ],
      ),
    );
  }
}