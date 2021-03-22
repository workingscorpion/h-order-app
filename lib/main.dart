import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/constants/routeNames.dart';
import 'package:h_order/store/navigationStore.dart';

void main() async {
  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn =
  //         'https://8f3b6fd12fed41e4b1066b728f28c588@o363034.ingest.sentry.io/5581247';
  //   },
  //   appRunner: () => runApp(MyApp()),
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'H Order',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.white,
          backgroundColor: CustomColors.backgroundGrey,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: CustomColors.textBlack,
            ),
            bodyText2: TextStyle(
              color: CustomColors.textBlack,
            ),
            headline1: TextStyle(
              color: CustomColors.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(
              color: CustomColors.textBlack,
            ),
            headline3: TextStyle(
              color: CustomColors.textBlack,
            ),
            headline4: TextStyle(
              color: CustomColors.textBlack,
            ),
            headline5: TextStyle(
              color: CustomColors.textBlack,
            ),
            headline6: TextStyle(
              color: CustomColors.textBlack,
            ),
          ).apply(
            bodyColor: CustomColors.textBlack,
          ),
        ),
        navigatorKey: NavigationStore.instance.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: RouteNames.Splash,
        // navigatorObservers: [observer],
      );
}
