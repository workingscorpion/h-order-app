import 'package:flutter/material.dart';
import 'package:h_order/constants/routeNames.dart';
import 'package:h_order/pages/splashPage.dart';

class AppRouter {
  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.Splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => Container());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashPage());
    }
  }

  // static get context => NavigationStore.instance.navigatorKey.currentContext;

  static toNoticeWritePage() {
    // Navigator.of(context, rootNavigator: true).pushNamed(RouteName.NoticeWrite);
  }
}
