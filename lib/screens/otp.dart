import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:propertystop/services/network_service.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/custom_dialog.dart';
import 'package:propertystop/utils/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String mobileNumber = "";

  TextEditingController otpInput1 = TextEditingController();
  TextEditingController otpInput2 = TextEditingController();
  TextEditingController otpInput3 = TextEditingController();
  TextEditingController otpInput4 = TextEditingController();
  TextEditingController otpInput5 = TextEditingController();
  TextEditingController otpInput6 = TextEditingController();

  init() async {
    final prefs = await SharedPreferences.getInstance();
    String? number = prefs.getString(constants.mobileNumber);
    if (number != null) {
      setState(() {
        mobileNumber = number;
      });
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const PageScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   color: Colors.transparent,
                      //   width: MediaQuery.of(context).size.height / 4,
                      //   height: MediaQuery.of(context).size.height / 4,
                      //   child: SvgPicture.asset(
                      //     "assets/otp_verification.svg",
                      //     // color: Constants.TEXT_COLOR,
                      //     semanticsLabel: "mobile login",
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "OTP Verification",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Enter the otp sent to +91 $mobileNumber for verification of your mobile number.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width * 0.18),
                              width: (MediaQuery.of(context).size.width * 0.18),
                              child: TextFormField(
                                controller: otpInput1,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  } else if (value.isEmpty) {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: constants.FIELD_COLOR,
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width * 0.18),
                              width: (MediaQuery.of(context).size.width * 0.18),
                              child: TextFormField(
                                controller: otpInput2,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  } else if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: constants.FIELD_COLOR,
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width * 0.18),
                              width: (MediaQuery.of(context).size.width * 0.18),
                              child: TextFormField(
                                controller: otpInput3,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  } else if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: constants.FIELD_COLOR,
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width * 0.18),
                              width: (MediaQuery.of(context).size.width * 0.18),
                              child: TextFormField(
                                controller: otpInput4,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  } else if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: constants.FIELD_COLOR,
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width * 0.18),
                              width: (MediaQuery.of(context).size.width * 0.18),
                              child: TextFormField(
                                controller: otpInput5,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  } else if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: constants.FIELD_COLOR,
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width * 0.18),
                              width: (MediaQuery.of(context).size.width * 0.18),
                              child: TextFormField(
                                controller: otpInput6,
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).unfocus();
                                  } else if (value.isEmpty) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                },
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: constants.FIELD_COLOR,
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (otpInput1.text.isEmpty ||
                                otpInput2.text.isEmpty ||
                                otpInput3.text.isEmpty ||
                                otpInput4.text.isEmpty ||
                                otpInput5.text.isEmpty ||
                                otpInput6.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Please enter otp!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0,
                              );
                              return;
                            }
                            // print("OTP Code is : ${}");
                            context.loaderOverlay.show();

                            String finalOtp =
                                "${otpInput1.text}${otpInput2.text}${otpInput3.text}${otpInput4.text}${otpInput5.text}${otpInput6.text}";

                            try {
                              var verifyOtpReq = await NetworkService()
                                  .verifyOtp(finalOtp, mobileNumber);
                              context.loaderOverlay.hide();

                              var result = json.decode(verifyOtpReq!);

                              if (result['success'] == "0") {
                                await Dialogs.infoDialog(
                                  result['message'],
                                );
                                return;
                              }

                              // Registration Success
                              Fluttertoast.showToast(
                                msg: "Successfully Verified!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0,
                              );
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool(constants.isLoggedIn, true);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  router.brokerMain, (route) => false);
                            } catch (e) {
                              // ignore: avoid_print
                              context.loaderOverlay.hide();
                              print(e);
                              await Dialogs.infoDialog(
                                "Something went wrong, please try again later.",
                              );
                              return;
                            }
                            // final prefs = await SharedPreferences.getInstance();
                            // prefs.setBool(constants.isLoggedIn, true);
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     router.brokerMain, (route) => false);
                          },
                          child: const Text(
                            "Verify",
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
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            var result = await NetworkService().resendOtp();
                            if (json.decode(result.toString())["success"] ==
                                "1") {
                              Fluttertoast.showToast(
                                msg: "OTP sent!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Something went wrong!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0,
                              );
                            }
                          },
                          child: const Text(
                            "Didn't Receive OTP ?",
                            style: TextStyle(
                              color: constants.PRIMARY_COLOR,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: constants.PRIMARY_COLOR, width: 1),
                            padding: const EdgeInsets.all(12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
