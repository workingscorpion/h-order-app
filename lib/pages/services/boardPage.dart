import 'package:flutter/material.dart';
import 'package:h_order/components/customAppBar.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(),
    );
  }

  _appBar() => CustomAppBar.create(
        title: '주변정보',
      );
}
