import 'package:flutter/material.dart';
import 'package:h_order/constants/routeNames.dart';
import 'package:h_order/models/productModel.dart';
import 'package:h_order/pages/alarm/alarmPage.dart';
import 'package:h_order/pages/homePage.dart';
import 'package:h_order/pages/lockPage.dart';
import 'package:h_order/pages/my/favoritePage.dart';
import 'package:h_order/pages/my/infoPage.dart';
import 'package:h_order/pages/my/paymentPage.dart';
import 'package:h_order/pages/my/screenPage.dart';
import 'package:h_order/pages/services/billDetailPage.dart';
import 'package:h_order/pages/services/callPage.dart';
import 'package:h_order/pages/services/boardPage.dart';
import 'package:h_order/pages/services/cartPage.dart';
import 'package:h_order/pages/services/productPage.dart';
import 'package:h_order/pages/services/settingsPage.dart';
import 'package:h_order/pages/services/shopPage.dart';
import 'package:h_order/pages/services/shoppingCompletePage.dart';
import 'package:h_order/pages/services/informationPage.dart';
import 'package:h_order/pages/splashPage.dart';
import 'package:h_order/store/navigationStore.dart';

import 'models/cartItemModel.dart';

class AppRouter {
  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.Splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => SplashPage(),
        );

      case RouteNames.Lock:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => LockPage(),
        );

      case RouteNames.Home:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => HomePage(),
        );

      case RouteNames.Shop:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => ShopPage(),
        );

      case RouteNames.Cart:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => CartPage(
            cart: settings.arguments as List<CartItemModel>,
          ),
        );

      case RouteNames.Product:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => ProductPage(
            product: settings.arguments as ProductModel,
          ),
        );

      case RouteNames.Call:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => CallPage(),
        );

      case RouteNames.BillDetail:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BillDetailPage(),
        );

      case RouteNames.Board:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BoardPage(),
        );

      case RouteNames.Information:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => InformationPage(),
        );

      case RouteNames.Settings:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => SettingsPage(),
        );

      case RouteNames.ShoppingComplete:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => ShoppingCompletePage(
            cart: settings.arguments as List<CartItemModel>,
          ),
        );

      case RouteNames.Alarm:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => AlarmPage(),
        );

      case RouteNames.Info:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => InfoPage(),
        );

      case RouteNames.Payment:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => PaymentPage(),
        );

      case RouteNames.Favorite:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => FavoritePage(),
        );

      case RouteNames.Screen:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => ScreenPage(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
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
    return Navigator.of(context).pushNamed(RouteNames.Shop);
  }

  static toCartPage(List<CartItemModel> cart) {
    return Navigator.of(context).pushNamed(
      RouteNames.Cart,
      arguments: cart,
    );
  }

  static toShoppingCompletePage(List<CartItemModel> cart) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.ShoppingComplete,
      (route) => route.settings.name == RouteNames.Home,
      arguments: cart,
    );
  }

  static toProductPage(
    ProductModel product,
  ) async {
    return Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(
          name: RouteNames.Product,
        ),
        builder: (BuildContext context) => ProductPage(
          product: product,
        ),
      ),
    );
  }

  static toCallPage() {
    return Navigator.of(context).pushNamed(RouteNames.Call);
  }

  static toBillDetailPage() {
    return Navigator.of(context).pushNamed(RouteNames.BillDetail);
  }

  static toBoardPage() {
    return Navigator.of(context).pushNamed(RouteNames.Board);
  }

  static toInformationPage() {
    return Navigator.of(context).pushNamed(RouteNames.Information);
  }

  static toSettingsPage() {
    return Navigator.of(context).pushNamed(RouteNames.Settings);
  }

  static toLockPage() {
    return Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.Lock,
      (route) => route.settings.name != RouteNames.Lock,
    );
  }

  static toInfoPage() {
    return Navigator.of(context).pushNamed(RouteNames.Info);
  }

  static toPaymentPage() {
    return Navigator.of(context).pushNamed(RouteNames.Payment);
  }

  static toFavoritePage() {
    return Navigator.of(context).pushNamed(RouteNames.Favorite);
  }

  static toScreenPage() {
    return Navigator.of(context).pushNamed(RouteNames.Screen);
  }

  static toAlarmPage() {
    return Navigator.of(context).pushNamed(RouteNames.Alarm);
  }
}
