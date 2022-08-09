import 'package:flutter/material.dart';
import 'package:propertystop/screens/broker/broker_home.dart';
import 'package:propertystop/screens/broker/resale_client.dart';
import 'package:propertystop/screens/broker/resale_property.dart';
import 'package:propertystop/screens/emi_calc.dart';
import 'package:propertystop/screens/forgot.dart';
import 'package:propertystop/screens/loan_form.dart';
import 'package:propertystop/screens/main_nav.dart';
import 'package:propertystop/screens/intro.dart';
import 'package:propertystop/screens/login.dart';
import 'package:propertystop/screens/options.dart';
import 'package:propertystop/screens/otp.dart';
import 'package:propertystop/screens/primary/user_home.dart';
import 'package:propertystop/screens/profile.dart';
import 'package:propertystop/screens/register.dart';
import 'package:propertystop/screens/request_visit.dart';
import 'package:propertystop/screens/splash.dart';

import '../add_property_bottomsheet.dart';

// Define Routes

// Route Names
const String splashPage = 'splash';
const String introPage = 'intro';
const String loginPage = 'login';
const String otpPage = 'otp';
const String optionsPage = 'options';
const String registerPage = 'register';
const String mainNav = 'main';
const String brokerMain = 'broker';
const String userMain = 'user';
const String primaryMain = 'primary';
const String emiCalcPage = 'emi';
const String loanApplicationPage = 'loan';
const String profilePage = "profile";
const String requestVisit = "requestVisit";
const String forgotPass = "forgotPass";
const String resaleProperty = "resaleProperty";
const String resaleClient = "resaleClient";
const String Addproperty = "Addproperty";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case splashPage:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case introPage:
      return MaterialPageRoute(builder: (context) => const IntroScreen());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case otpPage:
      return MaterialPageRoute(builder: (context) => const OtpScreen());
    case optionsPage:
      return MaterialPageRoute(builder: (context) => const OptionsScreen());
    case registerPage:
      return MaterialPageRoute(builder: (context) => const RegisterScreen());
    case mainNav:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case brokerMain:
      return MaterialPageRoute(builder: (context) => const BrokerHomeScreen());
    case userMain:
      return MaterialPageRoute(builder: (context) => const UserHomeScreen());
    case emiCalcPage:
      return MaterialPageRoute(builder: (context) => const EmiCalcScreen());
    case profilePage:
      return MaterialPageRoute(builder: (context) => const ProfilePage());
    case Addproperty:
      return MaterialPageRoute(builder: (context) => const Addpropertylist());

    case loanApplicationPage:
      return MaterialPageRoute(
          builder: (context) => const LoanApplicationScreen());
    case requestVisit:
      return MaterialPageRoute(builder: (context) => const RequestVisitForm());
    case forgotPass:
      return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen());
    case resaleProperty:
      return MaterialPageRoute(
          builder: (context) => const ResalePropertyPage());
    case resaleClient:
      return MaterialPageRoute(builder: (context) => const ResaleClientPage());
    default:
      throw ('This route name does not exist');
  }
}
