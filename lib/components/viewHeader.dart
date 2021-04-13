import 'package:flutter/material.dart';

class ViewHeader extends StatelessWidget {
  ViewHeader({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .25,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        alignment: Alignment.bottomCenter,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          border: Border.all(
            color: Theme.of(context).accentColor,
            width: 3,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
