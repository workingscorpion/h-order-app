import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeFloatingButton extends StatelessWidget {
  HomeFloatingButton({this.callback});

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * .12,
      width: MediaQuery.of(context).size.width * .12,
      child: FloatingActionButton(
        onPressed: () {
          return callback();
        },
        child: SvgPicture.asset(
          'assets/icons/home/home.svg',
          color: Theme.of(context).primaryColor,
          height: 40,
        ),
      ),
    );
  }
}
