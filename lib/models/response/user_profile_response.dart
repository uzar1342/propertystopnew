// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) =>
    json.encode(data.toJson());

class UserProfileResponse {
  UserProfileResponse({
    required this.success,
    required this.data,
  });

  String success;
  Data data;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.registerDate,
    required this.fullName,
    required this.contactNumber,
    required this.email,
    required this.status,
    required this.userType,
  });

  int userId;
  String registerDate;
  String fullName;
  String contactNumber;
  String email;
  String status;
  String userType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        registerDate: json["register_date"],
        fullName: json["full_name"],
        contactNumber: json["contact_number"],
        email: json["email"],
        status: json["status"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "register_date": registerDate,
        "full_name": fullName,
        "contact_number": contactNumber,
        "email": email,
        "status": status,
        "user_type": userType,
      };
}
