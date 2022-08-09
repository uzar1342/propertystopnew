import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:gif_view/gif_view.dart';
import 'package:http/http.dart' as http;
import 'package:propertystop/screens/broker/components/property_card.dart';
import 'package:propertystop/utils/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/response/propery_list_response.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/screens/request_callback_bottomsheet.dart';
import 'package:propertystop/utils/custom_dialog.dart';

import 'models/response/propery_list_response.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late ScrollController controller;
 String page="";
  String? locality;
  TextEditingController mobileNumberInput = TextEditingController();
 late int paglen;
 int pagechck=1;
  List<Datum?> _posts = [];
  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }
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

  Future < PropertyListResponse ? > _firstLoad() async {

    try {
      var url = Uri.parse('${constants.baseUrl}/paginate-data');

      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({
        'page': page
      });

      var streamedResponse =
      await request.send().timeout(const Duration(seconds: 20));

      var response = await http.Response.fromStream(streamedResponse);

      debugPrint(url.toString());
      //  debugPrint("getPropertyList\n" + response.statusCode.toString());
      //  debugPrint("getPropertyList\n" + response.body);

      if (response.statusCode == 200) {
        {

          //   setState(() {
          //   _posts = json.decode(response.body);
          // });
         var a=json.decode(response.body);
         List n=a["page_array"];
          paglen=int.parse(n.length.toString());
         // paglen=response.body[]
         print(paglen);
          return (propertyListResponseFromJson(response.body));
        }
        //(propertyListResponseFromJson(response.body));
      } else {
        Get.snackbar('Something went wrong,Please try again later',
            'Error #1 ${response.statusCode}',
            backgroundColor: Colors.white,
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }


  }


  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
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
             Expanded(
                child:  FutureBuilder < PropertyListResponse ? > (
                  future: _firstLoad(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasError)
                          return Text(snapshot.error.toString());
                        else {


                          var result = snapshot.data;
                          result?.data.forEach((element) { _posts.add(element);});
                          print(result?.data[0].projectName);

                          return(result!=null)?
                            // Container();
                            ListView.builder(
                              controller: controller,
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              physics: const BouncingScrollPhysics(),
                              itemCount: _posts.length,
                              itemBuilder: ((context, index)
                              {
                                if (_posts[index]!.projectName
                                    .toString()
                                    .toLowerCase()
                                    .contains(mobileNumberInput.value.text
                                    .toLowerCase())||_posts[index]!.propAddress
                                    .toString()
                                    .toLowerCase()
                                    .contains(mobileNumberInput.value.text
                                    .toLowerCase()) )
                                return BrokerPropertyListCard(property: _posts[index]!,);
                                return Container();

                              }),
                            ):Column(
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
                          );
                        }

                      default:
                        return Text('Unhandle State');
                    }
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );


  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.atEdge) {
      if(pagechck<paglen)
        {
          pagechck=pagechck+1;
          setState(() {
            page=pagechck.toString();
          });
        }

      print("object");

    }
  }
}
