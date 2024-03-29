import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/dynamicHeightGridView.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/models/cartItemModel.dart';
import 'package:h_order/models/itemModel.dart';
import 'package:h_order/store/serviceStore.dart';
import 'package:intl/intl.dart';

class ShopPage extends StatefulWidget {
  final String serviceObjectId;

  ShopPage({
    this.serviceObjectId,
  });

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  final StreamController _streamController = StreamController.broadcast();
  StreamSubscription _streamSubscription;

  GlobalKey _floatingButtonKey;

  TabController _tabController;

  List<CartItemModel> _cart;
  List<ItemModel> _categories;

  ServiceModel get service {
    return ServiceStore.instance.serviceMap[widget.serviceObjectId];
  }

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

    _floatingButtonKey = GlobalKey();

    _cart = List();

    _categories = service.items
        .where((item) =>
            item.type == 'Group' &&
            (item.getTagMetadataBoolean("visible", "value") ?? true))
        .toList();

    _tabController = TabController(
      length: _categories.length,
      vsync: this,
    );

    _tabController.addListener(() {
      setState(() {});
    });
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
            PageHeader(
              title: [service.name],
              canBack: true,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        children: [
                          ..._categories
                              .asMap()
                              .map(
                                (index, item) => MapEntry(
                                  index,
                                  Container(
                                    margin: (index < _categories.length - 1)
                                        ? EdgeInsets.only(right: 10)
                                        : EdgeInsets.zero,
                                    child: Material(
                                      child: InkWell(
                                        onTap: () {
                                          _tabController.animateTo(index);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 52,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _tabController.index == index
                                                ? Colors.black
                                                : Colors.white,
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Text(
                                            item.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                  color: _tabController.index ==
                                                          index
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .values,
                        ],
                      ),
                    ),
                    Container(height: 24),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ..._categories.map(
                            (category) => DynamicHeightGridView(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 50,
                              crossAxisCount: 3,
                              padding: EdgeInsets.only(
                                left: 24,
                                right: 24,
                                bottom: 24,
                              ),
                              children: [
                                ...category.items
                                    .where((item) =>
                                        item.getTagMetadataBoolean(
                                            "visible", "value") ??
                                        true)
                                    .map(
                                      (product) => _product(
                                        category: category,
                                        product: product,
                                      ),
                                    ),
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
      ),
    );
  }

  _product({
    ItemModel category,
    ItemModel product,
  }) {
    final images = product.items.where((item) => item.type == 'Image');

    return Material(
      color: Colors.transparent,
      child: Container(
        child: InkWell(
          onTap: () {
            _detail(
              category: category,
              product: product,
            );
          },
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: product.objectId,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                      ),
                      child: (images?.isNotEmpty ?? false)
                          ? Image.network(
                              images.first.value,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    product.value,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 21,
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: .5,
                  color: Colors.black26,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    '₩ ${NumberFormat().format(product.price)}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xff666666),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _floatingActionButton() => Container(
        height: MediaQuery.of(context).size.width * .12,
        width: MediaQuery.of(context).size.width * .12,
        child: AspectRatio(
          aspectRatio: 1,
          child: FloatingActionButton(
            key: _floatingButtonKey,
            onPressed: () {
              AppRouter.toCartPage(widget.serviceObjectId, _cart);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  transform: Matrix4.translationValues(-1, 0, 0),
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  child: Icon(
                    CupertinoIcons.cart,
                    size: 22,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    quantity < 99 ? '$quantity' : '99+',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  _detail({
    ItemModel product,
    ItemModel category,
  }) async {
    final result = await AppRouter.toProductPage(
      service: service,
      category: category,
      product: product,
    );

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
