import 'package:flutter/material.dart';

class ViewHeader extends StatelessWidget {
  ViewHeader({
    this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: 20,
            ),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    );
  }
}
