// To parse this JSON data, do
//
//     final propertyListResponse = propertyListResponseFromJson(jsonString);

import 'dart:convert';

PropertyListResponse propertyListResponseFromJson(String str) =>
    PropertyListResponse.fromJson(json.decode(str));

String propertyListResponseToJson(PropertyListResponse data) =>
    json.encode(data.toJson());

class PropertyListResponse {
  PropertyListResponse({
    required this.success,
    required this.data,
    required this.len,
    required this.pageArray,
  });

  String success;
  List<Datum> data;
  int len;
  List<int> pageArray;

  factory PropertyListResponse.fromJson(Map<String, dynamic> json) =>
      PropertyListResponse(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        len: json["len"],
        pageArray: List<int>.from(json["page_array"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "len": len,
        "page_array": List<dynamic>.from(pageArray.map((x) => x)),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.projectName,
    required this.propType,
    required this.propAddress,
    required this.propCity,
    required this.propState,
    required this.propCountry,
    required this.buildFloors,
    required this.buildWings,
    required this.builderName,
    required this.possesssionDate,
    required this.buildStatusReady,
    required this.uniqueId,
    required this.propImg,
    required this.propRooms,
    required this.downloadCls,
    required this.downloadBrochure,
    required this.downloadParameter,
  });

  int id;
  String projectName;
  String propType;
  String propAddress;
  String propCity;
  String propState;
  String propCountry;
  int buildFloors;
  int buildWings;
  String builderName;
  String possesssionDate;
  String buildStatusReady;
  String uniqueId;
  String propImg;
  String propRooms;
  String downloadCls;
  String downloadBrochure;
  String downloadParameter;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        projectName: json["project_name"],
        propType: json["prop_type"],
        propAddress: json["prop_address"],
        propCity: json["prop_city"],
        propState: json["prop_state"],
        propCountry: json["prop_country"],
        buildFloors: json["build_floors"],
        buildWings: json["build_wings"],
        builderName: json["builder_name"],
        possesssionDate: json["possesssion_date"],
        buildStatusReady: json["build_status_ready"],
        uniqueId: json["unique_id"],
        propImg: json["prop_img"],
        propRooms: json["prop_rooms"],
        downloadCls: json["download_cls"],
        downloadBrochure: json["download_brochure"],
        downloadParameter: json["download_parameter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_name": projectName,
        "prop_type": propType,
        "prop_address": propAddress,
        "prop_city": propCity,
        "prop_state": propState,
        "prop_country": propCountry,
        "build_floors": buildFloors,
        "build_wings": buildWings,
        "builder_name": builderName,
        "possesssion_date": possesssionDate,
        "build_status_ready": buildStatusReady,
        "unique_id": uniqueId,
        "prop_img": propImg,
        "prop_rooms": propRooms,
        "download_cls": downloadCls,
        "download_brochure": downloadBrochure,
        "download_parameter": downloadParameter,
      };
}
