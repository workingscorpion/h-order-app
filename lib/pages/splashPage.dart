import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/login/requestLoginModel.dart';
import 'package:h_order/store/navigationStore.dart';
import 'package:h_order/utils/deviceInfo.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class SplashPage extends StatefulWidget {
  SplashPage();

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final _duration = Duration(milliseconds: 200);

  get initialized {
    return NavigationStore.instance.appKey.currentState.initialized;
  }

  set initialized(bool value) {
    NavigationStore.instance.appKey.currentState.initialized = value;
  }

  TextEditingController _textEditingController;

  AnimationController _controller;
  Tween<Alignment> _tween = Tween(
    begin: FractionalOffset(0, 0),
    end: FractionalOffset(1, 0),
  );
  Animation<Alignment> _animation;

  String _deviceId = '';
  String _serialNumber = '';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
    _controller.repeat(reverse: true);
    _animation = _tween.animate(_controller);

    _textEditingController = TextEditingController();

    initialize();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xff111111),
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
                  Spacer(),
                  Center(
                    child: Container(
                      width: 98,
                      height: 98,
                      child: _Logo(),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(6, 0, 0),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      '$_deviceId - $_serialNumber',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  initialize() async {
    initialized = false;

    final timer = Timer(Duration(seconds: 2), () async {
      if (!initialized) {
        await autoLogin();

        initialized = true;
      }
    });

    try {
      await initializeDateFormatting('ko');
      Intl.defaultLocale = 'ko';

      WidgetsFlutterBinding.ensureInitialized();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } finally {
      if (!timer.isActive) {
        await autoLogin();

        initialized = true;
      }
    }
  }

  load() async {
    _deviceId = await DeviceInfo.deviceId();
    setState(() {});

    _serialNumber = await DeviceInfo.serialNumber();

    if (_serialNumber?.isEmpty ?? true) {
      _serialNumber = await showDialog(
        context: context,
        child: AlertDialog(
          title: Text('발견된 시리얼 번호 없음'),
          content: Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    Navigator.of(context).pop(_textEditingController.text);
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () async {
                final result = await DeviceInfo.scanSerialNumber();
                Navigator.of(context).pop(result);
              },
              child: Text(
                '스캔',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    }

    setState(() {});
  }

  autoLogin() async {
    try {
      await load();

      final userInfo = await Client.create().login(RequestLoginModel(
        serialNumber: _serialNumber,
        deviceId: _deviceId,
        deviceToken: null,
      ));

      Client.token = userInfo['token'];

      await loadInfo();
    } catch (ex) {
      // AppRouter.toLoginPage();
    }
  }

  loadInfo() async {
    try {
      AppRouter.toHomePage();
    } catch (ex) {
      // AppRouter.toHotelSelectPage();
    }
  }
}

class _Logo extends StatefulWidget {
  _Logo();

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<_Logo> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset('assets/icons/logo.svg'),
    );
  }
}
