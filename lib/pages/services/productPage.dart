import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
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
  Map<int, int> _selectedOption;

  List<ProductOptionModel> _required;
  List<ProductOptionModel> _optional;

  int get totalAmount {
    return amount * _quantity;
  }

  int get amount {
    return widget.product.price + optionAmount;
  }

  int get optionAmount {
    var optionPrice = 0;
    final options = [...widget.product.options];
    options.addAll([...widget.product.options].expand((e) => e.options));

    _selectedOption.forEach((key, value) {
      if (value >= 1) {
        optionPrice +=
            options.singleWhere((element) => element.index == key).price *
                value;
      }
    });
    return optionPrice;
  }

  @override
  void initState() {
    super.initState();

    _quantity = 1;
    _optionMap = Map();
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
      _selectedOption[option.index] = 0;

      if ((option.options?.length ?? 0) > 0) {
        _initOptionsQuantity(option.options);
      }
    });
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
            flex: 8,
            child: Hero(
              tag: widget.product.index,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      margin: EdgeInsets.only(bottom: 10),
                      child: _productHeader(),
                    ),
                    _productSlider(),
                    Expanded(
                      flex: 8,
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 24),
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
                    ),
                    _saveButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
            Text('수량'),
            Spacer(),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _countCalc(true),
                  Container(
                    width: 60,
                    child: Text(
                      '$_quantity',
                      textAlign: TextAlign.center,
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
        child: Material(
          color: Theme.of(context).accentColor,
          child: InkWell(
            onTap: () {
              _save();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 34),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    '장바구니 담기',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Positioned(
                    right: 0,
                    child: Text(
                      '${NumberFormat().format(totalAmount)}원',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  _optionCard() => ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          _optional.length,
          (index) => Container(
            margin: EdgeInsets.only(bottom: 10),
            child: _option(option: _optional[index], depth: 1),
          ),
        ),
      );

  _productSlider() => Expanded(
        flex: 5,
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              viewportFraction: 0.5,
            ),
            items: [
              ...[
                widget.product.image,
                widget.product.image,
                widget.product.image
              ].map(
                (item) => AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  _titleCard() => Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).accentColor,
              height: 10,
              thickness: .5,
            ),
            Container(height: 16),
            Column(
              children: _required.length > 0
                  ? List.generate(
                      _required.length,
                      (index) => _option(
                        option: _required[index],
                        depth: 1,
                      ),
                    )
                  : [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
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
        padding:
            depth == 1 ? EdgeInsets.symmetric(vertical: 24) : EdgeInsets.zero,
        margin:
            depth > 1 ? EdgeInsets.only(top: 16) : EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                ),
                child: FractionallySizedBox(
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
                                    height: 20,
                                    margin: EdgeInsets.only(right: 5),
                                    child: Radio(
                                      value: 1,
                                      groupValue: _selectedOption[option.index],
                                      toggleable: true,
                                      onChanged: (val) {
                                        _selectedOption[option.index] =
                                            val == 1 ? val : 0;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  Text(
                                    option.name,
                                  ),
                                ]
                              : [
                                  Text(
                                    option.name,
                                    style: TextStyle(
                                      fontSize: 21,
                                    ),
                                  ),
                                ],
                        ),
                      ),
                      ...((option.max ?? 0) > 0)
                          ? [
                              Text(
                                '(최대${option.max}개)',
                              ),
                            ]
                          : [],
                      Spacer(),
                      Container(
                        child: option.price > 0
                            ? Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '+${NumberFormat().format(option.price)}원',
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: (option.options?.length ?? 0) > 0
                  ? Divider(
                      color: Theme.of(context).accentColor,
                      height: 10,
                      thickness: .5,
                    )
                  : Container(),
            ),
            ...(option.options?.length ?? 0) > 0
                ? option.options
                    .map((sub) => _option(option: sub, depth: depth + 1))
                : [],
          ],
        ),
      );

  _save() {
    final result = CartItemModel(
      name: widget.product.name,
      amount: amount,
      optionAmount: optionAmount,
      optionQuantity: _selectedOption,
      quantity: _quantity,
      product: widget.product,
    );
    Navigator.of(context).pop(result);
  }
}
