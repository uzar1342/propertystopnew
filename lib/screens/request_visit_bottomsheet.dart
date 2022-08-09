import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/custom_dialog.dart';

class RequestVisitBottomSheet extends StatefulWidget {
  const RequestVisitBottomSheet({Key? key, required this.propertyId})
      : super(key: key);

  final String propertyId;

  @override
  State<RequestVisitBottomSheet> createState() =>
      _RequestVisitBottomSheetState();
}

class _RequestVisitBottomSheetState extends State<RequestVisitBottomSheet> {
  DateTime dateTime = DateTime.now();

  Dio dio = Dio();

  TextEditingController fullNameInput = TextEditingController();
  TextEditingController emailAddressInput = TextEditingController();
  TextEditingController mobileNumberInput = TextEditingController();
  bool timeSelected = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final hours = dateTime.hour.toString().padLeft(2, '0');
    // final minutes = dateTime.minute.toString().padLeft(2, '0');

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    // color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Full Name",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                width: double.infinity,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter valid name';
                                    }
                                    return null;
                                  },
                                  controller: fullNameInput,
                                  style: const TextStyle(fontSize: 16),
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: constants.FIELD_COLOR,
                                    contentPadding: const EdgeInsets.all(12),
                                    hintText: "Jhon Doe",
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Mobile Number",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                width: double.infinity,
                                child: TextFormField(
                                  controller: mobileNumberInput,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length != 10) {
                                      return 'Please enter valid Mobile number';
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(fontSize: 16),
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: constants.FIELD_COLOR,
                                    contentPadding: const EdgeInsets.all(12),
                                    hintText: "1234567890",
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Email Address",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                width: double.infinity,
                                child: TextFormField(
                                  controller: emailAddressInput,
                                  style: const TextStyle(fontSize: 16),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: constants.FIELD_COLOR,
                                    contentPadding: const EdgeInsets.all(12),
                                    hintText: "some@example.com",
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Preferred Date/Time",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final date = await pickDate();
                                  if (date == null) return;

                                  final time = await pickTime();
                                  if (time == null) return;

                                  final newDateTime = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute,
                                  );

                                  setState(() {
                                    dateTime = newDateTime;
                                  });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: TextEditingController(
                                        text: DateFormat("yyyy/MM/dd  hh:mm a")
                                            .format(dateTime)
                                            .toString()),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter valid date and time';
                                      }
                                      return null;
                                    },
                                    enabled: false,
                                    style: const TextStyle(fontSize: 16),
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: constants.FIELD_COLOR,
                                      contentPadding: const EdgeInsets.all(12),
                                      hintText:
                                          DateFormat("yyyy/MM/dd  hh:mm a")
                                              .format(dateTime)
                                              .toString(),
                                      // "${dateTime.year} / ${dateTime.month} / ${dateTime.day} , $hours:$minutes ${dateTime.}",
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: TextFormField(
                          //     style: const TextStyle(fontSize: 16),
                          //     keyboardType: TextInputType.number,
                          //     textInputAction: TextInputAction.done,
                          //     inputFormatters: [
                          //       FilteringTextInputFormatter.digitsOnly,
                          //     ],
                          //     decoration: InputDecoration(
                          //       border: OutlineInputBorder(
                          //         borderSide: BorderSide.none,
                          //         borderRadius: BorderRadius.circular(8),
                          //       ),
                          //       filled: true,
                          //       fillColor: constants.FIELD_COLOR,
                          //       contentPadding: const EdgeInsets.all(12),
                          //       hintText: "Loan Upto",
                          //       hintStyle: const TextStyle(
                          //         fontSize: 16,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  String? loggedInMobile =
                                      prefs.getString(constants.mobileNumber);
                                  var request = http.MultipartRequest(
                                      'POST',
                                      Uri.parse(
                                          'https://propertystop.com/site-visit'));
                                  request.fields.addAll({
                                    'btn_siteVisit': 'btn_siteVisit',
                                    'field': '',
                                    'site_name': fullNameInput.text,
                                    'site_contact_no': mobileNumberInput.text,
                                    'site_email': emailAddressInput.text,
                                    'site_date': DateFormat("dd-MM-yyyy")
                                        .format(dateTime)
                                        .toString(),
                                    'site_time': DateFormat("h:mm:ss")
                                        .format(dateTime)
                                        .toString(),
                                    'prop_id': widget.propertyId,
                                    'device': "Mobile",
                                    'mobile_number': loggedInMobile.toString()
                                  });

                                  print(request.fields);

                                  try {
                                    http.StreamedResponse streamedResponse =
                                        await request.send();

                                    final profileReq =
                                        await http.Response.fromStream(
                                            streamedResponse);
                                    context.loaderOverlay.hide();

                                    print(json.encode(profileReq.body));
                                    print(profileReq.statusCode);

                                    if (profileReq.statusCode == 200) {
                                      if (json.decode(
                                              profileReq.body)['success'] ==
                                          "0") {
                                        await Dialogs.infoDialog(
                                          json.decode(
                                              profileReq.body)['message'],
                                        );
                                        return;
                                      } else {
                                        Navigator.of(context).pop();
                                        Fluttertoast.showToast(
                                          msg:
                                              "Request Submitted Successfully!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0,
                                        );
                                        return;
                                      }
                                    }
                                  } catch (e) {
                                    // ignore: avoid_print
                                    print(e);
                                    context.loaderOverlay.hide();
                                    Fluttertoast.showToast(
                                      msg: "Something went wrong!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0,
                                    );
                                    return;
                                  }
                                }
                              },
                              child: const Text(
                                "Submit",
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: dateTime,
        lastDate: dateTime.add(
          const Duration(days: 30),
        ),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
