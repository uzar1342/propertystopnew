import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propertystop/models/request/add_property_request.dart';
import 'package:propertystop/models/request/register_user_request.dart';
import 'package:propertystop/models/response/property_detail_response.dart';
import 'package:propertystop/models/response/propery_list_response.dart';
import 'package:propertystop/models/response/resale_client_list_response.dart';
import 'package:propertystop/models/response/resale_property_list_response.dart';
import 'package:propertystop/models/response/site_visit_response.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  Future<PropertyListResponse?> getPropertyList() async {
    var url = Uri.parse('${constants.baseUrl}/paginate-data');

    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({'page': '1'});

    var streamedResponse =
        await request.send().timeout(const Duration(seconds: 20));

    var response = await http.Response.fromStream(streamedResponse);

    debugPrint(url.toString());
    debugPrint("getPropertyList\n" + response.statusCode.toString());
    debugPrint("getPropertyList\n" + response.body);

    if (response.statusCode == 200) {
      return (propertyListResponseFromJson(response.body));
    } else {
      Get.snackbar('Something went wrong,Please try again later',
          'Error #1 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<PropertyDetailResponse?> getPropertyDetail(String propertyId) async {
    final prefs = await SharedPreferences.getInstance();
    var mobileNumber = prefs.getString(constants.mobileNumber);

    var url = Uri.parse(
        '${constants.baseUrl}/property-details?id=$propertyId&device=Mobile&user_type=Broker&mobile_number=$mobileNumber');

    http.Response response = await http
        .get(
          url,
        )
        .timeout(const Duration(seconds: 20));

    debugPrint(url.toString());
    debugPrint("getPropertyDetail\n" + response.statusCode.toString());
    debugPrint("getPropertyDetail\n" + response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return propertyDetailResponseFromJson(jsonString);
    } else {
      //show error
      Get.snackbar('Something went wrong,Please try again later',
          'Error #2 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<String?> registerUser(RegisterUserRequest registerUserRequest) async {
    var url = Uri.parse('${constants.baseUrl}/register-user');

    var request = http.MultipartRequest('POST', url);
    print(registerUserRequest.toJson());

    request.fields.addAll(registerUserRequest.toJson());

    var streamedResponse =
        await request.send().timeout(const Duration(seconds: 20));

    var response = await http.Response.fromStream(streamedResponse);

    debugPrint(url.toString());
    debugPrint("registerUser\n" + response.statusCode.toString());
    debugPrint("registerUser\n" + response.body);

    if (response.statusCode == 200) {
      return (response.body);
    } else {
      Get.snackbar('Something went wrong,Please try again later',
          'Error #3 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<String?> verifyOtp(String otp, String mobileNumber) async {
    var url = Uri.parse('${constants.baseUrl}/verify-otp');

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'btn_otp': 'btn_otp',
      'field_otp': '',
      'otp_code': otp,
      'device': 'Mobile',
      'mobile_number': mobileNumber
    });

    var streamedResponse =
        await request.send().timeout(const Duration(seconds: 20));

    var response = await http.Response.fromStream(streamedResponse);

    debugPrint(url.toString());
    debugPrint("verifOtp\n" + response.statusCode.toString());
    debugPrint("verifOtp\n" + response.body);

    if (response.statusCode == 200) {
      return (response.body);
    } else {
      Get.snackbar('Something went wrong,Please try again later',
          'Error #3 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<String?> resendOtp() async {
    var url = Uri.parse('${constants.baseUrl}/resend-otp');

    var request = http.MultipartRequest('POST', url);

    final prefs = await SharedPreferences.getInstance();
    String? mobile = prefs.getString(constants.mobileNumber);

    request.fields.addAll({
      'resend_otp': 'resend_otp',
      'device': 'Mobile',
      'mobile_number': mobile.toString()
    });

    var streamedResponse =
        await request.send().timeout(const Duration(seconds: 20));

    var response = await http.Response.fromStream(streamedResponse);

    debugPrint(url.toString());
    debugPrint("resendOtp\n" + response.statusCode.toString());
    debugPrint("resendOtp\n" + response.body);

    if (response.statusCode == 200) {
      return (response.body);
    } else {
      Get.snackbar('Something went wrong,Please try again later',
          'Error #4 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<String?> loginUser(String mobile, String password,String type) async {
    var url = Uri.parse('${constants.baseUrl}/login-user');

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'btn_login': 'btn_login',
      'field_log': '',
      'user_type': type,
      'contact_number': mobile,
      'user_password': password,
      'device': 'Mobile'
    });

    var streamedResponse =
        await request.send().timeout(const Duration(seconds: 20));

    var response = await http.Response.fromStream(streamedResponse);

    debugPrint(url.toString());
    debugPrint("loginUser\n" + response.statusCode.toString());
    debugPrint("loginUser\n" + response.body);

    if (response.statusCode == 200) {
      return (response.body);
    } else {
      Get.snackbar('Something went wrong,Please try again later',
          'Error #5 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<String?> changePassword() async {
    var url = Uri.parse('${constants.baseUrl}/changeUserPass');

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'btn_changeUserPass': 'btn_changeUserPass',
      'contact_number': '8082019432',
      'emp_pass': 'shalini'
    });

    var streamedResponse =
        await request.send().timeout(const Duration(seconds: 20));

    var response = await http.Response.fromStream(streamedResponse);

    debugPrint(url.toString());
    debugPrint("changePassword\n" + response.statusCode.toString());
    debugPrint("changePassword\n" + response.body);

    if (response.statusCode == 200) {
      return (response.body);
    } else {
      Get.snackbar('Something went wrong,Please try again later',
          'Error #6 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<String?> getUserProfile() async {
    var url = Uri.parse('${constants.baseUrl}/getUserInfo');

    var request = http.MultipartRequest('POST', url);

    final prefs = await SharedPreferences.getInstance();
    String? mobile = prefs.getString(constants.mobileNumber);

    print(mobile);
    print("Partg");

    request.fields
        .addAll({'device': 'Mobile', 'mobile_number': mobile.toString()});

    var streamedResponse = await request.send().timeout(const Duration(seconds: 20));

    var response = await http.Response.fromStream(streamedResponse);

    debugPrint(url.toString());
    debugPrint("getUserProfile\n" + response.statusCode.toString());
    debugPrint("getUserProfile\n" + response.body);

    if (response.statusCode == 200) {
      return (response.body);
    } else {
      Get.snackbar('Something went wrong,Please try again later',
          'Error #7 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<List<SiteVisitResponse>?> getAllSiteVisit() async {
    var url = Uri.parse('${constants.baseUrl}/showMySiteVisits');

    var request = http.MultipartRequest('POST', url);

    final prefs = await SharedPreferences.getInstance();
    String? mobile = prefs.getString(constants.mobileNumber);

    request.fields.addAll({'device': 'Mobile', 'mobile_number': mobile.toString()});
    print(request.fields);
    var streamedResponse =
        await request.send().timeout(const Duration(seconds: 20));

    var response = await http.Response.fromStream(streamedResponse);

    debugPrint(url.toString());
    debugPrint("getAllSiteVisit\n" + response.statusCode.toString());
    debugPrint("getAllSiteVisit\n" + response.body);

    if (response.statusCode == 200) {
      return (siteVisitResponseFromJson(response.body));
    } else {
      Get.snackbar('Something went wrong,Please try again later',
          'Error #8 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<String?> addPropertyResale(
      AddPropertyRequest addPropertyRequest) async {
    var url = Uri.parse('${constants.baseUrl}/addAppResalePropClient');
    Map<String, String> Addtype={};
    if(constants.checktype=="Broker")
    {
      Addtype={'addAppResalePropClient': 'addAppResalePropClient'};
      url = Uri.parse(
          '${constants.baseUrl}/addAppResalePropClient');
    }
    else
    {
      Addtype={'addCustAppResalePropClient': 'addCustAppResalePropClient'};
      url = Uri.parse(
          '${constants.baseUrl}/addCustAppResalePropClient');

    }

print("Addtype"+Addtype.keys.first+Addtype.values.first);
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      Addtype.keys.first:Addtype.values.first,
      'mobile_number': addPropertyRequest.mobileNumber,
      'property_type': addPropertyRequest.propertyType,
      'project_name': addPropertyRequest.projectName,
      'prop_about': addPropertyRequest.propAbout,
      'build_floors': addPropertyRequest.buildFloors,
      'prop_rooms': addPropertyRequest.propRooms,
      'prop_carpet_area': addPropertyRequest.propCarpetArea,
      'prop_price': addPropertyRequest.propPrice
    });
    print(request.fields);

    var streamedResponse =
        await request.send().timeout(const Duration(seconds: 20));

    var response = await http.Response.fromStream(streamedResponse);

    debugPrint(url.toString());
    debugPrint("addPropertyResale\n" + response.statusCode.toString());
    debugPrint("addPropertyResale\n" + response.body);

    if (response.statusCode == 200) {
      return ((response.body));
    } else {
      Get.snackbar('Something went wrong,Please try again later',
          'Error #9 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<List<ResalePropertyListResponse>?> getResalePropertyList() async {
    final prefs = await SharedPreferences.getInstance();
    var mobileNumber = prefs.getString(constants.mobileNumber);
    var url;
    if(constants.checktype=="Broker")
      {
       url = Uri.parse(
            '${constants.baseUrl}/showAppResaleProperties?mobile_number=$mobileNumber');

      }
    else
      {
        url = Uri.parse(
            '${constants.baseUrl}/showCustAppResaleProperties?mobile_number=$mobileNumber');

      }

    http.Response response = await http
        .get(
          url,
        )
        .timeout(const Duration(seconds: 20));

    debugPrint(url.toString());
    debugPrint("getResalePropertyList\n" + response.statusCode.toString());
    debugPrint("getResalePropertyList\n" + response.body);

    if (response.statusCode == 200) {
      return resalePropertyListResponseFromJson(response.body);
    } else {
      //show error
      Get.snackbar('Something went wrong,Please try again later',
          'Error #10 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  Future<List<ResaleClientListResponse>?> getResaleClientList() async {
    final prefs = await SharedPreferences.getInstance();
    var mobileNumber = prefs.getString(constants.mobileNumber);
    var url;
    if(constants.checktype=="Broker")
    {
      url = Uri.parse(
          '${constants.baseUrl}/showAppResaleClient?mobile_number=$mobileNumber');

    }
    else
    {
      url = Uri.parse(
          '${constants.baseUrl}/showCustAppResaleClient?mobile_number=$mobileNumber');

    }

print(url);
    http.Response response = await http
        .get(
          url,
        )
        .timeout(const Duration(seconds: 20));

    debugPrint(url.toString());
    debugPrint("getClientPropertyList\n" + response.statusCode.toString());
    debugPrint("getClientPropertyList\n" + response.body);

    if (response.statusCode == 200) {
      return resaleClientListResponseFromJson(response.body);
    } else {
      //show error
      Get.snackbar('Something went wrong,Please try again later',
          'Error #11 ${response.statusCode}',
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }
}
