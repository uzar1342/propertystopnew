// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// Colors
const Color PRIMARY_COLOR = Color(0xFFED1C24);
const Color FIELD_COLOR = Color(0xFFEFEFEF);
// const Color TEXT_COLOR = Color(0xFFefefef);

// Assets
const String logo = "assets/logo.png";

// API's
const String login = "";

// Shared Preference Keys
const String isLoggedIn = "isLoggedIn";
const String isIntro = "isIntro";
const String mobileNumber = "mobileNumber";
const String userType = "userType";
const String selectedOption = "selectedOption";
const String baseUrl = "https://propertystop.com";

// Notification Channel
const String notificationChannel = "property_stop_notification";

// Get Material Color
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
