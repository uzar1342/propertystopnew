import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/router.dart' as router;

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final pageViewController = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  // IntroPages
  Widget buildPage({
    required String image,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.transparent,
            width: 300,
            height: 300,
            child: SvgPicture.asset(
              image,
              // color: Constants.TEXT_COLOR,
              semanticsLabel: title,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: TextButton(
      //         style: TextButton.styleFrom(
      //           splashFactory: NoSplash.splashFactory,
      //         ),
      //         onPressed: () {},
      //         child: const Text(
      //           "Skip",
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontSize: 16,
      //             fontWeight: FontWeight.normal,
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 100),
        child: PageView(
          controller: pageViewController,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          children: [
            buildPage(
              image: "assets/intro1.svg",
              title: "INVESTATION",
              desc:
                  "Save future life by investing in property. Trusted easy and profit your self.",
            ),
            buildPage(
              image: "assets/intro2.svg",
              title: "MARKETPLACE",
              desc:
                  "Browse and select the best property among different options that suits your needs.",
            ),
            buildPage(
              image: "assets/intro3.svg",
              title: "FEEL INTERESTED?",
              desc:
                  "Let's find out whats inside. Browse any kind of property you want to buy/invest.",
            ),
          ],
        ),
      ),
      bottomSheet: currentPage == 2
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(router.optionsPage),
                child: const Text(
                  "Get Started",
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
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageViewController,
                      count: 3,
                      effect: const WormEffect(
                        spacing: 12,
                        dotHeight: 12,
                        dotWidth: 12,
                        dotColor: Colors.black26,
                        activeDotColor: constants.PRIMARY_COLOR,
                      ),
                      onDotClicked: (index) => {
                        pageViewController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        )
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
