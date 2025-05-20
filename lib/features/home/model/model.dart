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
  final String meterNumber;
  final String currentReading;
  final String lastMonthReading;
  final String consumption;
  final String pricePerM3;
  final String minimumFare;
  final String penaltyFare;
  final String paymentStatus;
  final String paymentMethod;

  OtherDetails({
    required this.meterNumber,
    required this.currentReading,
    required this.lastMonthReading,
    required this.consumption,
    required this.pricePerM3,
    required this.minimumFare,
    required this.penaltyFare,
    required this.paymentStatus,
    required this.paymentMethod,
  });

  // Getter to compute totalBill dynamically
  String get totalBill {
    double parseValue(String value) {
      final cleaned = value.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleaned) ?? 0.0;
    }

    // Extract numeric values
    final consumptionValue = parseValue(consumption);
    final pricePerM3Value = parseValue(pricePerM3);
    final minimumFareValue = parseValue(minimumFare);
    final penaltyFareValue = parseValue(penaltyFare);

    // Calculate total bill
    final total =
        (consumptionValue * pricePerM3Value) +
        minimumFareValue +
        penaltyFareValue;

    // Format back to string with MZN
    return "${total.toStringAsFixed(2)} MZN";
  }

  factory OtherDetails.fromJson(Map<String, dynamic> json) {
    return OtherDetails(
      meterNumber: json['meterNumber'],
      currentReading: json['currentReading'],
      lastMonthReading: json['lastMonthReading'],
      consumption: json['consumption'],
      pricePerM3: json['pricePerM3'],
      minimumFare: json['minimumFare'],
      penaltyFare: json['penaltyFare'],
      paymentStatus: json['paymentStatus'],
      paymentMethod: json['paymentMethod'] ?? 'M-Pesa',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meterNumber': meterNumber,
      'currentReading': currentReading,
      'lastMonthReading': lastMonthReading,
      'consumption': consumption,
      'pricePerM3': pricePerM3,
      'minimumFare': minimumFare,
      'penaltyFare': penaltyFare,
      'totalBill': totalBill,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
    };
  }
}

class Observations {
  final List<String> items;

  Observations({required this.items});

  factory Observations.fromJson(Map<String, dynamic> json) {
    return Observations(items: List<String>.from(json['items']));
  }

  Map<String, dynamic> toJson() {
    return {'items': items};
  }
}
