import 'dart:math';

import 'package:flutter/material.dart';
import 'package:h_order/components/customAppBar.dart';
import 'package:h_order/models/categoryModel.dart';
import 'package:h_order/models/productModel.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;

  ProductPage({
    this.product,
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  }

  _appBar() => CustomAppBar.create(
        title: '상점',
      );
}
