import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  TextEditingController mobileNumberInput = TextEditingController();

  String? selectedOption;

setintro()
async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(
      constants.isIntro,"1");
}

  changeSelectedOption(String s) {
    setState(() {
      selectedOption = s;
    });
  }
@override
  initState()  {
  setintro();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Choose Option",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                  child: Text(
                    "Select your type",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 12,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            changeSelectedOption("broker");
                          },
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: SvgPicture.asset(
                                      "assets/broker.svg",
                                      // color: Constants.TEXT_COLOR,
                                      semanticsLabel: "broker",
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      "Broker",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              selectedOption != null &&
                                  selectedOption == "broker"
                                  ? Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: constants.PRIMARY_COLOR),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 12,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            changeSelectedOption("buy_sell");
                          },
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: SvgPicture.asset(
                                      "assets/buy_sell.svg",
                                      // color: Constants.TEXT_COLOR,
                                      semanticsLabel: "buy_sell",
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      "Buy / Sell (Resale)",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              selectedOption != null &&
                                  selectedOption == "buy_sell"
                                  ? Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: constants.PRIMARY_COLOR),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 12,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            changeSelectedOption("emi_calculator");
                          },
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: SvgPicture.asset(
                                      "assets/emi_calculator.svg",
                                      // color: Constants.TEXT_COLOR,
                                      semanticsLabel: "emi_calculator",
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      "Emi Calculator",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              selectedOption != null &&
                                  selectedOption == "emi_calculator"
                                  ? Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: constants.PRIMARY_COLOR),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 12,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            changeSelectedOption("loan_application");
                          },
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: SvgPicture.asset(
                                      "assets/loan_application.svg",
                                      // color: Constants.TEXT_COLOR,
                                      semanticsLabel: "loan_application",
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      "Loan Application",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              selectedOption != null &&
                                  selectedOption == "loan_application"
                                  ? Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: constants.PRIMARY_COLOR),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 12,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            changeSelectedOption("primary_new");
                          },
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: SvgPicture.asset(
                                      "assets/primary_new.svg",
                                      // color: Constants.TEXT_COLOR,
                                      semanticsLabel: "primary_new",
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      "Primary (New Property)",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              selectedOption != null &&
                                  selectedOption == "primary_new"
                                  ? Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: constants.PRIMARY_COLOR),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedOption == null) {
                        Fluttertoast.showToast(
                          msg: "Please select any one option!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          fontSize: 16.0,
                        );
                        return;
                      } else if (selectedOption == "broker") {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            constants.selectedOption, selectedOption!);
                        Navigator.of(context).pushNamed(router.loginPage);
                        return;
                      } else if (selectedOption == "buy_sell") {
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     router.brokerMain, (route) => false);
                        return;
                      } else if (selectedOption == "emi_calculator") {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            router.emiCalcPage, (route) => false);
                        return;
                      } else if (selectedOption == "loan_application") {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            router.loanApplicationPage, (route) => false);
                        return;
                      } else if (selectedOption == "primary_new") {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            constants.selectedOption, selectedOption!);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            router.userMain, (route) => false);
                        return;
                      }
                    },
                    child: const Text(
                      "Continue",
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
    );
  }
}
