// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:propertystop/controllers/register_viewmodel.dart';
import 'package:propertystop/models/request/register_user_request.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/custom_dialog.dart';
import 'package:propertystop/utils/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final userTypes = ["Broker", "Customer"];
  String? userType;
  TextEditingController mobileNumberInput = TextEditingController();
  TextEditingController fullNameInput = TextEditingController();
  TextEditingController firmNameInput = TextEditingController();
  TextEditingController locationInput = TextEditingController();
  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  bool _passwordVisible = false;

  final controller = RegisterViewModel();

  @override
  void initState() {
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
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const PageScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "New on Property Stop ?",
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
                          "Register with us in few steps",
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
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Text(
                          "Your mobile number",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                        height: 25,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(bottom: 12),
                        child: const Text(
                          "Your details",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: fullNameInput,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                          controller: emailInput,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                          controller: passwordInput,
                          style: const TextStyle(fontSize: 16),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          obscureText: !_passwordVisible,
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
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity - 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: false,
                          items: userTypes.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                            userType = value;
                          }),
                          value: userType,
                          hint: const Text(
                            "Select User Type",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: constants.FIELD_COLOR,
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: firmNameInput,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                            hintText: "Firm Name",
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
                          controller: locationInput,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                            hintText: "Location Name",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: TextFormField(
                      //     style: const TextStyle(fontSize: 16),
                      //     keyboardType: TextInputType.number,
                      //     textInputAction: TextInputAction.done,
                      //     inputFormatters: [
                      //       LengthLimitingTextInputFormatter(6),
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
                      //       hintText: "Pincode",
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
                            // Validation
                            String fullName = fullNameInput.text.toString();
                            String mobileNumber =
                                mobileNumberInput.text.toString();
                            String email = emailInput.text.toString();
                            String pass = passwordInput.text.toString();
                            String firmName = firmNameInput.text.toString();
                            String location = locationInput.text.toString();

                            if (fullName.isEmpty ||
                                mobileNumber.isEmpty ||
                                email.isEmpty ||
                                pass.isEmpty ||
                                firmName.isEmpty ||
                                location.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Please enter all the details!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0,
                              );
                              return;
                            }

                            context.loaderOverlay.show();
                            try {
                              await controller.registerUser(RegisterUserRequest(
                                  btnRegister: "btnRegister",
                                  field: "",
                                  fullName: fullName,
                                  contactNumber: mobileNumber,
                                  email: email,
                                  userPassword: pass,
                                  userType: userType.toString(),
                                  device: "Mobile",
                                  firmName: firmName,
                                  location: location));
                              context.loaderOverlay.hide();
                              if (!controller.isNewUser.value) {
                                await Dialogs.infoDialog(
                                  controller.message.value,
                                );
                                return;
                              }
                              // Registration Success
                              else {
                                Fluttertoast.showToast(
                                  msg: "Successfully Registered!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0,
                                );
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(
                                    constants.mobileNumber, mobileNumber);
                                prefs.setString(
                                    constants.userType, userType.toString());
                                Navigator.of(context).pushNamed(router.otpPage);
                              }
                            } catch (e) {
                              // ignore: avoid_print
                              print(e);
                              await Dialogs.infoDialog(
                                "Something went wrong, please try again later.",
                              );
                              return;
                            }
                          },
                          child: const Text(
                            "Register",
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
                      // Container(
                      //   alignment: Alignment.center,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       const Text(
                      //         "Already have an account ?",
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.normal,
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 2,
                      //       ),
                      //       TextButton(
                      //         onPressed: () => Navigator.of(context)
                      //             .pushReplacementNamed(router.loginPage),
                      //         style: TextButton.styleFrom(
                      //           splashFactory: NoSplash.splashFactory,
                      //         ),
                      //         child: const Text(
                      //           "Login",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //             color: constants.PRIMARY_COLOR,
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.normal,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
