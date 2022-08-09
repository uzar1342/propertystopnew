import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:propertystop/utils/constants.dart' as constants;
import 'package:propertystop/utils/router.dart' as router;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      disableBackButton: true,
      useDefaultLoading: false,
      overlayOpacity: 0.5,
      overlayColor: Colors.black87,
      overlayWidget: Center(
        child: GifView.asset(
          'assets/gifs/logo_red.gif',
          height: 100,
          width: 100,
          frameRate: 30, // default is 15 FPS
        ),
      ),
      child: GetMaterialApp(
        title: 'Property Stop',
        theme: ThemeData(
          // primarySwatch: constants.buildMaterialColor(constants.PRIMARY_COLOR),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: constants.PRIMARY_COLOR,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: constants.PRIMARY_COLOR,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: constants.PRIMARY_COLOR,
            primary: constants.PRIMARY_COLOR,
          ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.controller,
        initialRoute: router.splashPage,
      ),
    );
  }
}
