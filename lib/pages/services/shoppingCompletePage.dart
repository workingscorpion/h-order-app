import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/models/cartItemModel.dart';
import 'package:h_order/models/productOptionModel.dart';
import 'package:intl/intl.dart';

class ShoppingCompletePage extends StatefulWidget {
  final List<CartItemModel> cart;

  ShoppingCompletePage({
    this.cart,
  });

  @override
  _ShoppingCompletePageState createState() => _ShoppingCompletePageState();
}

class _ShoppingCompletePageState extends State<ShoppingCompletePage>
    with SingleTickerProviderStateMixin {
  Map<String, ProductOptionModel> _optionMap;

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
      _optionMap[option.objectId] = option;

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '주문이 완료되었습니다.',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Container(height: 30),
                  Text(
                    '주문하신 매장에서 주문을 수락한 뒤에는 결제취소가 불가합니다.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.black,
            child: InkWell(
              onTap: () {
                _save();
              },
              child: Container(
                height: 80,
                alignment: Alignment.center,
                child: Text(
                  '메인으로',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
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

  _save() async {
    AppRouter.toHomePage();
  }
}
