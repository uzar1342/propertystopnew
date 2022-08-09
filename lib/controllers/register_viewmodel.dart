import 'dart:convert';

import 'package:get/get.dart';
import 'package:propertystop/models/request/register_user_request.dart';
import 'package:propertystop/services/network_service.dart';

class RegisterViewModel extends GetxController {
  var isLoading = false.obs;
  var isNewUser = false.obs;
  var message = "".obs;

  Future<void> registerUser(RegisterUserRequest registerUserRequest) async {
    isLoading(true);
    var result = await NetworkService().registerUser(registerUserRequest);
    try {
      if (result != null) {
        isNewUser.value = json.decode(result)["success"] == "0" ? false : true;
        message.value = json.decode(result)["message"];
      }
    } catch (exp) {
      print(exp);
    } finally {
      isLoading(false);
    }

    return;
  }
}
