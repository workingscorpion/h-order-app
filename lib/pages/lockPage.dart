import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:h_order/store/navigationStore.dart';
import 'package:intl/intl.dart';

class LockPage extends StatefulWidget {
  @override
  _LockPageState createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  static const double _radian = 2 * pi;
  static const double _startAngle = -.25;

  DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  Timer _timer;
  String _text = '';

  double _hourValue = 0;
  double _minuteValue = 0;
  double _secondValue = 0;

  double _size = 400;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      Duration(milliseconds: (1000 / 12).round()),
      (timer) {
        tick();
      },
    );

    tick();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigationStore.instance.appKey.currentState.resetSetMain();
        return true;
      },
      child: GestureDetector(
        onPanDown: (event) {
          Navigator.of(context).pop();
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: _size,
                  height: _size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(_size / 2)),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: _size / 2 - 10 / 2,
                        left: _size / 2,
                        child: Transform.rotate(
                          angle: _radian * (_startAngle + _hourValue),
                          alignment: Alignment.centerLeft,
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            height: 10,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: _size / 2 - 5 / 2,
                        left: _size / 2,
                        child: Transform.rotate(
                          angle: _radian * (_startAngle + _minuteValue),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 5,
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: _size / 2 - 2 / 2,
                        left: _size / 2,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.linear,
                          transform: Matrix4.rotationZ(
                              _radian * (_startAngle + _secondValue)),
                          height: 2,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: _size / 2 - 12 / 2,
                        left: _size / 2 - 12 / 2,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.linear,
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('$_text'),
                    Text('$_hourValue'),
                    Text('$_minuteValue'),
                    Text('$_secondValue'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tick() {
    final now = DateTime.now();
    _text = _dateFormat.format(now);

    _secondValue = now.second / 60;
    _minuteValue = (now.minute / 60) + (_secondValue / 60);
    _hourValue = ((now.hour / 12) + (_minuteValue / 60)) % 1;

    setState(() {});
  }
}
