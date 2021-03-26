import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/constants/routeNames.dart';
import 'package:h_order/store/navigationStore.dart';

class App extends StatefulWidget {
  App({
    Key key,
  }) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> with WidgetsBindingObserver {
  StreamSubscription _setMainSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    resetSetMain();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  resetSetMain() {
    _setMainSubscription?.cancel();
    _setMainSubscription =
        Future.delayed(Duration(seconds: 10), () {}).asStream().listen((event) {
      AppRouter.toLockPage();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _setMainSubscription?.cancel();
      _setMainSubscription = null;

      AppRouter.toLockPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (event) {
        resetSetMain();
      },
      child: MaterialApp(
        title: 'H Order',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          accentColor: Colors.white,
          backgroundColor: CustomColors.backgroundGrey,
          dialogBackgroundColor: CustomColors.backgroundGrey,
          scaffoldBackgroundColor: CustomColors.backgroundGrey,
          buttonColor: Colors.blueGrey,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueGrey,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blueGrey,
          ),
          primaryIconTheme: IconThemeData(),
          accentIconTheme: IconThemeData(),
          tabBarTheme: TabBarTheme(
            labelPadding: EdgeInsets.symmetric(horizontal: 22),
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 22,
            ),
            unselectedLabelColor: Colors.white,
            unselectedLabelStyle: TextStyle(
              fontSize: 22,
            ),
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.white,
            ),
            headline2: TextStyle(),
            headline3: TextStyle(),
            headline4: TextStyle(),
            headline5: TextStyle(),
            headline6: TextStyle(),
            bodyText1: TextStyle(
              color: Colors.white,
            ),
            bodyText2: TextStyle(),
            subtitle1: TextStyle(
              color: Colors.white,
            ),
            subtitle2: TextStyle(),
            button: TextStyle(
              color: Colors.white,
            ),
            caption: TextStyle(
              color: Colors.white,
            ),
            overline: TextStyle(
              color: Colors.white,
            ),
          ),
          appBarTheme: AppBarTheme(
            color: CustomColors.backgroundGrey,
            elevation: 0,
            centerTitle: true,
            shadowColor: Colors.transparent,
            actionsIconTheme: IconThemeData(
              color: Colors.white,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 22,
              ),
              headline2: TextStyle(
                fontSize: 22,
              ),
              headline3: TextStyle(
                fontSize: 22,
              ),
              headline4: TextStyle(
                fontSize: 22,
              ),
              headline5: TextStyle(
                fontSize: 22,
              ),
              headline6: TextStyle(
                fontSize: 32,
              ),
              bodyText1: TextStyle(),
              bodyText2: TextStyle(),
              subtitle1: TextStyle(),
              subtitle2: TextStyle(),
              button: TextStyle(),
              caption: TextStyle(),
              overline: TextStyle(),
            ),
          ),
        ),
        navigatorKey: NavigationStore.instance.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: RouteNames.Splash,
      ),
    );
  }
}
