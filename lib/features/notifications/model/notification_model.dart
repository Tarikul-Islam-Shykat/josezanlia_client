class NotificationModel {
  final String? id;
  final String? userId;
  final String? title;
  final String? body;
  final String? data;
  final bool? read;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.data,
    this.read,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      data: json['data'],
      read: json['read'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "title": title,
    "body": body,
    "data": data,
    "read": read,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
