import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/statusBar.dart';
import 'package:h_order/models/cartItemModel.dart';
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

  int get totalAmount {
    return _quantity * amount;
  }

  int get amount {
    return widget.product.price + optionAmount;
  }

  int get optionAmount {
    return _optionQuantityMap.entries.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.value * (_optionMap[element.key]?.price ?? 0));
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
      body: Container(
        child: Column(
          children: [
            StatusBar(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: _productHeader(),
                    ),
                    _productSlider(),
                    Expanded(
                      child: _title(),
                    ),
                    Divider(
                      color: Theme.of(context).accentColor,
                      height: 5,
                      thickness: 1,
                    ),
                    _productOptions(),
                    _saveButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveButton() => Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                _save();
              },
              color: Theme.of(context).accentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    '장바구니 담기',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${NumberFormat().format(totalAmount)}원',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              )),
        ),
      );

  _productOptions() => Expanded(
        flex: 8,
        child: ListView(
          children: [
            ...widget.product.options
                    ?.expand((option) => _option(option: option)) ??
                [],
          ],
        ),
      );

  _productSlider() => Expanded(
      flex: 5,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: CarouselSlider(
          items: _productImages([
            widget.product.image,
            widget.product.image,
            widget.product.image
          ]),
          options: CarouselOptions(
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            viewportFraction: 0.6,
          ),
        ),
      ));

  _productImages(List<String> images) => List.generate(
        images.length,
        (index) => AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              widget.product.image,
              fit: BoxFit.fill,
            ),
          ),
        ),
      );

  _productHeader() => Row(
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
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    '목록보기',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Icon(
                  CupertinoIcons.chevron_right_2,
                  color: Theme.of(context).textTheme.bodyText2.color,
                ),
              ],
            ),
          )
        ],
      );

  _title() => Material(
        color: Colors.transparent,
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.white10,
              ),
            ),
            color: Theme.of(context).primaryColor,
          ),
          child: FractionallySizedBox(
            heightFactor: .6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(),
                ),
                // Container(
                //   alignment: Alignment.centerRight,
                //   margin: EdgeInsets.only(right: 12),
                //   child: Text(
                //     '${NumberFormat().format(amount)} ₩',
                //     style: TextStyle(),
                //   ),
                // ),
                // AspectRatio(
                //   aspectRatio: 1,
                //   child: IconButton(
                //     iconSize: 16,
                //     padding: EdgeInsets.zero,
                //     onPressed: () {
                //       _quantity -= 1;
                //       if (_quantity < minQuantity) {
                //         _quantity = minQuantity;
                //       }
                //       setState(() {});
                //     },
                //     icon: Icon(
                //       CupertinoIcons.minus,
                //       size: 16,
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 5),
                //   child: Text(
                //     '$_quantity',
                //     style: TextStyle(),
                //   ),
                // ),
                // AspectRatio(
                //   aspectRatio: 1,
                //   child: IconButton(
                //     iconSize: 16,
                //     padding: EdgeInsets.zero,
                //     onPressed: () {
                //       _quantity = _quantity + 1;
                //       setState(() {});
                //     },
                //     icon: FractionallySizedBox(
                //       widthFactor: .5,
                //       heightFactor: .5,
                //       child: Icon(
                //         CupertinoIcons.add,
                //         size: 16,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
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
                        width: 1,
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
              height: MediaQuery.of(context).size.height / 20,
              padding: EdgeInsets.only(
                left: 12 +
                    MediaQuery.of(context).size.height / 20 / 3 * (depth - 1),
                right: 12,
              ),
              color: Theme.of(context).primaryColor,
              child: FractionallySizedBox(
                heightFactor: .6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Text(
                        option.name,
                        style: TextStyle(),
                      ),
                    ),
                    ...((option.max ?? 0) > 0)
                        ? [
                            Text(
                              '(최대${option.max}개)',
                              style: TextStyle(
                                color: Colors.white38,
                              ),
                            ),
                          ]
                        : [],
                    Expanded(
                      child: Container(),
                    ),
                    ...(option.options?.length ?? 0) == 0
                        ? [
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 12),
                              child: Text(
                                '${NumberFormat().format(option.price)} ₩',
                                style: TextStyle(),
                              ),
                            ),
                          ]
                        : [],
                    ...(option.options?.length ?? 0) == 0
                        ? option.multiple
                            ? [
                                Container(
                                  width: 16,
                                  child: IconButton(
                                    iconSize: 16,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      _optionQuantityMap[option.index] -= 1;
                                      if (_optionQuantityMap[option.index] <
                                          0) {
                                        _optionQuantityMap[option.index] = 0;
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
                                  margin: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    '${_optionQuantityMap[option.index]}',
                                    style: TextStyle(),
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
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      final checked =
                                          _optionQuantityMap[option.index] == 1;

                                      _changeSelect(
                                        option: option,
                                        value: checked,
                                      );
                                    },
                                    icon: Container(
                                      child:
                                          _optionQuantityMap[option.index] == 1
                                              ? Icon(CupertinoIcons.check_mark)
                                              : Container(),
                                    ),
                                  ),
                                ),
                              ]
                        : [],
                  ],
                ),
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
        final count = parent.options
            .where((element) => _optionQuantityMap[element.index] == 1)
            .length;

        if (parent.max <= count) {
          await Fluttertoast.cancel();
          await Fluttertoast.showToast(
            msg: '옵션 최대개수를 초과하여 선택 할 수 없습니다. (최대 ${parent.max}개)',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );

          return;
        }
      }
    }

    _optionQuantityMap[option.index] = value ? 1 : 0;
    setState(() {});
  }

  _save() {
    final result = CartItemModel(
      name: widget.product.name,
      amount: amount,
      optionAmount: optionAmount,
      optionQuantity: _optionQuantityMap,
      quantity: _quantity,
      product: widget.product,
    );

    Navigator.of(context).pop(result);
  }
}
