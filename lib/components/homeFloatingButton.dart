import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/constants/viewEnum.dart';

typedef void EnumCallback(ViewType val);

class HomeFloatingButton extends StatelessWidget {
  HomeFloatingButton({this.callback});

  final EnumCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .12,
      width: MediaQuery.of(context).size.width * .12,
      child: FloatingActionButton(
        onPressed: () {
          return callback(ViewType.HomeView);
        },
        child: Icon(
          CupertinoIcons.house,
          size: 50,
        ),
      ),
    );
  }
}
