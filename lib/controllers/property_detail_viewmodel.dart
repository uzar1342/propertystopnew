import 'package:get/get.dart';
import 'package:propertystop/models/response/property_detail_response.dart';
import 'package:propertystop/screens/broker/models/property.dart';
import 'package:propertystop/services/network_service.dart';

class PropertyDetailViewModel extends GetxController {
  var isLoading = false.obs;
  var propertyDetail = Rxn<PropertyDetailResponse>();
  var propDetails = <PropertyDetails>[].obs;

  // PropertyListViewModel(){
  //   getPropertyList();
  // }

  Future<void> getPropertyDetail(String propertyId) async {
    isLoading(true);
    var result = await NetworkService().getPropertyDetail(propertyId);
print(result);
    try {
      if (result != null) {
        propertyDetail.value = result;
        propDetails.value = [
          PropertyDetails(
              title: "Maharera Number",
              value: result.propData[0].mahareraNumber),
          PropertyDetails(
              title: "Property Status",
              value: result.propData[0].propertyStatus),
          PropertyDetails(
              title: "Possesssion Date",
              value: result.propData[0].possesssionDate),
          PropertyDetails(
              title: "Floors",
              value: result.propData[0].buildFloors.toString() + " floors"),
          PropertyDetails(
              title: "Wings",
              value: result.propData[0].buildWings.toString() + " wings"),
          PropertyDetails(
              title: "Property Type", value: result.propData[0].propType),
        ];
      }
    } catch (exp) {
      print(exp);
    } finally {
      isLoading(false);
    }

    return;
  }
}
