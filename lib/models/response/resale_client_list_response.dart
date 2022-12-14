// To parse this JSON data, do
//
//     final resaleClientListResponse = resaleClientListResponseFromJson(jsonString);

import 'dart:convert';

List<ResaleClientListResponse> resaleClientListResponseFromJson(String str) =>
    List<ResaleClientListResponse>.from(
        json.decode(str).map((x) => ResaleClientListResponse.fromJson(x)));

String resaleClientListResponseToJson(List<ResaleClientListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResaleClientListResponse {
  ResaleClientListResponse({
    required this.srNo,
    required this.uniqueId,
    required this.propId,
    required this.projectName,
    required this.propAbout,
    required this.buildFloors,
    required this.propRoom,
    required this.propCarpetArea,
    required this.propPrice,
    this.other_broker_property_data,
  });
  dynamic other_broker_property_data;
  int srNo;
  String uniqueId;
  int propId;
  String projectName;
  String propAbout;
  int buildFloors;
  String propRoom;
  dynamic propCarpetArea;
  dynamic propPrice;

  factory ResaleClientListResponse.fromJson(Map<String, dynamic> json) =>
      ResaleClientListResponse(
        srNo: json["sr_no"],
        uniqueId: json["unique_id"],
        propId: json["prop_id"],
        projectName: json["project_name"],
        propAbout: json["prop_about"],
        buildFloors: json["build_floors"],
        propRoom: json["prop_room"],
        propCarpetArea: json["prop_carpet_area"],
        propPrice: json["prop_price"],
        other_broker_property_data: json["other_broker_property_data"] == null ? null : List<ResaleClientListResponse>.from(json["other_broker_property_data"].map((x) => ResaleClientListResponse.fromJson(x))),
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
    "other_broker_property_data": other_broker_property_data == null ? null : List<dynamic>.from(other_broker_property_data.map((x) => x.toJson())),
  };
}
