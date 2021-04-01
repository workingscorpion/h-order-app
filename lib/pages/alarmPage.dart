import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  physics: FixedExtentScrollPhysics(),
                  perspective: 0.01,
                  itemExtent: 100,
                  offAxisFraction: -.25,
                  overAndUnderCenterOpacity: .25,
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: [
                      ...List.generate(
                        24,
                        (index) => Text(
                          index < 10 ? '0$index' : '$index',
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0, -18, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  physics: FixedExtentScrollPhysics(),
                  perspective: 0.01,
                  itemExtent: 100,
                  offAxisFraction: .25,
                  overAndUnderCenterOpacity: .25,
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: [
                      ...List.generate(
                        (60 / 5).round(),
                        (index) => Text(
                          (index * 5) < 10 ? '0${index * 5}' : '${index * 5}',
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
