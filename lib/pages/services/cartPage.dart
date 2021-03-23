import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/customAppBar.dart';
import 'package:h_order/models/cartItemModel.dart';
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
  @override
  void initState() {
    super.initState();
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
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
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

  _appBar() => CustomAppBar.create(
        title: '상점',
      );

  // _option({
  //   ProductOptionModel option,
  //   double depth = 1,
  // }) =>
  //     <Widget>[
  //       ...depth == 1
  //           ? [
  //               Container(
  //                 decoration: BoxDecoration(
  //                   border: Border(
  //                     top: BorderSide(
  //                       width: .5,
  //                       color: Colors.white10,
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ]
  //           : [],
  //       Material(
  //         color: Colors.transparent,
  //         child: InkWell(
  //           child: Container(
  //             height: 40,
  //             padding: EdgeInsets.only(
  //               left: 12 * depth,
  //               right: 12,
  //             ),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.only(right: 8),
  //                   child: Text(
  //                     option.name,
  //                     style: TextStyle(
  //                       fontSize: 16 - depth * 2,
  //                     ),
  //                   ),
  //                 ),
  //                 ...((option.max ?? 0) > 0)
  //                     ? [
  //                         Text(
  //                           '(최대${option.max}개)',
  //                           style: TextStyle(
  //                             fontSize: 12 - depth * 2,
  //                           ),
  //                         ),
  //                       ]
  //                     : [],
  //                 Expanded(
  //                   child: Container(
  //                     alignment: Alignment.centerRight,
  //                     margin: EdgeInsets.only(right: 12),
  //                     child: (option.options?.length ?? 0) == 0
  //                         ? Text(
  //                             '${NumberFormat('###,###,###,###').format(option.price)} ₩',
  //                             style: TextStyle(
  //                               fontSize: 14,
  //                             ),
  //                           )
  //                         : Container(),
  //                   ),
  //                 ),
  //                 ...(option.options?.length ?? 0) == 0
  //                     ? option.multiple
  //                         ? [
  //                             Container(
  //                               width: 16,
  //                               child: IconButton(
  //                                 iconSize: 16,
  //                                 padding: EdgeInsets.zero,
  //                                 onPressed: () {
  //                                   _optionQuantityMap[option.index] = max(
  //                                       _optionQuantityMap[option.index], 0);
  //                                   setState(() {});
  //                                 },
  //                                 icon: Icon(
  //                                   CupertinoIcons.minus,
  //                                   size: 16,
  //                                 ),
  //                               ),
  //                             ),
  //                             Container(
  //                               margin: EdgeInsets.symmetric(horizontal: 12),
  //                               child: Text(
  //                                 '${_optionQuantityMap[option.index]}',
  //                                 style: TextStyle(
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                             ),
  //                             Container(
  //                               width: 16,
  //                               child: IconButton(
  //                                 iconSize: 16,
  //                                 padding: EdgeInsets.zero,
  //                                 onPressed: () {
  //                                   _optionQuantityMap[option.index] += 1;
  //                                   setState(() {});
  //                                 },
  //                                 icon: Icon(
  //                                   CupertinoIcons.add,
  //                                   size: 16,
  //                                 ),
  //                               ),
  //                             ),
  //                           ]
  //                         : [
  //                             Container(
  //                               width: 64,
  //                               alignment: Alignment.center,
  //                               child: Checkbox(
  //                                 activeColor: Colors.blueGrey,
  //                                 checkColor: Colors.white,
  //                                 value: _optionQuantityMap[option.index] == 1,
  //                                 onChanged: (value) {
  //                                   _changeSelect(option: option, value: value);
  //                                 },
  //                               ),
  //                             ),
  //                           ]
  //                     : [],
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       ...(option.options?.length ?? 0) > 0
  //           ? option.options
  //               .expand((sub) => _option(option: sub, depth: depth + 1))
  //           : [],
  //     ];

  // _changeSelect({
  //   ProductOptionModel option,
  //   bool value,
  // }) async {
  //   if (value && option.parent != null) {
  //     final parent = _optionMap[option.parent];

  //     if ((parent.max ?? 0) > 0) {
  //       var count = 0;
  //       parent.options.forEach((sub) {
  //         if (_optionQuantityMap[sub.index] == 1) {
  //           count += 1;
  //         }
  //       });

  //       if (parent.max <= count) {
  //         await Fluttertoast.cancel();
  //         await Fluttertoast.showToast(
  //           msg: '옵션 최대개수를 초과하여 선택 할 수 없습니다. (최대 ${parent.max}개)',
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 2,
  //           fontSize: 14,
  //         );

  //         return;
  //       }
  //     }
  //   }

  //   _optionQuantityMap[option.index] = value ? 1 : 0;
  //   setState(() {});
  // }

  _cartItem({
    CartItemModel cartItem,
  }) =>
      Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  cartItem.name,
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
          ],
        ),
      );

  _save() {
    // final result = CartItemModel(
    //   name: widget.product.name,
    //   amount: amount,
    //   optionAmount: optionAmount,
    //   totalAmount: totalAmount,
    //   optionQuantity: _optionQuantityMap,
    //   quantity: _quantity,
    //   product: widget.product,
    // );

    Navigator.of(context).pop();
  }
}
