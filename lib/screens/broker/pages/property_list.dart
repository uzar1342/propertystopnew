import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:propertystop/controllers/property_list_viewmodel.dart';
import 'package:propertystop/models/response/propery_list_response.dart';
import 'package:propertystop/screens/broker/components/property_card.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrokerPropertyListPage extends StatefulWidget {
  const BrokerPropertyListPage({Key? key}) : super(key: key);

  @override
  State<BrokerPropertyListPage> createState() => _BrokerPropertyListPageState();
}

class _BrokerPropertyListPageState extends State<BrokerPropertyListPage> {
  String? locality;
  final controller = PropertyListViewModel();
  TextEditingController mobileNumberInput = TextEditingController();


  getLocation() async {
    Placemark? p = await getAddressFromLatLong(null, null);
    if (p != null) {
      setState(() {
        locality = p.locality;
      });
    }
  }

  getAndStoreLocationDetails() async {
    final prefs = await SharedPreferences.getInstance();
    Position pos = await getPosition();
    prefs.setDouble("latitude", pos.latitude);
    prefs.setDouble("longitude", pos.longitude);
    getLocation();
  }

  @override
  void initState() {
    super.initState();
    // getAndStoreLocationDetails();
    controller.getPropertyList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              "Property Stop",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              )
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.2,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.2 - 27,
                      decoration: const BoxDecoration(
                        color: constants.PRIMARY_COLOR,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 28),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Real Estate",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Made Simple",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Material(
                          borderRadius: BorderRadius.circular(8),
                          elevation: 5,
                          child: TextFormField(
                            onChanged:(text) {
                              setState(() {
                                  print(text);
                              });
                            },
                             controller: mobileNumberInput,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.search,
                                // color: constants.PRIMARY_COLOR,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(12),
                              hintText: "Search by location, area, pincode",
                              hintStyle: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "All Properties",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => Expanded(
                    child: (controller.isLoading.value)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                  child: GifView.asset(
                                    'assets/gifs/logo_red.gif',
                                    height: 50,
                                    width: 50,
                                    frameRate: 30, // default is 15 FPS
                                  ),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.propertyList.length,
                            itemBuilder: ((context, index) {
                              Datum  property;
                              if (controller.propertyList.value[index].projectName
                                  .toString()
                                  .toLowerCase()
                                  .contains(mobileNumberInput.value.text
                                  .toLowerCase())||controller.propertyList.value[index].propAddress
                                  .toString()
                                  .toLowerCase()
                                  .contains(mobileNumberInput.value.text
                                  .toLowerCase()) )
                                {
                                  print(controller.propertyList.value[index].projectName);
                                  property  = controller.propertyList[index];
                                  return BrokerPropertyListCard(
                                    property: property,
                                  );

                                }
                              else
                                {
                                  return Container();
                                }

                            }),
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
