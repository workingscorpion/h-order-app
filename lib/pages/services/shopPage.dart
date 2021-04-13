import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/statusBar.dart';
import 'package:h_order/models/cartItemModel.dart';
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
  final StreamController _streamController = StreamController.broadcast();
  StreamSubscription _streamSubscription;

  GlobalKey _appBarKey;
  GlobalKey _floatingButtonKey;
  Map<int, GlobalKey> _buttonKeys;

  TabController _tabController;

  List<CartItemModel> _cart;
  List<CategoryModel> _categories;

  int get quantity {
    return _cart.fold(
        0, (previousValue, element) => previousValue + element.quantity);
  }

  @override
  void initState() {
    super.initState();

    _streamSubscription = _streamController.stream.listen((data) {
      if (data != null && data is CartItemModel) {
        _addCartItem(cartItem: data);
      }
    });

    _appBarKey = GlobalKey();
    _floatingButtonKey = GlobalKey();
    _buttonKeys = Map();

    _cart = List();

    final random = Random();
    var count = 0;

    _categories = List.generate(10, (i) {
      final index = count++;

      return CategoryModel(
        index: index,
        name: 'Category $index',
        products: List.generate(15, (_i) {
          final _index = count++;

          return ProductModel(
            index: _index,
            categoryIndex: index,
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
                    : [],
              );
            }),
          );
        }),
      );
    });

    _categories.expand((element) => element.products).forEach((product) {
      _buttonKeys[product.index] = GlobalKey();
    });

    _tabController = TabController(
      length: _categories.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _floatingActionButton(),
        body: Container(
          child: Column(
            children: [
              StatusBar(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _shopHeader(),
                      TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabs: [
                          ..._categories.map(
                            (item) => Container(
                              child: Text(
                                item.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(fontSize: 40),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ..._categories.map(
                              (category) => GridView.count(
                                padding: EdgeInsets.all(5),
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                crossAxisCount: 3,
                                children: [
                                  ...category.products.map(
                                      (product) => _product(product: product)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _shopHeader() => Row(
        children: [
          Text(
            '본보야지',
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Spacer(),
          TextButton(
            onPressed: () {
              AppRouter.pop();
            },
            child: Row(
              children: [
                Text('홈화면', style: Theme.of(context).textTheme.bodyText2),
                Icon(
                  CupertinoIcons.chevron_right_2,
                  color: Theme.of(context).textTheme.bodyText2.color,
                ),
              ],
            ),
          )
        ],
      );

  _product({
    ProductModel product,
  }) =>
      Material(
        color: Colors.transparent,
        child: Container(
          child: InkWell(
            onTap: () {
              _detail(product: product);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 8,
                  child: Hero(
                    tag: product.index,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    product.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '${NumberFormat().format(product.price)} ₩',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  _floatingActionButton() => Container(
        width: MediaQuery.of(context).size.width * .1,
        child: AspectRatio(
          aspectRatio: 1,
          child: FloatingActionButton(
            key: _floatingButtonKey,
            onPressed: () {
              AppRouter.toCartPage(_cart);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 22,
                  alignment: Alignment.center,
                  child: Icon(
                    CupertinoIcons.cart,
                    size: 22,
                  ),
                ),
                Container(width: 6),
                Text(
                  quantity < 99 ? '$quantity' : '99+',
                  style: TextStyle(
                    height: 1,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  _detail({
    ProductModel product,
  }) async {
    final result = await AppRouter.toProductPage(product);

    if (result == null) {
      return;
    }

    _addCartItem(cartItem: result as CartItemModel);
  }

  _addCartItem({
    CartItemModel cartItem,
  }) {
    final index = _cart.indexWhere((element) => element.key == cartItem.key);
    if (index != -1) {
      _cart[index] += cartItem;
    } else {
      _cart.add(cartItem);
    }

    setState(() {});
  }
}
