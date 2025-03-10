class UserModel {
  String? message;
  bool? error;
  int? code;
  Results? results;

  UserModel({this.message, this.error, this.code, this.results});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    code = json['code'];
    results =
        json['results'] != null ? Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['error'] = error;
    data['code'] = code;
    if (results != null) {
      data['results'] = results!.toJson();
    }
    return data;
  }
}

class Results {
  Data? data;

  Results({this.data});

  Results.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? mobileNo;
  dynamic status;
  String? role;
  dynamic companyId;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.status,
    this.role,
    this.companyId,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNo = json['mobileNo'];
    status = json['status'];
    role = json['role'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobileNo'] = mobileNo;
    data['status'] = status;
    data['role'] = role;
    data['companyId'] = companyId;
    return data;
  }
}
