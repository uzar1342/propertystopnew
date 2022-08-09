// To parse this JSON data, do
//
//     final siteVisitResponse = siteVisitResponseFromJson(jsonString);

import 'dart:convert';

List<SiteVisitResponse> siteVisitResponseFromJson(String str) =>
    List<SiteVisitResponse>.from(
        json.decode(str).map((x) => SiteVisitResponse.fromJson(x)));

String siteVisitResponseToJson(List<SiteVisitResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SiteVisitResponse {
  SiteVisitResponse({
    required this.srNo,
    required this.visitId,
    required this.enquiryDate,
    required this.fullName,
    required this.contactNumber,
    required this.email,
    required this.visitDate,
    required this.visitTime,
    required this.ipAddress,
    required this.projectName,
    required this.username,
    required this.contact,
  });

  int srNo;
  int visitId;
  String enquiryDate;
  String fullName;
  String contactNumber;
  String email;
  String visitDate;
  String visitTime;
  String ipAddress;
  String projectName;
  String username;
  String contact;

  factory SiteVisitResponse.fromJson(Map<String, dynamic> json) =>
      SiteVisitResponse(
        srNo: json["sr_no"],
        visitId: json["visit_id"],
        enquiryDate: json["enquiry_date"],
        fullName: json["full_name"],
        contactNumber: json["contact_number"],
        email: json["email"],
        visitDate: json["visit_date"],
        visitTime: json["visit_time"],
        ipAddress: json["ip_address"],
        projectName: json["project_name"],
        username: json["username"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "sr_no": srNo,
        "visit_id": visitId,
        "enquiry_date": enquiryDate,
        "full_name": fullName,
        "contact_number": contactNumber,
        "email": email,
        "visit_date": visitDate,
        "visit_time": visitTime,
        "ip_address": ipAddress,
        "project_name": projectName,
        "username": username,
        "contact": contact,
      };
}
