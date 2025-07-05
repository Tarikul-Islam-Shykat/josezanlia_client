// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:prettyrini/core/global_widegts/custom_app_bar.dart';
//
// import '../controller/chat_controller.dart';
//
// class ChatView extends StatelessWidget {
//   final controller = Get.put(ChatController());
//
//   ChatView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             CustomAppBar(title: 'Admin'),
//
//             // Chat messages
//             Expanded(
//               child: Obx(() {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListView.builder(
//                     reverse: true,
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     itemCount: controller.messages.length,
//                     itemBuilder: (context, index) {
//                       final message =
//                           controller.messages.reversed.toList()[index];
//                       return Align(
//                         alignment:
//                             message.isSender
//                                 ? Alignment.centerRight
//                                 : Alignment.centerLeft,
//                         child: Row(
//                           mainAxisAlignment:
//                               message.isSender
//                                   ? MainAxisAlignment.end
//                                   : MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             if (!message.isSender)
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: CircleAvatar(
//                                   radius: 16,
//                                   backgroundImage: AssetImage(
//                                     'assets/images/user_profile.png',
//                                   ), // your avatar
//                                 ),
//                               ),
//                             Flexible(
//                               child: Container(
//                                 margin: const EdgeInsets.symmetric(vertical: 4),
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 14,
//                                   vertical: 10,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color:
//                                       message.isSender
//                                           ? Colors.blue
//                                           : Colors.grey.shade200,
//                                   // borderRadius: BorderRadius.circular(16),
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(16),
//                                     topRight: Radius.circular(16),
//                                     bottomLeft: Radius.circular(16),
//                                   ),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       message.text,
//                                       style: TextStyle(
//                                         color:
//                                             message.isSender
//                                                 ? Colors.white
//                                                 : Colors.black87,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           message.time,
//                                           style: TextStyle(
//                                             fontSize: 10,
//                                             color:
//                                                 message.isSender
//                                                     ? Colors.white70
//                                                     : Colors.grey,
//                                           ),
//                                         ),
//                                         if (message.isSender)
//                                           const SizedBox(width: 4),
//                                         if (message.isSender)
//                                           Icon(
//                                             Icons.done_all,
//                                             size: 14,
//                                             color: Colors.white70,
//                                           ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             if (message.isSender)
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: CircleAvatar(
//                                   radius: 16,
//                                   backgroundImage: AssetImage(
//                                     'assets/images/user_profile.png',
//                                   ), // your avatar
//                                 ),
//                               ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }),
//             ),
//
//             // Input field
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 border: Border(top: BorderSide(color: Colors.grey.shade300)),
//                 color: Colors.white,
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Obx(
//                       () => TextField(
//                         controller: controller.messageController.value,
//                         decoration: InputDecoration(
//                           hintText: "Write your message...",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(24),
//                             borderSide: BorderSide.none,
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey.shade100,
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Padding(
//                     padding: EdgeInsets.all(12.w),
//                     child: GestureDetector(
//                       onTap: controller.sendMessage,
//                       child: Icon(
//                         Icons.send,
//                         size: 20.h,
//                         color: Color(0xFF0B3A3D),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
