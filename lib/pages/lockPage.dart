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
  DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  Timer _timer;
  String _text = '';

  double _hourValue = 0;
  double _minuteValue = 0;
  double _secondValue = 0;

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
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: 2 * pi * (-.25 + _hourValue),
                      alignment: Alignment.centerLeft,
                      child: Text('HOUR'),
                    ),
                    Transform.rotate(
                      angle: 2 * pi * (-.25 + _minuteValue),
                      alignment: Alignment.centerLeft,
                      child: Text('MINUET'),
                    ),
                    Transform.rotate(
                      angle: 2 * pi * (-.25 + _secondValue),
                      alignment: Alignment.centerLeft,
                      child: Text('SECOND'),
                    ),
                  ],
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
