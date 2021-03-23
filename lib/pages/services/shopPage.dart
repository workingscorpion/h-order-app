import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/customAppBar.dart';
import 'package:h_order/models/categoryModel.dart';
import 'package:h_order/models/productModel.dart';
import 'package:h_order/models/productOptionModel.dart';
import 'package:intl/intl.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<CategoryModel> _categories;

  List<ProductModel> _cart;

  @override
  void initState() {
    super.initState();

    final random = Random();
    var count = 0;

    _categories = List.generate(10, (i) {
      final index = count++;
      return CategoryModel(
        index: index,
        name: 'Category $index',
        products: List.generate(10, (_i) {
          final _index = count++;

          return ProductModel(
            index: _index,
            image: 'assets/sample/${random.nextInt(9) + 1}.jpg',
            name: 'Product $_index',
            price: (random.nextInt(15) + 5) * 1000,
            options: List.generate(random.nextInt(5) + 5, (__i) {
              final __index = count++;
              final hasSubOption = random.nextBool();
              final subOptionLength =
                  hasSubOption ? (random.nextInt(3) + 1) : 0;
              final max = hasSubOption ? random.nextInt(subOptionLength) : 0;

              return ProductOptionModel(
                index: __index,
                name: 'Option $__index',
                price: hasSubOption ? 0 : (random.nextInt(15) + 5) * 100,
                multiple: hasSubOption && random.nextBool(),
                max: max,
                options: hasSubOption
                    ? List.generate(subOptionLength, (___i) {
                        final ___index = count++;
                        return ProductOptionModel(
                          parent: __index,
                          index: ___index,
                          name: 'Sub Option $___index',
                          price: (random.nextInt(15) + 5) * 100,
                          multiple: max > 0 ? false : random.nextBool(),
                        );
                      })
                    : List(),
              );
            }),
          );
        }),
      );
    });

    _cart = List();

    _tabController = TabController(
      length: _categories.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _floatingActionButton(),
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
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  product.name,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  '${NumberFormat('###,###,###,###').format(product.price)} ₩',
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      AppRouter.toProductPage(product: product);
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      CupertinoIcons.cart_badge_plus,
                                    ),
                                    onPressed: () {},
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

  _floatingActionButton() => FloatingActionButton(
        onPressed: () {
          // AppRouter.toIssueWritePage();
        },
        backgroundColor: Colors.blueGrey,
        child: Container(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Icon(
                  CupertinoIcons.cart,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: _cart.isNotEmpty
                    ? Container(
                        width: 18,
                        height: 18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          '${_cart.length}',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      );

  _appBar() => CustomAppBar.create(
        title: '상점',
      );
}
