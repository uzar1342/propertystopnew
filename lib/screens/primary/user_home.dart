import 'package:flutter/material.dart';
import 'package:propertystop/screens/primary/pages/loan.dart';
import 'package:propertystop/screens/primary/pages/others_page.dart';
import 'package:propertystop/screens/primary/pages/property_list.dart';
import 'package:propertystop/screens/primary/pages/rentals.dart';
import 'package:propertystop/screens/primary/pages/resale.dart';
import 'package:propertystop/utils/constants.dart' as constants;

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    const BrokerPropertyListPage(),
    const ResalePage(),
    const RentalPage(),
    const LoanApplicationPage(),
    const BrokerOthersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              label: 'New Flat',
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
                child: Icon(Icons.house_outlined),
              ),
              label: 'Rentals',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.request_page_outlined),
              ),
              label: 'Loan',
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
    );
  }
}
