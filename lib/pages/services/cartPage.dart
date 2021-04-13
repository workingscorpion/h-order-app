import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/statusBar.dart';
import 'package:h_order/constants/customColors.dart';
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
    widget.cart?.forEach((element) {
      _initOptionsQuantity(element.product.options);
    });
  }

  _initOptionsQuantity(List<ProductOptionModel> options) {
    options?.forEach((option) {
      _optionMap[option.index] = option;

      if ((option.options?.length ?? 0) > 0) {
        _initOptionsQuantity(option.options);
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
            StatusBar(),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                color: CustomColors.backgroundLightGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _cartHeader(),
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

  _cartHeader() => Row(
        children: [
          Text(
            '장바구니',
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
                Text('목록보기', style: Theme.of(context).textTheme.bodyText2),
                Icon(
                  CupertinoIcons.chevron_right_2,
                  color: Theme.of(context).textTheme.bodyText2.color,
                ),
              ],
            ),
          )
        ],
      );

  _cartItems() => Expanded(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 12),
          children: [
            ...widget.cart?.map(
                  (cartItem) => _cartItem(cartItem: cartItem),
                ) ??
                [],
          ],
        ),
      );

  _paymentInfo() => Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: Colors.black,
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
                    width: 1,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  '총 금액',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${NumberFormat().format(totalAmount)}원',
                    textAlign: TextAlign.right,
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  _payButton() => Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: FlatButton(
          height: 80,
          color: Theme.of(context).accentColor,
          onPressed: () {
            _save();
          },
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
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Text(
                '${NumberFormat().format(totalAmount)}원 결제하기',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      );

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
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.right,
                style: TextStyle(),
              ),
            ),
          ],
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
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
                                    style: TextStyle(color: Colors.black),
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
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 30,
                    thickness: 1,
                  ),
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
                  margin: EdgeInsets.symmetric(horizontal: 12),
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
        right: 10,
        top: 10,
        child: InkWell(
          onTap: () {
            widget.cart.remove(cartItem);
            setState(() {});
          },
          child: Icon(
            CupertinoIcons.xmark,
            size: 30,
          ),
        ),
      );

  _amount() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Row(
          children: [
            Text('총 주문금액'),
            Spacer(),
            Text('${NumberFormat().format(totalAmount)}원'),
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
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Text(
                '${NumberFormat().format(price)}원',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
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
