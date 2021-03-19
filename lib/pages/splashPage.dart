import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage();

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  bool _initialized = false;

  AnimationController _controller;
  Tween<Alignment> _tween = Tween(
    begin: FractionalOffset(0, 0),
    end: FractionalOffset(1, 0),
  );
  Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
    _controller.repeat(reverse: true);
    _animation = _tween.animate(_controller);

    initialize();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Image.asset(
                'assets/splash/splash.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                alignment: _animation.value,
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/logo.svg',
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
      );

  initialize() async {
    final timer = Timer(Duration(seconds: 2), () async {
      if (_initialized) {
        await autoLogin();
        // _userInfoStore.isInitialized = true;
      }
    });

    try {
      _initialized = false;

      // await initializeDateFormatting('ko');
      // Intl.defaultLocale = 'ko';

      WidgetsFlutterBinding.ensureInitialized();

      // await Firebase.initializeApp();
      // await FCMManger.instance.initialize();
      // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      // await FirebaseCrashlytics.instance
      // .setCrashlyticsCollectionEnabled(!kDebugMode);

      // FlutterDownloader.initialize();

      // SystemChrome.setPreferredOrientations([
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.portraitDown,
      // ]);

      _initialized = true;
    } finally {
      if (!timer.isActive) {
        await autoLogin();
        // _userInfoStore.isInitialized = true;
      }
    }
  }

  autoLogin() async {
    try {
      // final String id = await SharedPreferencesHelper.getUserId();
      // if (id == null) {
      //   throw Exception();
      // }

      // await _userInfoStore.login(id: id);

      await loadHotels();
    } catch (ex) {
      // AppRouter.toLoginPage();
    }
  }

  loadHotels() async {
    try {
      // await _hotelInfoStore.loadHotels();
      // await _hotelInfoStore.selectHotel(_hotelInfoStore.hotelList.first);
      // AppRouter.toHomePage();
    } catch (ex) {
      // AppRouter.toHotelSelectPage();
    }
  }
}
