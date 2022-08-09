import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propertystop/screens/emi_calc.dart';
import 'package:propertystop/screens/loan_form.dart';
import 'package:propertystop/screens/my_site_visits.dart';
import 'package:propertystop/screens/profile.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/custom_dialog.dart';

class BrokerOthersPage extends StatefulWidget {
  const BrokerOthersPage({Key? key}) : super(key: key);

  @override
  State<BrokerOthersPage> createState() => _BrokerOthersPageState();
}

class OtherList {
  final String name, routeName;

  OtherList({
    required this.name,
    required this.routeName,
  });
}

class _BrokerOthersPageState extends State<BrokerOthersPage> {
  List<OtherList> items = [
    OtherList(name: "Edit Profile", routeName: router.profilePage),
    OtherList(name: "EMI Calculator", routeName: router.emiCalcPage),
    OtherList(name: "Loan Application", routeName: router.loanApplicationPage)
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: constants.FIELD_COLOR,
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Settings",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();

    final dialogAction = await Dialogs.yesNoAlertDialog(
    "Confirmation",
    "Are you sure you want to request for call back from our team?");
    if (dialogAction == DialogAction.yes) {
      prefs.clear();
      Navigator.pushNamedAndRemoveUntil(
        context,
        router.optionsPage,
            (route) => false,
      );
    }
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Features",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const EmiCalcScreen(),
                              transition: Transition.rightToLeft);
                        },
                        child: Row(
                          children: const [
                            Text(
                              "EMI Calculator",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const LoanApplicationScreen(),
                              transition: Transition.rightToLeft);
                          // Navigator.pushNamed(
                          //     context, router.loanApplicationPage);
                        },
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                "Loan Application",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Blogs",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 8),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Personalize",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Manage Notifications",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, router.profilePage);
                          Get.to(() => const ProfilePage(),
                              transition: Transition.rightToLeft);
                        },
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                "My Profile",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => MySiteVisits(),
                              transition: Transition.rightToLeft);
                        },
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                "My Site Visits",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Information & Support",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Terms & Conditions",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "About Us",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Propert Stop Version 1.0.0",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Feedback",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Contact Us",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Share the app",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
