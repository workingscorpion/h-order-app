import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/constants/customColors.dart';
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
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
            headline1: TextStyle(
              color: CustomColors.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(),
            headline3: TextStyle(),
            headline4: TextStyle(),
            headline5: TextStyle(),
            headline6: TextStyle(),
          ).apply(
            bodyColor: CustomColors.textBlack,
          ),
        ),
        navigatorKey: NavigationStore.instance.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        // navigatorObservers: [observer],
      );
}
