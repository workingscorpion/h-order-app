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
  final _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
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
        _text,
        style: TextStyle(
          fontSize: widget.fontSize,
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
