import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/models/cartItemModel.dart';
import 'package:h_order/models/productOptionModel.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  final List<CartItemModel> cart;

  CartPage({
    this.cart,
  });

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  Map<int, ProductOptionModel> _optionMap;

  @override
  void initState() {
    super.initState();

    _optionMap = Map();
    widget.cart.forEach((element) {
      _initOptionsQuantity(element.product.options);
    });
  }

  _initOptionsQuantity(List<ProductOptionModel> options) {
    options.forEach((option) {
      _optionMap[option.index] = option;

      if ((option.options?.length ?? 0) > 0) {
        _initOptionsQuantity(option.options);
      }
    });
  }

  int get totalAmount {
    return widget.cart.fold(
        0, (previousValue, element) => previousValue + element.totalAmount);
  }

  int get quantity {
    return widget.cart
        .fold(0, (previousValue, element) => previousValue + element.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상점'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 12),
              children: [
                ...widget.cart
                        ?.map((cartItem) => _cartItem(cartItem: cartItem)) ??
                    [],
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: .5,
                  color: Colors.white10,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Column(
              children: [
                _titleItem(
                  label: '배달위치',
                  text: '진주오피스텔 A동 102호',
                ),
                _titleItem(
                  label: '결제정보',
                  text: '롯데카드 [1234]',
                  margin: false,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: .5,
                        color: Colors.white10,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '총 금액',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${NumberFormat().format(totalAmount)} ₩',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: FlatButton(
              color: Colors.blueGrey,
              onPressed: () {
                _save();
              },
              child: Text(
                '결제하기',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _titleItem({
    String label,
    String text,
    bool margin = true,
  }) =>
      Container(
        margin: margin ? EdgeInsets.only(bottom: 8) : EdgeInsets.zero,
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );

  _cartItem({
    CartItemModel cartItem,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Text(
                              '${cartItem.name}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${NumberFormat().format(cartItem.totalAmount)} ₩',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _option(
                        quantity: cartItem.quantity,
                        name: cartItem.product.name,
                        price: cartItem.product.price,
                      ),
                      ...cartItem.optionQuantity.entries
                          .where((element) => element.value > 0)
                          .map((element) {
                        final option = _optionMap[element.key];

                        return _option(
                          depth: 1,
                          quantity: element.value,
                          name: _optionName(option: option),
                          price: option.price,
                        );
                      }),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        child: IconButton(
                          iconSize: 16,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (cartItem.quantity == 1) {
                              widget.cart.remove(cartItem);
                            } else {
                              cartItem.subtract(1);
                            }
                            setState(() {});
                          },
                          icon: Icon(
                            CupertinoIcons.minus,
                            size: 16,
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '${cartItem.quantity}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: 16,
                        height: 16,
                        child: IconButton(
                          iconSize: 16,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            cartItem.add(1);
                            setState(() {});
                          },
                          icon: Icon(
                            CupertinoIcons.plus,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: .5,
                    color: Colors.white10,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  _option({
    double depth = 0,
    int quantity,
    String name,
    int price,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 6),
        padding: EdgeInsets.only(left: 12 * depth),
        child: Row(
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.white38,
                fontSize: 12,
              ),
            ),
            Expanded(
              child: Text(
                '${NumberFormat().format(price)} ₩',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );

  String _optionName({
    int quantity,
    ProductOptionModel option,
  }) {
    final name =
        quantity != null ? '${option.name} ($quantity)' : '${option.name}';

    if (option.parent != null) {
      final parent = _optionMap[option.parent];
      return _optionName(option: parent) + ' > ' + name;
    }

    return name;
  }

  _save() async {
    AppRouter.toShoppingCompletePage(widget.cart);
  }
}
