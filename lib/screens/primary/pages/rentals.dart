import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:propertystop/utils/router.dart' as router;
// import 'package:propertystop/utils/constants.dart' as constants;

class RentalPage extends StatefulWidget {
  const RentalPage({Key? key}) : super(key: key);

  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Rentals",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.transparent,
                  width: 250,
                  height: 250,
                  child: SvgPicture.asset(
                    "assets/coming_soon.svg",
                    // color: Constants.TEXT_COLOR,
                    semanticsLabel: "coming soon",
                  ),
                ),
                const Text(
                  "Coming Soon",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
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
