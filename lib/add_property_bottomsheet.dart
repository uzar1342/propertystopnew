import 'dart:convert';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:propertystop/services/network_service.dart';
import 'package:propertystop/utils/custom_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/request/add_property_request.dart';

class Addpropertylist extends StatefulWidget {
  const Addpropertylist({Key? key}) : super(key: key);

  @override
  State<Addpropertylist> createState() => _AddpropertylistState();
}

class _AddpropertylistState extends State<Addpropertylist> {
  String? room;
  String? resel;
  TextEditingController project_name = TextEditingController();
  TextEditingController prop_about = TextEditingController();
  TextEditingController build_floors = TextEditingController();
  TextEditingController prop_carpet_area = TextEditingController();
  TextEditingController prop_price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "I have a resale property",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              controller: project_name,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: constants.FIELD_COLOR,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: "Project Name",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity - 50,
                              child: DropdownButtonFormField<String>(
                                isExpanded: false,
                                items: [
                                  buildMenuItem("1 BHK"),
                                  buildMenuItem("2 BHK"),
                                  buildMenuItem("2.5 BHK"),
                                  buildMenuItem("3 BHK"),
                                  buildMenuItem("3.5 BHK"),
                                  buildMenuItem("4 BHK"),
                                  buildMenuItem("5 BHK"),
                                  buildMenuItem("6 BHK"),
                                  buildMenuItem("7 BHK"),
                                  buildMenuItem("8 BHK")
                                ],
                                onChanged: (value) => setState(() {
                                  room = value;
                                }),
                                value: room,
                                hint: const Text(
                                  "Select Room",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(12),
                                  filled: true,
                                  fillColor: constants.FIELD_COLOR,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: "Room",
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity - 50,
                              child: DropdownButtonFormField<String>(
                                isExpanded: false,
                                items: [
                                  buildMenuItem("RESAL PROPERTY"),
                                  buildMenuItem("RESALE CLINT"),
                                ],
                                onChanged: (value) => setState(() {
                                  resel = value;
                                }),
                                value: resel,
                                hint: const Text(
                                  "Select Resale Type",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(12),
                                  filled: true,
                                  fillColor: constants.FIELD_COLOR,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: "Room",
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: prop_price,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: constants.FIELD_COLOR,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: "Price",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: prop_carpet_area,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: constants.FIELD_COLOR,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: "Carpet Area",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: build_floors,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: constants.FIELD_COLOR,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: "Floors",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: prop_about,
                              maxLines: 5,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                filled: true,
                                fillColor: constants.FIELD_COLOR,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: "About",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            margin: const EdgeInsets.symmetric(vertical: 25),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                var type="";
                                final prefs = await SharedPreferences.getInstance();
                                String? mobile = prefs.getString(constants.mobileNumber);
                                if (prop_price.value.text != "" &&
                                    build_floors.value.text != "" &&
                                    project_name.value.text != "" &&
                                    room != null &&
                                    resel != null &&
                                    prop_about.value.text != "" &&
                                    prop_carpet_area.value.text != "") {
                                  context.loaderOverlay.show();

                                  if(resel=="RESAL PROPERTY")
                                    {
                                      type="resale_property";
                                    }
                                  else
                                    {
                                      type="resale_client";
                                    }

                                  var result = await NetworkService()
                                      .addPropertyResale(AddPropertyRequest(
                                          addAppResalePropClient:
                                              "addAppResalePropClient",
                                          mobileNumber: mobile.toString(),
                                          propertyType: type.toString(),
                                          projectName: project_name.value.text,
                                          propAbout: prop_about.value.text,
                                          buildFloors: build_floors.value.text,
                                          propRooms: room.toString(),
                                          propCarpetArea: prop_carpet_area.value.text,
                                          propPrice: prop_price.value.text));
                                  context.loaderOverlay.hide();

                                  if (json.decode(result!)['success'] == "0") {
                                    await Dialogs.infoDialog(
                                      json.decode(result)['message'],
                                    );
                                    return;
                                  } else {
                                    Navigator.of(context).pop();
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Sucess'),
                                        content: Text(json.decode(result)['message']),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    return;
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Enter All Details",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                              child: const Text(
                                "Save Details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: constants.PRIMARY_COLOR,
                                padding: const EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
