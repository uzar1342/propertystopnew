// To parse this JSON data, do
//
//     final resalePropertyListResponse = resalePropertyListResponseFromJson(jsonString);

import 'dart:convert';

List<ResalePropertyListResponse> resalePropertyListResponseFromJson(
        String str) =>
    List<ResalePropertyListResponse>.from(
        json.decode(str).map((x) => ResalePropertyListResponse.fromJson(x)));

String resalePropertyListResponseToJson(
        List<ResalePropertyListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResalePropertyListResponse {
  ResalePropertyListResponse({
    required this.srNo,
    required this.uniqueId,
    required this.propId,
    required this.projectName,
    required this.propAbout,
    required this.buildFloors,
    required this.propRoom,
    required this.propCarpetArea,
    required this.propPrice,
  });

  int srNo;
  String uniqueId;
  int propId;
  String projectName;
  String propAbout;
  int buildFloors;
  String propRoom;
  String propCarpetArea;
  String propPrice;

  factory ResalePropertyListResponse.fromJson(Map<String, dynamic> json) =>
      ResalePropertyListResponse(
        srNo: json["sr_no"],
        uniqueId: json["unique_id"],
        propId: json["prop_id"],
        projectName: json["project_name"],
        propAbout: json["prop_about"],
        buildFloors: json["build_floors"],
        propRoom: json["prop_room"],
        propCarpetArea: json["prop_carpet_area"],
        propPrice: json["prop_price"],
      );

  Map<String, dynamic> toJson() => {
        "sr_no": srNo,
        "unique_id": uniqueId,
        "prop_id": propId,
        "project_name": projectName,
        "prop_about": propAbout,
        "build_floors": buildFloors,
        "prop_room": propRoom,
        "prop_carpet_area": propCarpetArea,
        "prop_price": propPrice,
      };
}
