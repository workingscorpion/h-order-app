import 'package:flutter/material.dart';
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
          body: Container(
            alignment: Alignment.center,
            child: Text('asdf'),
          ),
        ),
      ),
    );
  }
}
