import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/constants/routeNames.dart';
import 'package:h_order/store/navigationStore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences _prefs;

  static ThemeMode _themeMode = ThemeMode.light;
  static Brightness _brightness = Brightness.light;

  IconThemeData iconTheme = IconThemeData(
    color: _themeMode == ThemeMode.light ? Colors.black : CustomColors.aWhite,
  );

  TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    WidgetsBinding.instance.addObserver(this);
    initTheme();
    resetSetMain();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  initTheme() async {
    await getPrefs();
    final isLightMode = _prefs.getBool('LightMode') ?? true;
    _themeMode = !isLightMode ? ThemeMode.dark : ThemeMode.light;
    _brightness = !isLightMode ? Brightness.dark : Brightness.light;
    setState(() {});
  }

  getPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  setTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _brightness = isDark ? Brightness.dark : Brightness.light;
    textTheme = _textTheme(isDark);
    _prefs.setBool('LightMode', !isDark);
    setState(() {});
  }

  _textTheme(bool isDark) {
    TextTheme(
      headline1: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      headline2: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      headline3: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      headline4: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      headline5: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      headline6: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      bodyText1: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      bodyText2: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      subtitle1: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      subtitle2: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      button: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      caption: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
      overline: TextStyle(
        fontSize: 22,
        color: isDark ? CustomColors.aWhite : CustomColors.textBlack,
      ),
    );
  }

  Future<bool> getTheme() async {
    if (_themeMode == ThemeMode.dark) {
      return false;
    }
    return true;
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
        theme: lightTheme(),
        darkTheme: darkTheme(),
        navigatorKey: NavigationStore.instance.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: RouteNames.Splash,
      ),
    );
  }

  lightTheme() => ThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        accentColor: Colors.black,
        backgroundColor: CustomColors.backgroundLightGrey,
        dialogBackgroundColor: CustomColors.backgroundLightGrey,
        scaffoldBackgroundColor: CustomColors.backgroundLightGrey,
        splashColor: Colors.transparent,
        textTheme: textTheme,
        primaryTextTheme: textTheme,
        accentTextTheme: textTheme,
        iconTheme: iconTheme,
        primaryIconTheme: iconTheme,
        accentIconTheme: iconTheme,
        buttonColor: Colors.blueGrey,
        colorScheme: ColorScheme(
          primary: CustomColors.aWhite,
          primaryVariant: CustomColors.backgroundLightGrey,
          secondary: Colors.blue,
          secondaryVariant: CustomColors.backgroundLightGrey,
          surface: CustomColors.backgroundLightGrey,
          background: CustomColors.backgroundLightGrey,
          error: Colors.red,
          onPrimary: CustomColors.backgroundLightGrey,
          onSecondary: CustomColors.aWhite,
          onSurface: CustomColors.aWhite,
          onBackground: CustomColors.aWhite,
          onError: Colors.red,
          brightness: _brightness,
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.black87,
          ),
          textStyle: TextStyle(
            color: CustomColors.aWhite,
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
            ),
          ),
          padding: EdgeInsets.zero,
          splashColor: Colors.transparent,
          buttonColor: CustomColors.aBlack,
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
              color: CustomColors.aBlack,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: CustomColors.aBlack,
            side: BorderSide(
              width: 1,
              color: CustomColors.aWhite,
            ),
            padding: EdgeInsets.zero,
            elevation: 0,
            textStyle: TextStyle(
              color: CustomColors.aBlack,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: CustomColors.aBlack,
            padding: EdgeInsets.zero,
            elevation: 0,
            textStyle: TextStyle(
              color: CustomColors.aBlack,
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey,
        ),
        tabBarTheme: TabBarTheme(
          labelPadding: EdgeInsets.symmetric(horizontal: 22),
          labelColor: CustomColors.aWhite,
          labelStyle: TextStyle(
            fontSize: 22,
            color: CustomColors.aBlack,
          ),
          unselectedLabelColor: CustomColors.aWhite,
          unselectedLabelStyle: TextStyle(
            fontSize: 22,
            color: CustomColors.aBlack,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: CustomColors.backgroundLightGrey,
          elevation: 0,
          centerTitle: true,
          shadowColor: Colors.transparent,
          textTheme: textTheme,
          iconTheme: iconTheme,
          actionsIconTheme: iconTheme,
          brightness: _brightness,
        ),
      );

  darkTheme() => ThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        accentColor: CustomColors.aWhite,
        backgroundColor: CustomColors.backgroundDarkGrey,
        dialogBackgroundColor: CustomColors.backgroundDarkGrey,
        scaffoldBackgroundColor: CustomColors.backgroundDarkGrey,
        splashColor: Colors.transparent,
        textTheme: textTheme,
        primaryTextTheme: textTheme,
        accentTextTheme: textTheme,
        iconTheme: iconTheme,
        primaryIconTheme: iconTheme,
        accentIconTheme: iconTheme,
        buttonColor: Colors.blueGrey,
        colorScheme: ColorScheme(
          primary: CustomColors.aWhite,
          primaryVariant: CustomColors.backgroundDarkGrey,
          secondary: Colors.blue,
          secondaryVariant: CustomColors.backgroundDarkGrey,
          surface: CustomColors.backgroundDarkGrey,
          background: CustomColors.backgroundDarkGrey,
          error: Colors.red,
          onPrimary: CustomColors.backgroundDarkGrey,
          onSecondary: CustomColors.aWhite,
          onSurface: CustomColors.aWhite,
          onBackground: CustomColors.aWhite,
          onError: Colors.red,
          brightness: _brightness,
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.black87,
          ),
          textStyle: TextStyle(
            color: CustomColors.aWhite,
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
              color: CustomColors.aWhite,
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
              color: CustomColors.aWhite,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              width: 1,
              color: CustomColors.aWhite,
            ),
            padding: EdgeInsets.zero,
            elevation: 0,
            textStyle: TextStyle(
              color: CustomColors.aWhite,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            textStyle: TextStyle(
              color: CustomColors.aWhite,
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey,
        ),
        tabBarTheme: TabBarTheme(
          labelPadding: EdgeInsets.symmetric(horizontal: 22),
          labelColor: CustomColors.aWhite,
          labelStyle: TextStyle(
            fontSize: 22,
            color: CustomColors.aWhite,
          ),
          unselectedLabelColor: CustomColors.aWhite,
          unselectedLabelStyle: TextStyle(
            fontSize: 22,
            color: CustomColors.aWhite,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: CustomColors.backgroundDarkGrey,
          elevation: 0,
          centerTitle: true,
          shadowColor: Colors.transparent,
          textTheme: textTheme,
          iconTheme: iconTheme,
          actionsIconTheme: iconTheme,
          brightness: _brightness,
        ),
      );
}
