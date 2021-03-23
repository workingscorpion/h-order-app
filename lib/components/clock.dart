import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateFormat _dateFormat;
  Timer _timer;
  String _text = '';

  @override
  void initState() {
    super.initState();

    _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
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
    return Container(
      child: Text(
        _text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.white24,
        ),
      ),
    );
  }

  tick() {
    final now = DateTime.now();
    _text = _dateFormat.format(now);
    setState(() {});
  }
}
