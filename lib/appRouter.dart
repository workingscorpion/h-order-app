import 'package:flutter/material.dart';
import 'package:h_order/constants/routeNames.dart';
import 'package:h_order/pages/homePage.dart';
import 'package:h_order/pages/services/alarmPage.dart';
import 'package:h_order/pages/services/boardPage.dart';
import 'package:h_order/pages/services/settingsPage.dart';
import 'package:h_order/pages/services/shopPage.dart';
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

      case RouteNames.Shop:
        return MaterialPageRoute(
          builder: (BuildContext context) => ShopPage(),
        );

      case RouteNames.Alarm:
        return MaterialPageRoute(
          builder: (BuildContext context) => AlarmPage(),
        );

      case RouteNames.Board:
        return MaterialPageRoute(
          builder: (BuildContext context) => BoardPage(),
        );

      case RouteNames.Settings:
        return MaterialPageRoute(
          builder: (BuildContext context) => SettingsPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashPage(),
        );
    }
  }

  static get context => NavigationStore.instance.navigatorKey.currentContext;

  static pop() {
    return Navigator.of(context).pop();
  }

  static toHomePage() {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(RouteNames.Home, (Route route) => false);
  }

  static toShopPage() {
    Navigator.of(context).pushNamed(RouteNames.Shop);
  }

  static toAlarmPage() {
    Navigator.of(context).pushNamed(RouteNames.Alarm);
  }

  static toBoardPage() {
    Navigator.of(context).pushNamed(RouteNames.Board);
  }

  static toSettingsPage() {
    Navigator.of(context).pushNamed(RouteNames.Settings);
  }
}
