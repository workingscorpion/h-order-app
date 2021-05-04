import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/models/cartItemModel.dart';
import 'package:h_order/models/itemModel.dart';
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
  Map<String, ItemModel> _optionMap;

  @override
  void initState() {
    super.initState();

    _optionMap = Map();
    widget.cart?.forEach((element) {
      _initOptionsQuantity(element.product.items);
    });
  }

  _initOptionsQuantity(List<ItemModel> options) {
    options?.forEach((option) {
      _optionMap[option.objectId] = option;

      if ((option.items?.length ?? 0) > 0) {
        _initOptionsQuantity(option.items);
      }
    });
  }

  int get totalAmount {
    return widget.cart?.fold(0,
            (previousValue, element) => previousValue + element.totalAmount) ??
        0;
  }

  int get quantity {
    return widget.cart?.fold(
            0, (previousValue, element) => previousValue + element.quantity) ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: CustomColors.backgroundLightGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PageHeader(
                      title: ['심플리오'],
                      canBack: true,
                    ),
                    _cartItems(),
                    _amount(),
                    _payButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _cartItems() => Expanded(
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            children: [
              ...widget.cart?.map(
                    (cartItem) => _cartItem(cartItem: cartItem),
                  ) ??
                  [],
            ],
          ),
        ),
      );

  _payButton() => Material(
        color: Theme.of(context).accentColor,
        child: InkWell(
          onTap: () {
            _save();
          },
          child: Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(247, 181, 0, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${widget.cart.length}건',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Text(
                  '${NumberFormat().format(totalAmount)}원 결제하기',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 21,
                      ),
                ),
              ],
            ),
          ),
        ),
      );

  _cartItem({
    CartItemModel cartItem,
  }) =>
      Container(
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  Text(
                                    '${cartItem.name}',
                                    style: TextStyle(
                                      fontSize: 32,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _option(
                              quantity: cartItem.quantity,
                              name: cartItem.product.value,
                              price: cartItem.product.price,
                            ),
                            ...cartItem.optionQuantity.entries
                                .where((element) => element.value > 0)
                                .map((element) {
                              final option = _optionMap[element.key];

                              return _option(
                                depth: 1,
                                quantity: element.value,
                                name: option.value,
                                // name: _optionName(option: option),
                                price: option.price,
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 10,
                    thickness: 1,
                  ),
                  Container(height: 20),
                  _itemCount(cartItem),
                ],
              ),
            ),
            _xmark(cartItem),
          ],
        ),
      );

  _itemCount(CartItemModel cartItem) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('수량'),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _countCalc(cartItem, true),
                Container(
                  width: 80,
                  child: Text(
                    '${cartItem.quantity}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                  alignment: Alignment.center,
                ),
                _countCalc(cartItem, false),
              ],
            ),
          ),
        ],
      );

  _countCalc(CartItemModel cartItem, bool isLeft) => Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: CustomColors.subTextBlack,
          borderRadius: isLeft
              ? BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
        ),
        child: IconButton(
          iconSize: 16,
          padding: EdgeInsets.zero,
          onPressed: () {
            if (isLeft) {
              if (cartItem.quantity == 1) {
                widget.cart.remove(cartItem);
              } else {
                cartItem.subtract(1);
              }
            } else {
              cartItem.add(1);
            }
            setState(() {});
          },
          icon: Icon(
            isLeft ? CupertinoIcons.minus : CupertinoIcons.plus,
            size: 20,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
      );

  _xmark(CartItemModel cartItem) => Positioned(
        right: 0,
        top: 0,
        child: InkWell(
          onTap: () {
            widget.cart.remove(cartItem);
            setState(() {});
          },
          child: Container(
            width: 50,
            height: 50,
            child: Icon(
              CupertinoIcons.xmark,
              size: 21,
            ),
          ),
        ),
      );

  _amount() => Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.only(bottom: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Row(
            children: [
              Text('총 결제금액'),
              Spacer(),
              Text('${NumberFormat().format(totalAmount)}원'),
            ],
          ),
        ),
      );

  _option({
    double depth = 0,
    int quantity,
    String name,
    int price,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(left: 12 * depth),
        child: Row(
          children: [
            Text(
              name,
            ),
            Expanded(
              child: Text(
                '${NumberFormat().format(price)}원',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      );

  String _optionName({
    int quantity,
    ItemModel option,
  }) {
    final name =
        quantity != null ? '${option.value} ($quantity)' : '${option.value}';

    // if (option.parentObjectId != null) {
    //   final parent = _optionMap[option.parentObjectId];
    //   return _optionName(option: parent) + ' > ' + name;
    // }

    return name;
  }

  _save() async {
    AppRouter.toShoppingCompletePage(widget.cart);
  }
}
