import 'package:flutter/material.dart';
import 'package:h_order/components/clock/gradientClock.dart';
import 'package:h_order/store/navigationStore.dart';

class LockPage extends StatefulWidget {
  @override
  _LockPageState createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
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
            backgroundColor: Colors.white,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: GradientClock(
                startColor: Color.fromRGBO(185, 235, 201, 1),
                endColor: Color.fromRGBO(52, 152, 219, 1),
              ),
            )),
      ),
    );
  }
}
