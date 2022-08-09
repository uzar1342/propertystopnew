// To parse this JSON data, do
//
//     final addPropertyRequest = addPropertyRequestFromJson(jsonString);

import 'dart:convert';

AddPropertyRequest addPropertyRequestFromJson(String str) =>
    AddPropertyRequest.fromJson(json.decode(str));

String addPropertyRequestToJson(AddPropertyRequest data) =>
    json.encode(data.toJson());

class AddPropertyRequest {
  AddPropertyRequest({
    required this.addAppResalePropClient,
    required this.mobileNumber,
    required this.propertyType,
    required this.projectName,
    required this.propAbout,
    required this.buildFloors,
    required this.propRooms,
    required this.propCarpetArea,
    required this.propPrice,
  });

  String addAppResalePropClient;
  String mobileNumber;
  String propertyType;
  String projectName;
  String propAbout;
  String buildFloors;
  String propRooms;
  String propCarpetArea;
  String propPrice;

  factory AddPropertyRequest.fromJson(Map<String, dynamic> json) =>
      AddPropertyRequest(
        addAppResalePropClient: json["addAppResalePropClient"],
        mobileNumber: json["mobile_number"],
        propertyType: json["property_type"],
        projectName: json["project_name"],
        propAbout: json["prop_about"],
        buildFloors: json["build_floors"],
        propRooms: json["prop_rooms"],
        propCarpetArea: json["prop_carpet_area"],
        propPrice: json["prop_price"],
      );

  Map<String, dynamic> toJson() => {
        "addAppResalePropClient": addAppResalePropClient,
        "mobile_number": mobileNumber,
        "property_type": propertyType,
        "project_name": projectName,
        "prop_about": propAbout,
        "build_floors": buildFloors,
        "prop_rooms": propRooms,
        "prop_carpet_area": propCarpetArea,
        "prop_price": propPrice,
      };
}
