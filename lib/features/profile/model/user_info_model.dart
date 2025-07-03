
class UserProfileModel {
  final String? userName;
  final String? email;
  final String? phone;
  final DateTime? dob;
  final String? profileImage;
  final String? address;
  final double? lat;
  final double? lng;
  final bool? isDeleted;
  final bool? isApproved;
  final bool? isCompleteProfile;
  final String? role;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Consumer>? consumer;

  UserProfileModel({
    this.userName,
    this.email,
    this.phone,
    this.dob,
    this.profileImage,
    this.address,
    this.lat,
    this.lng,
    this.isDeleted,
    this.isApproved,
    this.isCompleteProfile,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.consumer,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    userName: json["userName"],
    email: json["email"],
    phone: json["phone"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    profileImage: json["profileImage"],
    address: json["address"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    isDeleted: json["isDeleted"],
    isApproved: json["isApproved"],
    isCompleteProfile: json["isCompleteProfile"],
    role: json["role"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    consumer: json["consumer"] == null ? [] : List<Consumer>.from(json["consumer"]!.map((x) => Consumer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "email": email,
    "phone": phone,
    "dob": dob?.toIso8601String(),
    "profileImage": profileImage,
    "address": address,
    "lat": lat,
    "lng": lng,
    "isDeleted": isDeleted,
    "isApproved": isApproved,
    "isCompleteProfile": isCompleteProfile,
    "role": role,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "consumer": consumer == null ? [] : List<dynamic>.from(consumer!.map((x) => x.toJson())),
  };
}

class Consumer {
  final String? id;
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? taxId;
  final String? propertyType;
  final int? plotNumber;
  final String? bairro;
  final String? alterContact;
  final String? occupation;
  final String? connectionType;
  final String? nid;
  final String? meterNumber;
  final int? regFee;
  final String? attachment;
  final int? topUpBalance;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Consumer({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.taxId,
    this.propertyType,
    this.plotNumber,
    this.bairro,
    this.alterContact,
    this.occupation,
    this.connectionType,
    this.nid,
    this.meterNumber,
    this.regFee,
    this.attachment,
    this.topUpBalance,
    this.createdAt,
    this.updatedAt,
  });

  factory Consumer.fromJson(Map<String, dynamic> json) => Consumer(
    id: json["id"],
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    taxId: json["taxId"],
    propertyType: json["propertyType"],
    plotNumber: json["plotNumber"],
    bairro: json["bairro"],
    alterContact: json["alterContact"],
    occupation: json["occupation"],
    connectionType: json["connectionType"],
    nid: json["nid"],
    meterNumber: json["meterNumber"],
    regFee: json["regFee"],
    attachment: json["attachment"],
    topUpBalance: json["topUpBalance"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "taxId": taxId,
    "propertyType": propertyType,
    "plotNumber": plotNumber,
    "bairro": bairro,
    "alterContact": alterContact,
    "occupation": occupation,
    "connectionType": connectionType,
    "nid": nid,
    "meterNumber": meterNumber,
    "regFee": regFee,
    "attachment": attachment,
    "topUpBalance": topUpBalance,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
