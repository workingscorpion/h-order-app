import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/constants/cardCompanies.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/service/actionModel.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/models/cartItemModel.dart';
import 'package:h_order/models/itemModel.dart';
import 'package:h_order/models/paymentMethodModel.dart';
import 'package:h_order/store/paymentStore.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  final String serviceObjectId;
  final List<CartItemModel> cart;

  CartPage({
    this.serviceObjectId,
    this.cart,
  });

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  int selectedCard = 0;

  Map<String, ItemModel> _parentMap;
  Map<String, ItemModel> _optionMap;

  ScrollController controller;

  List<PaymentMethodModel> get cards {
    return PaymentStore.instance.cards;
  }

  ServiceModel service;

  @override
  void initState() {
    super.initState();

    _parentMap = Map();
    _optionMap = Map();

    controller = ScrollController();

    widget.cart?.forEach((element) {
      _initOptionsQuantity(items: element.product.items);
    });

    load();
  }

  load() async {
    await PaymentStore.instance.loadCards();
    service = await Client.create().service(widget.serviceObjectId);
    setState(() {});
  }

  _initOptionsQuantity({
    List<ItemModel> items,
    ItemModel parent,
  }) {
    items.forEach((option) {
      if (option.type == 'Group') {
        if (option.items?.isNotEmpty ?? false) {
          _initOptionsQuantity(
            items: option.items,
            parent: option,
          );
        }
      } else {
        if (parent != null) {
          _parentMap[option.objectId] = parent;
        }

        _optionMap[option.objectId] = option;
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
                      // TODO
                      title: ['심플리오'],
                      // title: [service.name],
                      canBack: true,
                    ),
                    _cartItems(),
                    _cardList(),
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

    if (_parentMap.containsKey(option.objectId)) {
      final parent = _parentMap[option.objectId];
      return _optionName(option: parent) + ' / ' + name;
    }

    return name;
  }

  _cardList() => Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.only(bottom: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Text('결제카드 선택'),
              ),
              Container(
                height: 200,
                child: Observer(
                  builder: (context) => (cards?.isNotEmpty ?? false)
                      ? ListView(
                          controller: controller,
                          physics: PageScrollPhysics(),
                          itemExtent: 200,
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...List.generate(cards?.length ?? 0, (index) {
                              return _card(
                                index: index,
                                item: cards[index],
                              );
                            }),
                          ],
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      );

  _card({
    int index,
    PaymentMethodModel item,
  }) {
    final image = CardCompanies.cardImageByCode[item.bankCode];
    final name = CardCompanies.cardNameByCode[item.bankCode];

    return InkWell(
      onTap: () {
        selectedCard = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(12),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 125),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color:
                  selectedCard == index ? Colors.black12 : Colors.transparent,
            ),
            color: selectedCard == index ? Colors.black12 : Colors.transparent,
          ),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              Text('$name (${item.cardLastNumber})'),
              Container(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, String>> _serialize() async {
    try {
      final data = widget.cart;
      if (data?.isEmpty ?? true) {
        throw '장바구니가 비어있습니다.';
      }

      final card = cards[selectedCard];
      if (card == null) {
        throw '결제수단을 선택해주세요.';
      }

      return {
        'cart': jsonEncode(data.map((e) => e.toJson()).toList()),
        'card': jsonEncode(card.toJson()),
      };
    } catch (ex) {
      print(ex);

      await Fluttertoast.showToast(
        msg: ex,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.66),
        textColor: Theme.of(context).textTheme.bodyText1.color,
        fontSize: 17,
      );

      return null;
    }
  }

  _save() async {
    try {
      final data = await _serialize();
      if (data == null) {
        return;
      }

      await Client.create().serviceAction(
          widget.serviceObjectId, 'Payment', ActionModel(data: data));

      AppRouter.toShoppingCompletePage();
    } catch (ex) {
      print(ex);

      await Fluttertoast.showToast(
        msg: '결제에 실패하였습니다. 다시 한 번 시도해주세요.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.66),
        textColor: Theme.of(context).textTheme.bodyText1.color,
        fontSize: 17,
      );
    }
  }
}
