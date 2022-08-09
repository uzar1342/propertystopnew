import 'package:get/get.dart';
import 'package:propertystop/models/response/propery_list_response.dart';
import 'package:propertystop/services/network_service.dart';

class PropertyListViewModel extends GetxController {
  var isLoading = false.obs;
  var propertyList = <Datum>[].obs;

  // PropertyListViewModel(){
  //   getPropertyList();
  // }

  Future<void> getPropertyList() async {
    isLoading(true);
    var result = await NetworkService().getPropertyList();

    try {
      if (result != null) {
        propertyList.value = result.data;
      }
    } catch (exp) {
      print(exp);
    } finally {
      isLoading(false);
    }

    return;
  }
}
