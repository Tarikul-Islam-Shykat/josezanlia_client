import 'dart:convert';

GetMyProfile getMyProfileFromJson(String str) =>
    GetMyProfile.fromJson(json.decode(str));

String getMyProfileToJson(GetMyProfile data) => json.encode(data.toJson());

class GetMyProfile {
  GetMyProfile({this.success, this.message, this.data});

  GetMyProfile.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
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
    this.worker,
  });

  Data.fromJson(dynamic json) {
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    dob = json['dob'];
    profileImage = json['profileImage'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    isDeleted = json['isDeleted'];
    isApproved = json['isApproved'];
    isCompleteProfile = json['isCompleteProfile'];
    role = json['role'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['worker'] != null) {
      worker = [];
      json['worker'].forEach((v) {
        worker?.add(Worker.fromJson(v));
      });
    }
  }

  String? userName;
  String? email;
  String? phone;
  String? dob;
  String? profileImage;
  String? address;
  num? lat;
  num? lng;
  bool? isDeleted;
  bool? isApproved;
  bool? isCompleteProfile;
  String? role;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Worker>? worker;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['email'] = email;
    map['phone'] = phone;
    map['dob'] = dob;
    map['profileImage'] = profileImage;
    map['address'] = address;
    map['lat'] = lat;
    map['lng'] = lng;
    map['isDeleted'] = isDeleted;
    map['isApproved'] = isApproved;
    map['isCompleteProfile'] = isCompleteProfile;
    map['role'] = role;
    map['status'] = status;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    if (worker != null) {
      map['worker'] = worker?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Worker workerFromJson(String str) => Worker.fromJson(json.decode(str));

String workerToJson(Worker data) => json.encode(data.toJson());

class Worker {
  Worker({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.taxId,
    this.nid,
    this.alterContact,
    this.workerRole,
    this.department,
    this.zone,
    this.joiningDate,
    this.workerId,
    this.attachment,
    this.createdAt,
    this.updatedAt,
  });

  Worker.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    taxId = json['taxId'];
    nid = json['nid'];
    alterContact = json['alterContact'];
    workerRole = json['workerRole'];
    department = json['department'];
    zone = json['zone'];
    joiningDate = json['joiningDate'];
    workerId = json['workerId'];
    attachment = json['attachment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  String? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? taxId;
  String? nid;
  String? alterContact;
  String? workerRole;
  String? department;
  String? zone;
  String? joiningDate;
  String? workerId;
  String? attachment;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['taxId'] = taxId;
    map['nid'] = nid;
    map['alterContact'] = alterContact;
    map['workerRole'] = workerRole;
    map['department'] = department;
    map['zone'] = zone;
    map['joiningDate'] = joiningDate;
    map['workerId'] = workerId;
    map['attachment'] = attachment;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
