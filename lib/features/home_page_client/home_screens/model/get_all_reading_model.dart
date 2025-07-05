class ConsumerReadingModel {
  final String? id;
  final String? meterNumber;
  final String? paymentMonth;
  final int? currentReading;
  final int? previousReading;
  final int? penalty;
  final int? minimumFee;
  final String? unit;
  final double? perUnitCharge;
  final int? penaltyCharge;
  final int? totalAmount;
  final String? status;
  final String? expiredAt;

  ConsumerReadingModel({
    this.id,
    this.meterNumber,
    this.paymentMonth,
    this.currentReading,
    this.previousReading,
    this.penalty,
    this.minimumFee,
    this.unit,
    this.perUnitCharge,
    this.penaltyCharge,
    this.totalAmount,
    this.status,
    this.expiredAt,
  });

  factory ConsumerReadingModel.fromJson(Map<String, dynamic> json) {
    return ConsumerReadingModel(
      id: json["id"],
      meterNumber: json["meterNumber"],
      paymentMonth: json["paymentMonth"],
      currentReading: json["currentReading"],
      previousReading: json["previousReading"],
      penalty: json["penalty"],
      minimumFee: json["minimumFee"],
      unit: json["unit"],
      perUnitCharge: (json["perUnitCharge"] ?? 0).toDouble(),
      penaltyCharge: json["penaltyCharge"],
      totalAmount: json["totalAmount"],
      status: json["status"],
      expiredAt: json["expiredAt"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "meterNumber": meterNumber,
    "paymentMonth": paymentMonth,
    "currentReading": currentReading,
    "previousReading": previousReading,
    "penalty": penalty,
    "minimumFee": minimumFee,
    "unit": unit,
    "perUnitCharge": perUnitCharge,
    "penaltyCharge": penaltyCharge,
    "totalAmount": totalAmount,
    "status": status,
    "expiredAt": expiredAt,
  };
}
