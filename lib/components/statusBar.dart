import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/clock.dart';
import 'package:battery/battery.dart';

class StatusBar extends StatefulWidget {
  StatusBar({Key key}) : super(key: key);

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  final _battery = Battery();

  BatteryState _batteryState;
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

    Timer.periodic(new Duration(minutes: 1), (timer) {
      _battery.batteryLevel.then((value) {
        _batteryLevel = value.toDouble() / 100;
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
      child: Row(
        children: [
          Clock(
            fontSize: 24,
          ),
          // TODO: 잠금화면 이동 버튼 제거
          Spacer(),
          InkWell(
            onTap: () {
              AppRouter.toLockPage();
            },
            child: Text(
              '잠금화면',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          // TODO: wifi 추가
          _batteryIndicator(),
        ],
      ),
    );
  }

  _batteryIndicator() => Stack(
        children: [
          Container(
            width: 50,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                width: 3,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: _batteryLevel,
              child: Container(
                color: Colors.green,
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 2,
            child: _batteryState == BatteryState.charging
                ? Icon(
                    CupertinoIcons.bolt_fill,
                    color: Colors.white,
                    size: 20,
                  )
                : Container(),
          )
        ],
      );
}
