import 'dart:math';

import 'package:flutter/material.dart';
import 'package:h_order/components/customAppBar.dart';
import 'package:h_order/models/categoryModel.dart';
import 'package:h_order/models/productModel.dart';
import 'package:intl/intl.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<CategoryModel> _categories;

  @override
  void initState() {
    super.initState();

    final random = Random();

    _categories = List.generate(10, (i) {
      final index = i + 1;
      return CategoryModel(
        index: index,
        name: 'Category $index',
        products: List.generate(10, (_i) {
          final _index = _i + 1;
          return ProductModel(
            index: _index,
            image: 'assets/sample/${random.nextInt(9) + 1}.jpg',
            name: 'Product $_index',
            price: (random.nextInt(15) + 5) * 1000,
          );
        }),
      );
    });

    _tabController = TabController(
      length: _categories.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: [
              ..._categories.map((item) => Tab(text: item.name)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ..._categories.map((category) => GridView.count(
                      padding: EdgeInsets.all(5),
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2,
                      children: [
                        ...category.products.map((product) => Container(
                                child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: Image.asset(
                                          product.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        product.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        '${NumberFormat('###,###,###,###').format(product.price)} ₩',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ))),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _appBar() => CustomAppBar.create(
        title: '상점',
      );
}
