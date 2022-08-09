import 'package:get/get.dart';
import 'package:propertystop/models/response/resale_client_list_response.dart';
import 'package:propertystop/models/response/resale_property_list_response.dart';
import 'package:propertystop/services/network_service.dart';

class ResaleListViewModel extends GetxController {
  var isClientLoading = false.obs;
  var isPropertyLoading = false.obs;
  var resaleClientList = <ResaleClientListResponse>[].obs;
  var resalePropertyList = <ResalePropertyListResponse>[].obs;

  Future<void> getResalePropertyList() async {
    isPropertyLoading(true);
    var result = await NetworkService().getResalePropertyList();

    try {
      if (result != null) {
        resalePropertyList.value = result;
      }
    } catch (exp) {
      print(exp);
    } finally {
      isPropertyLoading(false);
    }

    return;
  }

  Future<void> getResaleClientList() async {
    isClientLoading(true);
    var result = await NetworkService().getResaleClientList();

    try {
      if (result != null) {
        resaleClientList.value = result;
      }
    } catch (exp) {
      print(exp);
    } finally {
      isClientLoading(false);
    }
    return;
  }
}
