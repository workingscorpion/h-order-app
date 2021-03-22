import 'package:flutter/material.dart';
import 'package:h_order/components/customAppBar.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(),
    );
  }

  _appBar() => CustomAppBar.create(
        title: '상점',
      );
}
