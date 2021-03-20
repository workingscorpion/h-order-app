import 'package:flutter/material.dart';
import 'package:h_order/constants/routeNames.dart';
import 'package:h_order/pages/homePage.dart';
import 'package:h_order/pages/splashPage.dart';
import 'package:h_order/store/navigationStore.dart';

class AppRouter {
  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.Splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashPage(),
        );

      case RouteNames.Home:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        );

      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashPage(),
        );
    }
  }

  static get context => NavigationStore.instance.navigatorKey.currentContext;

  static toHomePage() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RouteNames.Home, (Route route) => false);
  }
}
