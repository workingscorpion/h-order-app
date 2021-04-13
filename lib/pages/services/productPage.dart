import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/statusBar.dart';
import 'package:h_order/constants/customColors.dart';
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
  Map<int, bool> _selectedOption;

  List<ProductOptionModel> _required;
  List<ProductOptionModel> _optional;

  int get totalAmount {
    var optionPrice = 0;
    final options = [...widget.product.options];
    options.addAll([...widget.product.options].expand((e) => e.options));

    _selectedOption.forEach((key, value) {
      if (value) {
        optionPrice +=
            options.singleWhere((element) => element.index == key).price;
      }
    });
    return (amount + optionPrice) * _quantity;
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
    _selectedOption = Map();

    _initOptionsQuantity(widget.product.options);
    _filter();
  }

  _filter() {
    _required =
        widget.product.options.where((element) => element.isRequired).toList();
    _optional =
        widget.product.options.where((element) => !element.isRequired).toList();
  }

  _initOptionsQuantity(List<ProductOptionModel> options) {
    options.forEach((option) {
      _optionMap[option.index] = option;
      _optionQuantityMap[option.index] = 0;
      _selectedOption[option.index] = false;

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
                      flex: 8,
                      child: ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          Flex(
                            direction: Axis.vertical,
                            children: [
                              _titleCard(),
                            ],
                          ),
                          _optionCard(),
                          _productCount(),
                        ],
                      ),
                    ),
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

  _productCount() => Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('수량', style: Theme.of(context).textTheme.bodyText2),
            Spacer(),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _countCalc(true),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '$_quantity',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                    alignment: Alignment.center,
                  ),
                  _countCalc(false),
                ],
              ),
            ),
          ],
        ),
      );

  _countCalc(bool isLeft) => Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: isLeft && _quantity <= 0
              ? CustomColors.aWhite
              : CustomColors.subTextBlack,
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
              if (_quantity > 0) {
                _quantity--;
              }
            } else {
              _quantity++;
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

  _saveButton() => Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          margin: EdgeInsets.only(top: 20),
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

  _optionCard() => ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          _optional.length,
          (index) => _option(option: _optional[index], depth: 1),
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
        ),
      );

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

  _titleCard() => Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                widget.product.name,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Divider(
              color: Theme.of(context).accentColor,
              height: 5,
              thickness: 1,
            ),
            Column(
              children: _required.length > 0
                  ? List.generate(
                      _required.length,
                      (index) => _option(option: _required[index], depth: 1),
                    )
                  : [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            margin: EdgeInsets.only(right: 5),
                            child: Radio(
                              onChanged: (value) {},
                            ),
                          ),
                          Text('기본'),
                          Spacer(),
                          Text(
                              '${NumberFormat().format(widget.product.price)}원')
                        ],
                      ),
                    ],
            ),
          ],
        ),
      );

  _option({
    ProductOptionModel option,
    double depth = 1,
  }) =>
      Container(
        margin: depth <= 1 ? EdgeInsets.only(bottom: 10) : null,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 20,
              padding: EdgeInsets.only(
                left: 20 +
                    MediaQuery.of(context).size.height / 20 / 3 * (depth - 1),
                right: 20,
              ),
              child: FractionallySizedBox(
                heightFactor: .6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Row(
                          children: depth > 1 ||
                                  (option.options?.length ?? -1) == 0
                              ? [
                                  Container(
                                    width: 20,
                                    margin: EdgeInsets.only(right: 5),
                                    child: Radio(
                                      value: true,
                                      groupValue: _selectedOption[option.index],
                                      toggleable: true,
                                      onChanged: (val) {
                                        _selectedOption[option.index] = val;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  Text(
                                    option.name,
                                    style: TextStyle(),
                                  ),
                                ]
                              : [
                                  Text(
                                    option.name,
                                    style: TextStyle(),
                                  ),
                                ],
                        )),
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
                    Spacer(),
                    Container(
                      child: option.price > 0
                          ? Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 12),
                              child: Text(
                                '+${NumberFormat().format(option.price)}원',
                                style: TextStyle(),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: (option.options?.length ?? 0) > 0
                  ? Divider(
                      color: Theme.of(context).accentColor,
                      height: 5,
                      thickness: 1,
                    )
                  : null,
            ),
            ...(option.options?.length ?? 0) > 0
                ? option.options
                    .map((sub) => _option(option: sub, depth: depth + 1))
                : [],
          ],
        ),
      );

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
