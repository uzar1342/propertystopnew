import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:propertystop/services/network_service.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/custom_dialog.dart';
import 'package:propertystop/utils/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

import 'broker/broker_home.dart';

class LoginScreen extends StatefulWidget {

   LoginScreen({Key? key,required this.type}) : super(key: key);
   String type;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumberInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  bool _passwordVisible = false;

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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const SizedBox(
                      //   height: 28,
                      // ),
                      // const Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Text(
                      //     "Help ?",
                      //     style: TextStyle(
                      //       color: constants.PRIMARY_COLOR,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        child: Image.asset(
                          "assets/login.jpeg",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Enter your phone number to showcase of properties",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "It will be less than a minute",
                          textAlign: TextAlign.left,
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
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: mobileNumberInput,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textInputAction: TextInputAction.next,
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
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: passwordInput,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          obscureText: !_passwordVisible,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: constants.FIELD_COLOR,
                            contentPadding: const EdgeInsets.all(12),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: constants.PRIMARY_COLOR,
                                size: 18,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   padding: const EdgeInsets.only(top: 8),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       Navigator.of(context).pushNamed(router.forgotPass);
                      //     },
                      //     child: const Text(
                      //       "Forgot Password?",
                      //       textAlign: TextAlign.left,
                      //       style: TextStyle(
                      //         color: constants.PRIMARY_COLOR,
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.normal,
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
                            String mobileNumber =
                                mobileNumberInput.text.toString();
                            if (mobileNumber.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Please enter mobile number!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0,
                              );
                              return;
                            } else if (mobileNumber.length != 10) {
                              Fluttertoast.showToast(
                                msg: "Please enter valid mobile number!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0,
                              );
                              return;
                            } else if (passwordInput.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Please enter password!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0,
                              );
                              return;
                            }
                            context.loaderOverlay.show();

                            try {
                              final loginReq = await NetworkService().loginUser(
                                  mobileNumberInput.text, passwordInput.text,widget.type);
                              context.loaderOverlay.hide();

                              var result = json.decode(loginReq.toString());

                              if (result['success'] == "0") {
                                await Dialogs.infoDialog(
                                  result['message'],
                                );
                                return;
                              }

                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool(constants.isLoggedIn, true);
                              prefs.setString(constants.mobileNumber,
                                  mobileNumberInput.text);
                              prefs.setString(constants.userType,
                                  widget.type);

                              // Login Success
                              Fluttertoast.showToast(
                                msg: "Login Sucessfull",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0,
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const BrokerHomeScreen()),
                              );

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
                          },
                          child: const Text(
                            "Login",
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
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(router.registerPage);
                          },
                          child: const Text(
                            "New User ?",
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
