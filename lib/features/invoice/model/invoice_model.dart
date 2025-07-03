// Models

class PersonalInformation {
  final String name;
  final String number;
  final String location;

  PersonalInformation({
    required this.name,
    required this.number,
    required this.location,
  });

  factory PersonalInformation.fromJson(Map<String, dynamic> json) {
    return PersonalInformation(
      name: json['name'],
      number: json['number'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'number': number, 'location': location};
  }
}

class OtherDetails {
  final String id;
  final String paymentMonth;
  final int currentReading;
  final int previousReading;
  final double penalty;
  final double totalAmount;
  final String status;
  final String createdAt;
  final int consumption;
  final double minimumBill;
  final double perUnitCharge;
  final double penaltyCharge;

  OtherDetails({
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

  // Getter to compute totalBill dynamically
  String get totalBill {
    // Format totalAmount to string with MZN
    return "${totalAmount.toStringAsFixed(2)} MZN";
  }

  factory OtherDetails.fromJson(Map<String, dynamic> json) {
    return OtherDetails(
      id: json['id'],
      paymentMonth: json['paymentMonth'],
      currentReading: json['currentReading'],
      previousReading: json['previousReading'],
      penalty: json['penalty'].toDouble(),
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
      createdAt: json['createdAt'],
      consumption: json['consumption'],
      minimumBill: json['minimumBill'].toDouble(),
      perUnitCharge: json['perUnitCharge'].toDouble(),
      penaltyCharge: json['penaltyCharge'].toDouble(),
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
      'totalBill': totalBill,
    };
  }
}
