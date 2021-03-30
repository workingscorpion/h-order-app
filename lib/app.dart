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
  static const _setMainDuration = Duration(minutes: 5);

  Future _future;
  StreamSubscription _setMainSubscription;

  ThemeMode _themeMode = ThemeMode.dark;
  Brightness _brightness = Brightness.dark;

  final iconTheme = IconThemeData(
    color: Colors.white,
  );

  final textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    headline2: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    headline3: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    headline4: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    headline5: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    headline6: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    subtitle2: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    button: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    caption: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    overline: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
  );

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

  setTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _brightness = isDark ? Brightness.dark : Brightness.light;
  }

  disposeSetMain() {
    _setMainSubscription?.cancel();
    _setMainSubscription = null;

    _future?.timeout(Duration.zero, onTimeout: () async {});
    _future = null;
  }

  resetSetMain() {
    disposeSetMain();

    _future = Future.delayed(_setMainDuration, () {});
    _setMainSubscription = _future.asStream().listen((event) {
      toLockPage();
    });
  }

  toLockPage() {
    disposeSetMain();
    AppRouter.toLockPage();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      toLockPage();
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
        themeMode: _themeMode,
        darkTheme: ThemeData(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          accentColor: Colors.white,
          backgroundColor: CustomColors.backgroundGrey,
          dialogBackgroundColor: CustomColors.backgroundGrey,
          scaffoldBackgroundColor: CustomColors.backgroundGrey,
          splashColor: Colors.transparent,
          textTheme: textTheme,
          primaryTextTheme: textTheme,
          accentTextTheme: textTheme,
          iconTheme: iconTheme,
          primaryIconTheme: iconTheme,
          accentIconTheme: iconTheme,
          buttonColor: Colors.blueGrey,
          colorScheme: ColorScheme(
            primary: Colors.white,
            primaryVariant: Colors.white,
            secondary: Colors.white,
            secondaryVariant: Colors.white,
            surface: Colors.white,
            background: Colors.white,
            error: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            onBackground: Colors.white,
            onError: Colors.white,
            brightness: _brightness,
          ),
          tooltipTheme: TooltipThemeData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.black87,
            ),
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          dividerTheme: DividerThemeData(
            thickness: 1,
            color: Colors.white24,
          ),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              side: BorderSide(
                width: 1,
                color: Colors.white,
              ),
            ),
            padding: EdgeInsets.zero,
            splashColor: Colors.transparent,
          ),
          buttonBarTheme: ButtonBarThemeData(
            buttonPadding: EdgeInsets.zero,
            alignment: MainAxisAlignment.center,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              elevation: 0,
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 1,
                color: Colors.white,
              ),
              padding: EdgeInsets.zero,
              elevation: 0,
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              elevation: 0,
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blueGrey,
          ),
          tabBarTheme: TabBarTheme(
            labelPadding: EdgeInsets.symmetric(horizontal: 22),
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
            unselectedLabelColor: Colors.white,
            unselectedLabelStyle: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          appBarTheme: AppBarTheme(
            color: CustomColors.backgroundGrey,
            elevation: 0,
            centerTitle: true,
            shadowColor: Colors.transparent,
            textTheme: textTheme,
            iconTheme: iconTheme,
            actionsIconTheme: iconTheme,
            brightness: _brightness,
          ),
        ),
        navigatorKey: NavigationStore.instance.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: RouteNames.Splash,
      ),
    );
  }
}
