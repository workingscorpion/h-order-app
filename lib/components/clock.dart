import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  final double fontSize;

  Clock({
    this.fontSize = 24,
  });

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  final _dateFormat = DateFormat('hh:mm yyyy.MM.dd E');
  bool _isAfterNoon;
  Timer _timer;
  String _text = '';

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
    return Container(
      child: Text(
        _isAfterNoon ? '오후 $_text요일' : '오전 $_text요일',
        style: TextStyle(
          fontSize: widget.fontSize,
        ),
      ),
    );
  }

  tick() {
    final now = DateTime.now();
    setState(() {
      _text = _dateFormat.format(now);
      _isAfterNoon = now.hour > 12 ? true : false;
    });
  }
}
