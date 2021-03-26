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
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    '주문하신 매장에서 주문을 수락한 뒤에는 결제취소가 불가합니다.',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
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
                '홈으로',
                style: TextStyle(
                  fontSize: 16,
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
