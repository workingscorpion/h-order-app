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

    final List<String> _categoryNames = ['심플리오', '오드리선', '마타주', '런드리라운지24'];

    final List<String> _itemNames = [
      '헤븐리 샴푸',
      '리프레싱 스칼프샴푸',
      '리프레싱 스칼프 린스',
      '비오틴 탈모케어 샴푸',
      '프로틴부스터 헤어트리트먼트',
      '샤이닝 헤어세럼',
      '내추럴 글로우 토너',
      '내추럴 글로우 크림',
      '리얼이펙트 EGF앰플',
    ];

    final List<int> _itemPrice = [
      6500,
      6000,
      6000,
      17000,
      8500,
      6000,
      10000,
      18000,
      29000,
    ];

    _getLength(int index) {
      if (index == 1) {
        return 7;
      }
      return 9;
    }

    _categories = List.generate(
        4,
        (index) => CategoryModel(
              index: index,
              name: _categoryNames[index],
              products: List.generate(
                _getLength(index),
                (i) => ProductModel(
                  index: i,
                  categoryIndex: index,
                  image: 'assets/sample/commontown/item/s${i + 1}.jpg',
                  name: _itemNames[i],
                  price: _itemPrice[i],
                  options: List(),
                ),
              ),
            ));

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _shopHeader(),
                      TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicatorColor: Colors.white,
                        labelPadding: EdgeInsets.zero,
                        tabs: [
                          ..._categories.map(
                            (item) => Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 52,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Text(
                                item.name,
                                style: Theme.of(context).textTheme.bodyText2,
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
                                padding: EdgeInsets.all(24),
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

  _shopHeader() => Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Row(
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
        ),
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
