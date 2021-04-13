import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeFloatingButton extends StatelessWidget {
  HomeFloatingButton({this.callback});

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .12,
      width: MediaQuery.of(context).size.width * .12,
      child: FloatingActionButton(
        onPressed: () {
          return callback();
        },
        child: Icon(
          CupertinoIcons.house,
          size: 50,
        ),
      ),
    );
  }
}
