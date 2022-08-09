import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:propertystop/models/response/user_profile_response.dart';
import 'package:propertystop/services/network_service.dart';
import 'package:propertystop/utils/constants.dart' as constants;

import '../utils/custom_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullNameInput = TextEditingController();
  TextEditingController emailAddressInput = TextEditingController();
  TextEditingController mobileNumberInput = TextEditingController();
  // TextEditingController locationInput = TextEditingController();

  fetchProfile() async {
    try {
      context.loaderOverlay.show();
      final profileReq = await NetworkService().getUserProfile();
      context.loaderOverlay.hide();
      var result = userProfileResponseFromJson(profileReq!);

      if (result.success == "0") {
        await Dialogs.infoDialog(json.decode(profileReq)["message"]);
        return;
      }

      fullNameInput.text = result.data.fullName;
      emailAddressInput.text = result.data.email;
      mobileNumberInput.text = result.data.contactNumber;
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

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              readOnly: true,
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
                                hintText: "Full Name",
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              readOnly: true,
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
                                hintText: "Email Address",
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              readOnly: true,
                              controller: mobileNumberInput,
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
                                hintText: "Mobile Number",
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //     onPressed: () {},
                          //     child: const Text(
                          //       "Update Password",
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 15,
                          //       ),
                          //     ),
                          //     style: ElevatedButton.styleFrom(
                          //       primary: constants.PRIMARY_COLOR,
                          //       padding: const EdgeInsets.all(12),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(8),
                          //         side: BorderSide.none,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
