import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GradientClock extends StatefulWidget {
  GradientClock({this.startColor, this.endColor});

  final Color startColor;
  final Color endColor;

  @override
  _GradientClockState createState() => _GradientClockState();
}

class _GradientClockState extends State<GradientClock> {
  String _timeString;
  int hour;
  String hourString;
  String minuteString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    hourString = DateFormat('hh').format(dateTime);
    minuteString = DateFormat('mm').format(dateTime);
    hour = dateTime.hour;
    return DateFormat('yyyy년 MM월 dd일').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _gradientDecoration(),
      child: _circle(),
    );
  }

  _gradientDecoration() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [
            0.1,
            0.8,
          ],
          colors: [
            widget.startColor,
            widget.endColor,
          ],
        ),
      );

  _circle() => Container(
        margin: EdgeInsets.only(
          left: 100,
          right: 100,
          bottom: 300,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            width: 10,
            color: Colors.white,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _clockTemperature(),
              _clockTexts(hour > 12 ? "PM" : "AM", 40, 50),
              _clockTexts(
                  hour > 12
                      ? "$hourString:$minuteString"
                      : "$hour:$minuteString",
                  120),
              _clockTexts(_timeString, 30)
            ],
          ),
        ),
      );

  _clockTemperature() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '서울 / 28℃',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          Icon(
            CupertinoIcons.cloud_sun,
            size: 56,
          ),
        ],
      );

  _clockTexts(String value, double size, [double topMargin]) => Container(
        margin: topMargin != null ? EdgeInsets.only(top: topMargin) : null,
        child: Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: size,
          ),
        ),
      );
}
