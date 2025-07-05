// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:prettyrini/core/network_caller/endpoints.dart';
//
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../service/chat_service.dart';
//
// class ChatController extends GetxController {
//   final WebSocketService _socketService = WebSocketService();
//
//   var usersWithLastMessages = [].obs;
//   var chats = [].obs;
//
//   // Loading states
//   var isLoadingChats = true.obs;
//   var isLoadingUserList = false.obs;
//   var isRefreshingUserList = false.obs;
//   var isSendingMessage = false.obs;
//
//   void connectSocket(String url, String token) {
//     _socketService.connect(url, token);
//     _socketService.messages.listen((message) {
//       _handleMessage(message);
//     });
//     //fetchUserList();
//   }
//
//   void _handleMessage(dynamic message) {
//     if (kDebugMode) {
//       print("Received WebSocket message: $message");
//     }
//
//     final data = jsonDecode(message);
//
//     switch (data['event']) {
//       // case "messageList":
//       //   usersWithLastMessages.value = data['data'];
//       //   // Stop loading states for user list operations
//       //   isLoadingUserList.value = false;
//       //   isRefreshingUserList.value = false;
//       //   break;
//       case "fetchChatsAdmin":
//         chats.value = data['data'];
//         isLoadingChats.value = false;
//         break;
//       // case "messageAdmin":
//       //   chats.add(data['data']);
//       //   chats.refresh();
//       //   // Stop sending message loading state
//       //   isSendingMessage.value = false;
//       //   break;
//       default:
//         if (kDebugMode) {
//           print("Unknown event type: ${data['event']}");
//         }
//     }
//
//     if (kDebugMode) {
//       print("Current chats at handle Message: $chats");
//     }
//
//
//
//
//
//
//   }
//
//   // void fetchUserList() {
//   //   isLoadingUserList.value = true;
//   //   _socketService.sendMessage("messageList", {});
//   // }
//
//   // Future<void> refreshUserList() async {
//   //   isRefreshingUserList.value = true;
//   //   usersWithLastMessages.clear();
//   //   fetchUserList();
//   // }
//
//   void fetchChats() {
//     isLoadingChats.value = true;
//     _socketService.sendMessage("fetchChatsAdmin");
//   }
//
//   void sendMessage(String message) {
//     isSendingMessage.value = true;
//     final payload = {
//       "message": message,
//     };
//     _socketService.sendMessageWithPayLoad("messageAdmin", payload);
//   }
//
//   @override
//   void onClose() {
//     _socketService.close();
//     super.onClose();
//   }
//
//   @override
//   void onInit() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//
//     if (kDebugMode) {
//       print("Initializing WebSocket connection...");
//     }
//
//     if (token != null) {
//       connectSocket(Urls.websocketUrl, token);
//
//       // Delay fetch until the connection is established (optional guard)
//       Future.delayed(Duration(seconds: 1), () {
//         fetchChats();
//       });
//     } else {
//       if (kDebugMode) {
//         print("No token found.");
//       }
//     }
//
//     super.onInit();
//   }
//
// }




import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../../core/repository/services_class/local_service/shared_preferences_helper.dart';
import '../model/message_model.dart';

class ChatController extends GetxController {
  late WebSocketChannel _channel;
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isConnected = false.obs;
  final RxBool isLoading = false.obs;
  final RxInt unreadCount = 0.obs;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Your authentication token
  String authToken = "";
  String currentUserId = "";

  @override
  void onInit() async {
    super.onInit();
    await getDataFromSharedPref();
    connectToWebSocket();

  }


  Future<void> getDataFromSharedPref() async {
    // Here you can retrieve any necessary data from shared preferences
    // For example, you might want to fetch the user ID or other settings
    // This is just a placeholder for your actual implementation
    String? workerUserId = await SharedPreferencesHelper.getUserWorkerId();
    String? token = await SharedPreferencesHelper.getAccessToken();
    if (workerUserId != null) {
      currentUserId = workerUserId;
    }
    if (token != null) {
      authToken = token;
    }

    if (kDebugMode) {
      debugPrint("Current User ID: at getDataFromSharedPref $currentUserId");

    }
    if (kDebugMode) {
      debugPrint("Auth Token: $authToken");
    }


  }

  void connectToWebSocket() {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('wss://g6d0ftvr-5005.inc1.devtunnels.ms'),
      );

      isConnected.value = true;

      // Authenticate
      _channel.sink.add(jsonEncode({
        "event": "authenticate",
        "token": authToken,
      }));

      // Set user status
      // _channel.sink.add(jsonEncode({
      //   "event": "userStatus",
      //   "data": {
      //     "userId": currentUserId,
      //     "isOnline": true,
      //   }
      // }));

      // Fetch existing chats
      fetchChats();

      // Listen to messages
      _channel.stream.listen(
            (data) {
          handleWebSocketMessage(data);
        },
        onError: (error) {
          print('WebSocket Error: $error');
          isConnected.value = false;
        },
        onDone: () {
          print('WebSocket connection closed');
          isConnected.value = false;
        },
      );
    } catch (e) {
      print('Failed to connect to WebSocket: $e');
      isConnected.value = false;
    }
  }

  void handleWebSocketMessage(dynamic data) {
    try {
      final Map<String, dynamic> json = jsonDecode(data);
      final String event = json['event'] ?? '';

      switch (event) {
        case 'messageAdmin':
          if (json['data'] != null) {
            final message = MessageModel.fromJson(json['data']);
            //messages.add(message);
            messages.insert(0, message);
            scrollToBottom();
          }
          break;
        case 'fetchChatsAdmin':
          if (json['data'] != null) {
            final List<dynamic> chatData = json['data'];
            final List<MessageModel> fetchedMessages = chatData
                .map((item) => MessageModel.fromJson(item))
                .toList();
            fetchedMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
            messages.assignAll(fetchedMessages);
            scrollToBottom();
          }
          break;
        case 'unReadMessagesAdmin':
          if (json['data'] != null) {
            unreadCount.value = json['data']['count'] ?? 0;
          }
          break;
      }
    } catch (e) {
      print('Error handling WebSocket message: $e');
    }
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    final message = messageController.text.trim();
    messageController.clear();

    _channel.sink.add(jsonEncode({
      "event": "messageAdmin",
      "message": message,
    }));
  }

  void fetchChats() {
    _channel.sink.add(jsonEncode({
      "event": "fetchChatsAdmin",
    }));
  }

  void fetchUnreadMessages() {
    _channel.sink.add(jsonEncode({
      "event": "unReadMessagesAdmin",
    }));
  }

  // void scrollToBottom() {
  //   if (scrollController.hasClients) {
  //     Future.delayed(const Duration(milliseconds: 100), () {
  //       scrollController.animateTo(
  //         scrollController.position.maxScrollExtent,
  //         duration: const Duration(milliseconds: 300),
  //         curve: Curves.easeOut,
  //       );
  //     });
  //   }
  // }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.animateTo(
          0.0, // Scroll to top of reverse list (which is bottom visually)
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }




  @override
  void onClose() {
    _channel.sink.close(status.goingAway);
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}













