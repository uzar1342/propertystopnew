import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:propertystop/screens/broker/pages/my_properties.dart';
import 'package:propertystop/screens/broker/pages/others_page.dart';
import 'package:propertystop/screens/broker/pages/property_list.dart';
import 'package:propertystop/screens/broker/pages/rentals.dart';
import 'package:propertystop/screens/broker/pages/resale.dart';
import 'package:propertystop/screens/realestate_webview.dart';
import 'package:propertystop/utils/constants.dart' as constants;

import '../../pagination.dart';
import '../../utils/custom_dialog.dart';

class BrokerHomeScreen extends StatefulWidget {
  const BrokerHomeScreen({Key? key}) : super(key: key);

  @override
  State<BrokerHomeScreen> createState() => _BrokerHomeScreenState();
}

class _BrokerHomeScreenState extends State<BrokerHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    //const BrokerPropertyListPage(),
      Pagination(),
    const ResalePage(),
    // const BrokerClientsPage(),
    const RealEstateWebView(
      pageUrl: 'https://propertystop.com',
      title: 'Blogs',
    ),
    const RentalPage(),
    const BrokerOthersPage(),
  ];

  Future<bool> _onWillPop() async {
    final dialogAction = await Dialogs.yesNoAlertDialog(
        "Confirmation", "Are you sure you want to exit the app");
    if (dialogAction == DialogAction.yes) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 5.0,
                spreadRadius: 3,
                offset: Offset.zero,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            enableFeedback: true,
            elevation: 15,
            backgroundColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            iconSize: 26,
            currentIndex: _selectedIndex,
            selectedItemColor: constants.PRIMARY_COLOR,
            selectedLabelStyle:
                const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            unselectedItemColor: Colors.black,
            unselectedLabelStyle:
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            onTap: (index) => setState(() => _selectedIndex = index),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.maps_home_work_outlined),
                ),
                label: 'Project',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.real_estate_agent_outlined),
                ),
                label: 'Resale',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.book_outlined),
                ),
                label: 'Blogs',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.house_outlined),
                ),
                label: 'Rentals',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.settings_outlined),
                ),
                label: 'Accounts',
              ),
            ],
          ),
        ),
        body: _children[_selectedIndex],
      ),
    );
  }
}
