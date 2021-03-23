import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/components/customAppBar.dart';
import 'package:h_order/models/productModel.dart';
import 'package:h_order/models/productOptionModel.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;

  ProductPage({
    this.product,
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  static const int minQuantity = 1;

  int _quantity;
  Map<int, ProductOptionModel> _optionMap;
  Map<int, int> _optionQuantityMap;

  get totalAmount {
    return _quantity * amount;
  }

  get amount {
    return widget.product.price + optionAmount;
  }

  get optionAmount {
    var result = 0;
    _optionQuantityMap.forEach((key, value) {
      result += value * _optionMap[key]?.price;
    });

    return result;
  }

  @override
  void initState() {
    super.initState();

    _quantity = 1;
    _optionMap = Map();
    _optionQuantityMap = Map();

    _initOptionsQuantity(widget.product.options);
  }

  _initOptionsQuantity(List<ProductOptionModel> options) {
    options.forEach((option) {
      _optionMap[option.index] = option;
      _optionQuantityMap[option.index] = 0;

      if ((option.options?.length ?? 0) > 0) {
        _initOptionsQuantity(option.options);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * .5,
            child: Image.asset(
              widget.product.image,
              fit: BoxFit.cover,
            ),
          ),
          _title(),
          Expanded(
            child: ListView(
              children: [
                ...widget.product.options
                        ?.expand((option) => _option(option: option)) ??
                    List(),
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
                '장바구니 담기 (${NumberFormat('###,###,###,###').format(totalAmount)} ₩)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _title() => Material(
        color: Colors.transparent,
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: .5,
                color: Colors.white10,
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 12),
                  child: Text(
                    '${NumberFormat('###,###,###,###').format(amount)} ₩',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Container(
                width: 16,
                child: IconButton(
                  iconSize: 16,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _quantity = max(_quantity - 1, minQuantity);
                    setState(() {});
                  },
                  icon: Icon(
                    CupertinoIcons.minus,
                    size: 16,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '$_quantity',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: 16,
                child: IconButton(
                  iconSize: 16,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _quantity = _quantity + 1;
                    setState(() {});
                  },
                  icon: Icon(
                    CupertinoIcons.add,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  _appBar() => CustomAppBar.create(
        title: '상점',
      );

  _option({
    ProductOptionModel option,
    double depth = 1,
  }) =>
      <Widget>[
        ...depth == 1
            ? [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: .5,
                        color: Colors.white10,
                      ),
                    ),
                  ),
                )
              ]
            : [],
        Material(
          color: Colors.transparent,
          child: InkWell(
            child: Container(
              height: 40,
              padding: EdgeInsets.only(
                left: 12 * depth,
                right: 12,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Text(
                      option.name,
                      style: TextStyle(
                        fontSize: 16 - depth * 2,
                      ),
                    ),
                  ),
                  ...((option.max ?? 0) > 0)
                      ? [
                          Text(
                            '(최대${option.max}개)',
                            style: TextStyle(
                              fontSize: 12 - depth * 2,
                            ),
                          ),
                        ]
                      : [],
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 12),
                      child: (option.options?.length ?? 0) == 0
                          ? Text(
                              '${NumberFormat('###,###,###,###').format(option.price)} ₩',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )
                          : Container(),
                    ),
                  ),
                  ...(option.options?.length ?? 0) == 0
                      ? option.multiple
                          ? [
                              Container(
                                width: 16,
                                child: IconButton(
                                  iconSize: 16,
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    _optionQuantityMap[option.index] = max(
                                        _optionQuantityMap[option.index], 0);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    CupertinoIcons.minus,
                                    size: 16,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  '${_optionQuantityMap[option.index]}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                width: 16,
                                child: IconButton(
                                  iconSize: 16,
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    _optionQuantityMap[option.index] += 1;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    CupertinoIcons.add,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ]
                          : [
                              Container(
                                width: 64,
                                alignment: Alignment.center,
                                child: Checkbox(
                                  activeColor: Colors.blueGrey,
                                  checkColor: Colors.white,
                                  value: _optionQuantityMap[option.index] == 1,
                                  onChanged: (value) {
                                    _changeSelect(option: option, value: value);
                                  },
                                ),
                              ),
                            ]
                      : [],
                ],
              ),
            ),
          ),
        ),
        ...(option.options?.length ?? 0) > 0
            ? option.options
                .expand((sub) => _option(option: sub, depth: depth + 1))
            : [],
      ];

  _changeSelect({
    ProductOptionModel option,
    bool value,
  }) async {
    if (value && option.parent != null) {
      final parent = _optionMap[option.parent];

      if ((parent.max ?? 0) > 0) {
        var count = 0;
        parent.options.forEach((sub) {
          if (_optionQuantityMap[sub.index] == 1) {
            count += 1;
          }
        });

        if (parent.max <= count) {
          await Fluttertoast.cancel();
          await Fluttertoast.showToast(
            msg: '옵션 최대개수를 초과하여 선택 할 수 없습니다. (최대 ${parent.max}개)',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            fontSize: 14,
          );

          return;
        }
      }
    }

    _optionQuantityMap[option.index] = value ? 1 : 0;
    setState(() {});
  }

  _save() {
    Navigator.of(context).pop();
  }
}
