import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/clock.dart';
import 'package:battery/battery.dart';
import 'package:wifi/wifi.dart';

class StatusBar extends StatefulWidget {
  StatusBar({Key key}) : super(key: key);

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  final _battery = Battery();

  BatteryState _batteryState;
  int _wifiLevel = 0;
  double _batteryLevel = 0;

  StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    super.initState();

    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState event) {
      _batteryState = event;
      setState(() {});
    });

    _getBatteryLevel();
    _getWifiLevel();

    Timer.periodic(new Duration(minutes: 1), (timer) {
      _getBatteryLevel();
      setState(() {});
    });

    Timer.periodic(new Duration(seconds: 30), (timer) {
      _getWifiLevel();
      setState(() {});
    });
  }

  _getBatteryLevel() {
    _battery.batteryLevel.then((value) {
      _batteryLevel = value.toDouble() / 100;
      setState(() {});
    });
  }

  _getWifiLevel() {
    Wifi.level.then((value) {
      _wifiLevel = value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _batteryStateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).bottomAppBarColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Clock(
            fontSize: 24,
          ),
          Spacer(),
          _wifiInidicator(),
          _batteryIndicator(),
        ],
      ),
    );
  }

  _wifiInidicator() => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 5),
        child: Icon(
          _wifiLevel > 0 ? CupertinoIcons.wifi : CupertinoIcons.xmark_circle,
          size: 24,
        ),
      );

  _batteryIndicator() => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 40,
            height: 20,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: _batteryLevel,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
            ),
          ),
          Positioned(
            child: _batteryState == BatteryState.charging
                ? Icon(
                    CupertinoIcons.bolt_fill,
                    color: Colors.white,
                    size: 13,
                  )
                : Container(),
          )
        ],
      );
}
