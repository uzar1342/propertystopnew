import 'package:flutter/material.dart';
import 'package:propertystop/screens/home.dart';
import 'package:propertystop/screens/notifications.dart';
import 'package:propertystop/screens/profile.dart';
import 'package:propertystop/screens/saved.dart';
import 'package:propertystop/utils/constants.dart' as constants;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    const HomePage(),
    const SavedPage(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 26,
        currentIndex: _selectedIndex,
        selectedItemColor: constants.PRIMARY_COLOR,
        unselectedItemColor: Colors.black,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: _children[_selectedIndex],
    );
  }
}
