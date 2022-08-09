import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String pageName = router.introPage;

  startTime() async {
    final prefs = await SharedPreferences.getInstance();

    bool? isLoggedIn = prefs.getBool(constants.isLoggedIn);
    String? intro = prefs.getString(constants.isIntro);

    if (isLoggedIn != null) {
      setState(() {
        pageName = isLoggedIn ? router.brokerMain : router.introPage;
      });
    } else {
      setState(() {
        pageName = intro!="1"?router.introPage:router.optionsPage;
      });
    }

    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  navigationPage() {
    Navigator.of(context).pushReplacementNamed(pageName);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFEF3238),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GifView.asset(
                'assets/gifs/logo_red.gif',
                height: 200,
                width: 200,
                frameRate: 30, // default is 15 FPS
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Property",
                      style: TextStyle(
                        color: constants.PRIMARY_COLOR,
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Stop",
                      style: TextStyle(
                        color: constants.PRIMARY_COLOR,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -20,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/splashscreenimage.png",
              height: 200.0,
              width: MediaQuery.of(context).size.width - 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
