// To parse this JSON data, do
//
//     final propertyDetailResponse = propertyDetailResponseFromJson(jsonString);

import 'dart:convert';

PropertyDetailResponse propertyDetailResponseFromJson(String str) =>
    PropertyDetailResponse.fromJson(json.decode(str));

String propertyDetailResponseToJson(PropertyDetailResponse data) =>
    json.encode(data.toJson());

class PropertyDetailResponse {
  PropertyDetailResponse({
    required this.propData,
    required this.images,
    required this.amenity,
    required this.places,
    required this.floors,
    required this.features,
    required this.rooms,
    required this.similarProps,
    required this.videos,
  });

  List<PropDatum> propData;
  List<dynamic> images;
  List<Amenity> amenity;
  List<dynamic> places;
  List<Floor> floors;
  List<dynamic> features;
  List<Room> rooms;
  List<dynamic> similarProps;
  List<Floor> videos;

  factory PropertyDetailResponse.fromJson(Map<String, dynamic> json) =>
      PropertyDetailResponse(
        propData: List<PropDatum>.from(
            json["prop_data"].map((x) => PropDatum.fromJson(x))),
        images: List<dynamic>.from(json["images"].map((x) => x)),
        amenity:
            List<Amenity>.from(json["amenity"].map((x) => Amenity.fromJson(x))),
        places: List<dynamic>.from(json["places"].map((x) => x)),
        floors: List<Floor>.from(json["floors"].map((x) => Floor.fromJson(x))),
        features: List<dynamic>.from(json["features"].map((x) => x)),
        rooms: List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
        similarProps: List<dynamic>.from(json["similar_props"].map((x) => x)),
        videos: List<Floor>.from(json["videos"].map((x) => Floor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "prop_data": List<dynamic>.from(propData.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x)),
        "amenity": List<dynamic>.from(amenity.map((x) => x.toJson())),
        "places": List<dynamic>.from(places.map((x) => x)),
        "floors": List<dynamic>.from(floors.map((x) => x.toJson())),
        "features": List<dynamic>.from(features.map((x) => x)),
        "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
        "similar_props": List<dynamic>.from(similarProps.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class Amenity {
  Amenity({
    required this.amen,
    required this.amenityImage,
  });

  String amen;
  String amenityImage;

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        amen: json["amen"],
        amenityImage: json["amenity_image"],
      );

  Map<String, dynamic> toJson() => {
        "amen": amen,
        "amenity_image": amenityImage,
      };
}

class Floor {
  Floor({
    required this.id,
    required this.url,
  });

  int id;
  String url;

  factory Floor.fromJson(Map<String, dynamic> json) => Floor(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}

class PropDatum {
  PropDatum({
    required this.id,
    required this.projectName,
    required this.propType,
    required this.propAddress,
    required this.propCity,
    required this.propPincode,
    required this.propState,
    required this.propCountry,
    required this.buildFloors,
    required this.buildWings,
    required this.builderName,
    required this.possesssionDate,
    required this.propAbout,
    required this.propLatitude,
    required this.propLongitude,
    required this.mahareraNumber,
    required this.propertyStatus,
    required this.uniqueId,
    required this.thumbnail,
  });

  int id;
  String projectName;
  String propType;
  String propAddress;
  String propCity;
  int propPincode;
  String propState;
  String propCountry;
  int buildFloors;
  int buildWings;
  String builderName;
  String possesssionDate;
  String propAbout;
  String propLatitude;
  String propLongitude;
  String mahareraNumber;
  String propertyStatus;
  String uniqueId;
  String thumbnail;

  factory PropDatum.fromJson(Map<String, dynamic> json) => PropDatum(
        id: json["id"],
        projectName: json["project_name"],
        propType: json["prop_type"],
        propAddress: json["prop_address"],
        propCity: json["prop_city"],
        propPincode: json["prop_pincode"],
        propState: json["prop_state"],
        propCountry: json["prop_country"],
        buildFloors: json["build_floors"],
        buildWings: json["build_wings"],
        builderName: json["builder_name"],
        possesssionDate: json["possesssion_date"],
        propAbout: json["prop_about"],
        propLatitude: json["prop_latitude"],
        propLongitude: json["prop_longitude"],
        mahareraNumber: json["maharera_number"],
        propertyStatus: json["property_status"],
        uniqueId: json["unique_id"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_name": projectName,
        "prop_type": propType,
        "prop_address": propAddress,
        "prop_city": propCity,
        "prop_pincode": propPincode,
        "prop_state": propState,
        "prop_country": propCountry,
        "build_floors": buildFloors,
        "build_wings": buildWings,
        "builder_name": builderName,
        "possesssion_date": possesssionDate,
        "prop_about": propAbout,
        "prop_latitude": propLatitude,
        "prop_longitude": propLongitude,
        "maharera_number": mahareraNumber,
        "property_status": propertyStatus,
        "unique_id": uniqueId,
        "thumbnail": thumbnail,
      };
}

class Room {
  Room({
    required this.roomId,
    required this.bhk,
    required this.bhkData,
  });

  int roomId;
  String bhk;
  List<BhkDatum> bhkData;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        roomId: json["room_id"],
        bhk: json["bhk"],
        bhkData: List<BhkDatum>.from(
            json["bhk_data"].map((x) => BhkDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "room_id": roomId,
        "bhk": bhk,
        "bhk_data": List<dynamic>.from(bhkData.map((x) => x.toJson())),
      };
}

class BhkDatum {
  BhkDatum({
    required this.rmId,
    required this.propCarpetArea,
    required this.propPrice,
    required this.bluePrint,
    required this.threedPrint,
  });

  int rmId;
  String propCarpetArea;
  String propPrice;
  String bluePrint;
  String threedPrint;

  factory BhkDatum.fromJson(Map<String, dynamic> json) => BhkDatum(
        rmId: json["rm_id"],
        propCarpetArea: json["prop_carpet_area"],
        propPrice: json["prop_price"],
        bluePrint: json["blue_print"],
        threedPrint: json["threed_print"],
      );

  Map<String, dynamic> toJson() => {
        "rm_id": rmId,
        "prop_carpet_area": propCarpetArea,
        "prop_price": propPrice,
        "blue_print": bluePrint,
        "threed_print": threedPrint,
      };
}
