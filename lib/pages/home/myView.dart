import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyView extends StatefulWidget {
  MyView();

  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        child: ListView(
          children: [
            _item(
              onTap: () {},
              title: 'asdf',
            ),
          ],
        ),
      );

  _item({
    String title,
    void Function() onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Text(title),
          ],
        ),
      );
}
