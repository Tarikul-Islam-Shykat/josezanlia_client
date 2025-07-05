// Models

class PaymentDetails {
  final String number;
  final String tID;
  final String time;
  final String amount;

  PaymentDetails({
    required this.number,
    required this.tID,
    required this.time,
    required this.amount,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      number: json['number'],
      tID: json['tID'],
      time: json['time'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'number': number, 'tID': tID, 'time': time, 'amount': amount};
  }
}
