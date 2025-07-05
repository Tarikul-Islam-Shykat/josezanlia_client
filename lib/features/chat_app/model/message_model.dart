class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final List<String> files;
  final DateTime timestamp;
  final String roomId;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SenderModel? sender;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.files,
    required this.timestamp,
    required this.roomId,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    this.sender,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      message: json['message'] ?? '',
      files: List<String>.from(json['files'] ?? []),
      timestamp: DateTime.parse(json['timestamp']),
      roomId: json['roomId'] ?? '',
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      sender: json['sender'] != null ? SenderModel.fromJson(json['sender']) : null,
    );
  }
}

class SenderModel {
  final String id;
  final String role;
  final String profileImage;
  final String userName;
  final List<ConsumerModel> consumer;

  SenderModel({
    required this.id,
    required this.role,
    required this.profileImage,
    required this.userName,
    required this.consumer,
  });

  factory SenderModel.fromJson(Map<String, dynamic> json) {
    return SenderModel(
      id: json['id'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profileImage'] ?? '',
      userName: json['userName'] ?? '',
      consumer: (json['consumer'] as List<dynamic>?)
          ?.map((e) => ConsumerModel.fromJson(e))
          .toList() ?? [],
    );
  }
}

class ConsumerModel {
  final String firstName;
  final String lastName;

  ConsumerModel({
    required this.firstName,
    required this.lastName,
  });

  factory ConsumerModel.fromJson(Map<String, dynamic> json) {
    return ConsumerModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }
}