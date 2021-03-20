import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_order/appRouter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class SplashPage extends StatefulWidget {
  SplashPage();

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  bool initialized = false;

  AnimationController _controller;
  Tween<Alignment> _tween = Tween(
    begin: FractionalOffset(0, 0),
    end: FractionalOffset(1, 0),
  );
  Animation<Alignment> _animation;

  final _duration = Duration(milliseconds: 200);

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
                  Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      repeatForever: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'H ORDER',
                          speed: _duration,
                          curve: Curves.linear,
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  initialize() async {
    final timer = Timer(Duration(seconds: 2), () async {
      if (initialized) {
        await autoLogin();
        // _userInfoStore.isInitialized = true;
      }
    });

    try {
      initialized = false;

      await initializeDateFormatting('ko');
      Intl.defaultLocale = 'ko';

      WidgetsFlutterBinding.ensureInitialized();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      initialized = true;
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
      AppRouter.toHomePage();
    } catch (ex) {
      // AppRouter.toHotelSelectPage();
    }
  }
}
