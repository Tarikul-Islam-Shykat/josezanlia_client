import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;

  bool get isConnected => _channel != null;

  void connect(String url, String token) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _authenticate(token);
  }

  void _authenticate(String token) {
    final authMessage = jsonEncode({"event": "authenticate", "token": token});
    _channel?.sink.add(authMessage);
    if (kDebugMode) {
      print("Sent authentication message: $authMessage");
    }
  }

  Stream get messages => _channel!.stream;

  void sendMessage(String event) {
    if (_channel == null) {
      if (kDebugMode) print("WebSocket not connected. Message not sent.");
      return;
    }

    final message = jsonEncode({"event": event});
    _channel!.sink.add(message);
    if (kDebugMode) {
      print("Sent WebSocket message: $message");
    }
  }

  void sendMessageWithPayLoad(String event, Map<String, dynamic> data) {


    if (_channel == null) {
      if (kDebugMode) print("WebSocket not connected. Message not sent.");
      return;
    }
    final message = jsonEncode({"event": event, ...data});
    _channel!.sink.add(message);
    if (kDebugMode) {
      print("Sent WebSocket message: $message");
    }
  }

  void close() {
    if (kDebugMode) {
      print("Closing WebSocket connection.");
    }
    _channel?.sink.close();
    _channel = null;
  }
}
