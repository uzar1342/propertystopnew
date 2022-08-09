import 'package:get/get.dart';
import 'package:propertystop/models/response/site_visit_response.dart';
import 'package:propertystop/services/network_service.dart';

class MySiteVisitsViewModel extends GetxController {
  var isLoading = false.obs;
  var siteVisits = <SiteVisitResponse>[].obs;

  MySiteVisitsViewModel() {
    getAllSiteVisit();
  }

  Future<void> getAllSiteVisit() async {
    isLoading(true);
    var result = await NetworkService().getAllSiteVisit();
    try {
      if (result != null) {
        siteVisits.value = result;
      }
    } catch (exp) {
      print(exp);
    } finally {
      isLoading(false);
    }

    return;
  }
}
