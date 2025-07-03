class HistoryModel {
  final bool success;
  final String message;
  final HistoryData data;

  HistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: HistoryData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class HistoryData {
  final List<PaymentRecord> data;

  HistoryData({
    required this.data,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List<dynamic>? ?? [];
    List<PaymentRecord> records = list.map((item) => PaymentRecord.fromJson(item)).toList();
    return HistoryData(data: records);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((record) => record.toJson()).toList(),
    };
  }
}

class PaymentRecord {
  final String id;
  final String paymentMonth;
  final int currentReading;
  final int previousReading;
  final int penalty;
  final int totalAmount;
  final String status;
  final String createdAt;
  final int consumption;
  final int minimumBill;
  final double perUnitCharge;
  final int penaltyCharge;

  PaymentRecord({
    required this.id,
    required this.paymentMonth,
    required this.currentReading,
    required this.previousReading,
    required this.penalty,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.consumption,
    required this.minimumBill,
    required this.perUnitCharge,
    required this.penaltyCharge,
  });

  factory PaymentRecord.fromJson(Map<String, dynamic> json) {
    return PaymentRecord(
      id: json['id'] ?? '',
      paymentMonth: json['paymentMonth'] ?? '',
      currentReading: json['currentReading'] ?? 0,
      previousReading: json['previousReading'] ?? 0,
      penalty: json['penalty'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      consumption: json['consumption'] ?? 0,
      minimumBill: json['minimumBill'] ?? 0,
      perUnitCharge: (json['perUnitCharge'] as num?)?.toDouble() ?? 0.0,
      penaltyCharge: json['penaltyCharge'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paymentMonth': paymentMonth,
      'currentReading': currentReading,
      'previousReading': previousReading,
      'penalty': penalty,
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': createdAt,
      'consumption': consumption,
      'minimumBill': minimumBill,
      'perUnitCharge': perUnitCharge,
      'penaltyCharge': penaltyCharge,
    };
  }
}
