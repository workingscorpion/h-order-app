import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/models/cartItemModel.dart';
import 'package:h_order/models/itemModel.dart';
import 'package:h_order/models/productOptionModel.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  final ServiceModel service;
  final ItemModel category;
  final ItemModel product;

  ProductPage({
    this.service,
    this.category,
    this.product,
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  int _quantity;
  Map<String, ItemModel> _optionMap;
  Map<String, int> _selectedOption;

  List<ItemModel> _required;
  List<ItemModel> _optional;

  int get totalAmount {
    return amount * _quantity;
  }

  int get amount {
    return widget.product.price + optionAmount;
  }

  int get optionAmount {
    var optionPrice = 0;
    final options = [...widget.product.items];
    options.addAll([...widget.product.items].expand((e) => e.items));

    _selectedOption.forEach((key, value) {
      if (value >= 1) {
        optionPrice +=
            options.singleWhere((element) => element.objectId == key).price *
                value;
      }
    });
    return optionPrice;
  }

  List<ItemModel> get images {
    return widget.product.items.where((item) => item.type == 'Image').toList();
  }

  @override
  void initState() {
    super.initState();

    _quantity = 1;
    _optionMap = Map();
    _selectedOption = Map();

    _initOptionsQuantity(widget.product.items);

    _required = widget.product.items
        // .where((element) => (element.isRequired ?? false))
        .toList();

    _optional = widget.product.items
        // .where((element) => !(element.isRequired ?? false))
        .toList();
  }

  _initOptionsQuantity(List<ItemModel> options) {
    options.forEach((option) {
      _optionMap[option.objectId] = option;
      _selectedOption[option.objectId] = 0;

      if ((option.items?.length ?? 0) > 0) {
        _initOptionsQuantity(option.items);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PageHeader(
                    title: [widget.service.name, widget.category.value],
                    canBack: true,
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
                          _card(
                            child: _title(),
                          ),
                          ...List.generate(
                            _optional.length,
                            (index) => _card(
                              child: _option(option: _optional[index]),
                            ),
                          ),
                          _card(
                            child: _productCount(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _saveButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _card({
    Widget child,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 24,
        ),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      );

  _productCount() => Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '수량',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
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

  _countCalc(bool left) => Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: left && _quantity <= 0
              ? CustomColors.aWhite
              : CustomColors.subTextBlack,
          borderRadius: left
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
            if (left) {
              _quantity -= 1;

              if (_quantity < 1) {
                _quantity = 1;
              }
            } else {
              _quantity += 1;
            }
            setState(() {});
          },
          icon: Icon(
            left ? CupertinoIcons.minus : CupertinoIcons.plus,
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

  _productSlider() => Expanded(
        flex: 5,
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              viewportFraction: 0.5,
            ),
            items: [
              ...(images?.isNotEmpty ?? false)
                  ? images
                      .asMap()
                      .map(
                        (index, item) => MapEntry(
                          index,
                          index == 0
                              ? Hero(
                                  tag: widget.product.objectId,
                                  child: _productSliderItem(image: item.value),
                                )
                              : _productSliderItem(image: item.value),
                        ),
                      )
                      .values
                  : [],
            ],
          ),
        ),
      );

  _productSliderItem({
    String image,
  }) =>
      AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      );

  _title() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                widget.product.value,
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Divider(
                color: Theme.of(context).accentColor,
                height: 10,
                thickness: .5,
              ),
            ),
            Column(
              children: _required.length > 0
                  ? List.generate(
                      _required.length * 2 - 1,
                      (index) => index % 2 == 0
                          ? _option(option: _required[(index / 2).floor()])
                          : Container(height: 16),
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
                              value: null,
                              groupValue: null,
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
    ItemModel option,
  }) =>
      Container(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Container(
                child: FractionallySizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Row(
                          children: (option.items?.length ?? -1) == 0
                              ? [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.only(right: 5),
                                    child: Radio(
                                      value: 1,
                                      groupValue:
                                          _selectedOption[option.objectId],
                                      // toggleable: (option.multiple ?? false),
                                      // onChanged: (value) {
                                      //   if ((option.multiple ?? false)) {
                                      //     _selectedOption[option.objectId] =
                                      //         _selectedOption[
                                      //                     option.objectId] ==
                                      //                 1
                                      //             ? 0
                                      //             : 1;
                                      //   } else {
                                      //     if (option.isRequired ?? false) {
                                      //       widget.product.options
                                      //           .where((item) =>
                                      //               (item.isRequired ?? false))
                                      //           .forEach((item) {
                                      //         _selectedOption[item.objectId] =
                                      //             0;
                                      //       });
                                      //     } else {
                                      //       _optionMap[option.parentObjectId]
                                      //           .options
                                      //           .forEach((item) {
                                      //         _selectedOption[item.objectId] =
                                      //             0;
                                      //       });
                                      //     }

                                      //     _selectedOption[option.objectId] = 1;
                                      //   }
                                      //   setState(() {});
                                      // },
                                    ),
                                  ),
                                  Text(
                                    option.value,
                                  ),
                                ]
                              : [
                                  Text(
                                    option.value,
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
                        child: (option.price ?? 0) > 0
                            ? Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${NumberFormat().format(option.price)}원',
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // (option.options?.length ?? 0) > 0
            //     ? Container(
            //         margin: EdgeInsets.only(bottom: 16),
            //         child: Divider(
            //           color: Theme.of(context).accentColor,
            //           height: 10,
            //           thickness: .5,
            //         ),
            //       )
            //     : Container(),
            // ...(option.options?.length ?? 0) > 0
            //     ? List.generate(
            //         option.options.length * 2 - 1,
            //         (index) => index % 2 == 0
            //             ? _option(option: option.options[(index / 2).floor()])
            //             : Container(height: 16),
            //       )
            //     : [],
          ],
        ),
      );

  _save() async {
    final requiredOptions = widget.product.items;
    // .where((item) => item.isRequired ?? false);
    if (requiredOptions.length > 0) {
      if (!requiredOptions.any((item) => _selectedOption[item.objectId] > 0)) {
        await Fluttertoast.cancel();
        await Fluttertoast.showToast(
          msg: '필수옵션을 선택해주세요.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.66),
          textColor: Theme.of(context).textTheme.bodyText1.color,
          fontSize: 17,
        );

        return;
      }
    }

    final result = CartItemModel(
      name: widget.product.value,
      amount: amount,
      optionAmount: optionAmount,
      optionQuantity: _selectedOption,
      quantity: _quantity,
      product: widget.product,
    );

    Navigator.of(context).pop(result);

    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: '선택하신 상품이 장바구니에 추가되었습니다.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Theme.of(context).accentColor.withOpacity(0.66),
      textColor: Theme.of(context).textTheme.bodyText1.color,
      fontSize: 17,
    );
  }
}
