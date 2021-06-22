import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/login/requestLoginModel.dart';
import 'package:h_order/store/deviceStore.dart';
import 'package:h_order/store/navigationStore.dart';
import 'package:h_order/utils/deviceInfo.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:app_settings/app_settings.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:package_info/package_info.dart';

class SplashPage extends StatefulWidget {
  SplashPage();

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  String versionNumber = '';

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
    _getVersion();

    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
    _controller.repeat(reverse: true);
    _animation = _tween.animate(_controller);

    _textEditingController = TextEditingController();

    initialize();
  }

  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionNumber = packageInfo.version;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  _gradient() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [
            0.1,
            1,
          ],
          colors: [
            CustomColors.gradientTopColor,
            CustomColors.gradientBottomColor,
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: _gradient(),
          child: Stack(
            children: <Widget>[
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: _Logo(),
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
                    InkWell(
                      onTap: () => AppSettings.openWIFISettings(),
                      child: Container(
                        child: Text(
                          'Wifi',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 30),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '$versionNumber',
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
                    final value = _textEditingController.text;
                    final result = await DeviceInfo.writeSerialNumber(value);
                    Navigator.of(context).pop(result);
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

      DeviceStore.instance.connectHub();

      Client.token = userInfo['token'];

      await loadInfo();
    } catch (ex) {
      // AppRouter.toLoginPage();
    }
  }

  loadInfo() async {
    try {
      //TODO
      // AppRouter.toHomePage();
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
  final _duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 50),
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
              height: 100,
              width: 100,
            ),
          ),
          Container(
            height: 30,
            child: Stack(
              children: [
                Positioned(
                  top: 2,
                  left: 60,
                  child: Text(
                    '.',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  left: 85,
                  child: Text(
                    '.',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                '삶에 ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w100,
                ),
              ),
              Text(
                '품격',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '을 더하다',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
          Text(
            '고품격 주거공간을 위한 언택트 솔루션',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w100,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            transform: Matrix4.translationValues(6, 0, 0),
            height: 120,
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              repeatForever: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  'H - ORDER',
                  speed: _duration,
                  curve: Curves.linear,
                  textAlign: TextAlign.start,
                  textStyle: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
