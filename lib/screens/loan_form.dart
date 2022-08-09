import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:propertystop/utils/constants.dart' as constants;

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({Key? key}) : super(key: key);

  @override
  State<LoanApplicationScreen> createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  final employmentTypes = ["", ""];
  String? employmentType;
  bool isloading = true;
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  TextEditingController fullNameInput = TextEditingController();
  TextEditingController emailAddressInput = TextEditingController();
  TextEditingController mobileNumberInput = TextEditingController();
  TextEditingController loanUptoInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(employmentType);
    print("Parth");
    var h = MediaQuery.of(context).size.height;
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
                "Home Loan Application",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      "assets/homeloan.jpg",
                    ),
                  ),
                 Padding(
                   padding: EdgeInsets.all(8),
                   child: Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 10),
                         child: SizedBox(
                           width: double.infinity,
                           child: TextFormField(
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
                       ),
                       const SizedBox(
                         height: 15,
                       ),
                       SizedBox(
                         width: double.infinity,
                         child: TextFormField(
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
                       SizedBox(
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
                         width: double.infinity - 50,
                         child: DropdownButtonFormField<String>(
                           key: _key,
                           isExpanded: false,
                           items: [buildMenuItem("Self Employed"),
                             buildMenuItem("Salaried"),],
                           onChanged: (value) => setState(() {
                             employmentType = value;
                           }),
                           value: employmentType,
                           hint: const Text(
                             "Select Employment Type",
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
                           controller: loanUptoInput,
                           style: const TextStyle(fontSize: 16),
                           keyboardType: TextInputType.number,
                           textInputAction: TextInputAction.done,
                           inputFormatters: [
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
                             hintText: "Loan Upto",
                             hintStyle: const TextStyle(
                               fontSize: 16,
                             ),
                           ),
                         ),
                       ),
                       const SizedBox(
                         height: 25,
                       ),
                       SizedBox(
                         width: double.infinity,
                         child: ElevatedButton(
                           onPressed: () {
                             if (fullNameInput.value.text != "" &&
                                 mobileNumberInput.text != "" &&
                                 emailAddressInput.value.text != "" &&
                                 employmentType != null &&
                                 loanUptoInput.value.text != "") {
                               String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                               RegExp regExp = new RegExp(pattern);
                               if (regExp.hasMatch(mobileNumberInput.text)) {
                                 String pattern =
                                     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                 RegExp regExp = new RegExp(pattern);
                                 if (regExp.hasMatch(emailAddressInput.text)) {
                                   context.loaderOverlay.show();
                                   validation();
                                 } else {
                                   Fluttertoast.showToast(
                                       msg: "Enter Valid Email",
                                       toastLength: Toast.LENGTH_SHORT,
                                       gravity: ToastGravity.CENTER,
                                       timeInSecForIosWeb: 1,
                                       backgroundColor: Colors.red,
                                       textColor: Colors.white,
                                       fontSize: 16.0);
                                 }
                               } else {
                                 Fluttertoast.showToast(
                                     msg: "Enter Valid Phone Number",
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.CENTER,
                                     timeInSecForIosWeb: 1,
                                     backgroundColor: Colors.red,
                                     textColor: Colors.white,
                                     fontSize: 16.0);
                               }
                             } else {
                               Fluttertoast.showToast(
                                   msg: "Please fill all the details",
                                   toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.BOTTOM,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0);
                             }
                           },
                           child: const Text(
                             "Submit Application",
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
                 )
                ],
              ),
            )),
      ),
    );
  }

  validation() async {
    try {
      var url = Uri.parse('${constants.baseUrl}/homeLoan-enquiry');
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({
        "btn_homeLoan": "btn_homeLoan",
        "field": "",
        "loan_name": fullNameInput.value.text,
        "loan_contact_no": mobileNumberInput.text,
        "loan_email": emailAddressInput.value.text,
        "loan_employment": employmentType ?? "",
        "loan_amount": loanUptoInput.value.text,
      });
      print(request.fields);
      var streamedResponse =
          await request.send().timeout(const Duration(seconds: 20));

      var response = await http.Response.fromStream(streamedResponse);

      debugPrint(url.toString());
      debugPrint("getPropertyList\n" + response.statusCode.toString());
      debugPrint("getPropertyList\n" + response.body);
      var jason = jsonDecode(response.body);
      if (response.statusCode == 200) {
        context.loaderOverlay.hide();
        if (jason["success"] == "1") {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Sucess'),
              content: Text(jason["message"].toString()),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          fullNameInput.clear();
          mobileNumberInput.clear();
          emailAddressInput.clear();
          loanUptoInput.clear();
          _key.currentState?.reset();
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Error'),
              content: Text(jason["message"].toString()),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        context.loaderOverlay.hide();
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Sucess'),
            content: Text(jason["message"].toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return null;
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
