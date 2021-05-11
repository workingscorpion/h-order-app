import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/models/cartItemModel.dart';
import 'package:h_order/models/itemModel.dart';
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
  Map<String, int> _selectedOptions;
  Map<String, String> _radioMap;

  int get totalAmount {
    return amount * _quantity;
  }

  int get amount {
    return widget.product.price + optionAmount;
  }

  int get optionAmount {
    var optionPrice = 0;

    _selectedOptions.forEach((key, value) {
      if (value >= 1) {
        final price = _optionMap[key]?.price ?? 0;
        optionPrice += price * value;
      }
    });

    return optionPrice;
  }

  List<ItemModel> get images {
    return widget.product.items.where((item) => item.type == 'Image').toList();
  }

  List<ItemModel> get options {
    return widget.product.items
        .where((item) => item.type == 'ProductOption' || item.type == 'Group')
        .toList();
  }

  List<ItemModel> get requiredOptions {
    return options
        .where(
            (item) => item.getTagMetadata('selectionType', 'value') == 'Single')
        .toList();
  }

  @override
  void initState() {
    super.initState();

    _quantity = 1;
    _optionMap = Map();
    _selectedOptions = Map();
    _radioMap = Map();

    _initOptionsQuantity(options);
  }

  _initOptionsQuantity(List<ItemModel> items) {
    items.forEach((option) {
      if (option.type == 'Group') {
        if (option.items?.isNotEmpty ?? false) {
          _initOptionsQuantity(option.items);
        }

        _radioMap[option.objectId] = null;
      } else {
        _optionMap[option.objectId] = option;
        _selectedOptions[option.objectId] = 0;
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
                  _images(),
                  _body(),
                  _saveButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _body() => Expanded(
        flex: 8,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
          child: ListView(
            padding: EdgeInsets.all(24),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              _card(
                child: _title(),
              ),
              ...(options?.isNotEmpty ?? false)
                  ? options.map(
                      (item) => _card(
                        child: _option(
                          option: item,
                        ),
                      ),
                    )
                  : [],
              _card(
                child: _productCount(),
              ),
            ],
          ),
        ),
      );

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
            Text('${NumberFormat().format(amount)}원'),
            _countCalc(),
          ],
        ),
      );

  _countCalc({
    String key,
  }) {
    final value = key == null ? _quantity : _selectedOptions[key];

    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _countCalcButton(
            key: key,
            subtract: true,
          ),
          Container(
            width: 60,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.center,
          ),
          _countCalcButton(
            key: key,
            subtract: false,
          ),
        ],
      ),
    );
  }

  _countCalcButton({
    String key,
    bool subtract,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: subtract && _quantity <= 0
            ? CustomColors.aWhite
            : CustomColors.subTextBlack,
        borderRadius: subtract
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
          if (key?.isEmpty ?? true) {
            if (subtract) {
              _quantity -= 1;

              if (_quantity < 1) {
                _quantity = 1;
              }
            } else {
              _quantity += 1;
            }
          } else {
            if (subtract) {
              _selectedOptions[key] -= 1;

              if (_selectedOptions[key] < 0) {
                _selectedOptions[key] = 0;
              }
            } else {
              _selectedOptions[key] += 1;
            }
          }

          setState(() {});
        },
        icon: Icon(
          subtract ? CupertinoIcons.minus : CupertinoIcons.plus,
          size: 20,
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );
  }

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

  _images() => Expanded(
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
          ],
        ),
      );

  _option({
    ItemModel option,
  }) {
    final child = option.type == 'Group'
        ? _optionGroup(option: option)
        : _optionItem(option: option);

    return child;
  }

  _optionGroup({
    ItemModel option,
  }) {
    final children = option?.items
            ?.where((item) => item.type == 'ProductOption')
            ?.toList() ??
        [];
    final selectionType = option.getTagMetadata('selectionType', 'value');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              option.value,
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            Spacer(),
            selectionType == 'Single'
                ? Text(
                    '필수선택',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                : Container(),
          ],
        ),
        Divider(
          height: 10,
          thickness: .5,
          color: Theme.of(context).accentColor,
        ),
        Column(
          children: [
            ...(children?.isNotEmpty ?? false)
                ? List.generate(
                    children.length * 2,
                    (index) {
                      if (index % 2 == 0) {
                        return Container(height: 10);
                      }

                      final item = children[(index / 2).floor()];

                      return _optionItem(
                        group: option,
                        option: item,
                        selectionType: selectionType,
                      );
                    },
                  )
                : [],
          ],
        ),
      ],
    );
  }

  _optionItem({
    ItemModel group,
    ItemModel option,
    String selectionType,
  }) {
    var children = <Widget>[
      Text(option.value),
      Spacer(),
      Text('${NumberFormat().format(option?.price ?? 0)} 원'),
    ];

    switch (selectionType) {
      case 'Single':
        children = [
          Container(
            width: 40,
            height: 40,
            child: IgnorePointer(
              child: Radio(
                groupValue: _radioMap[group.objectId],
                value: option.objectId,
                onChanged: (value) {},
                activeColor: Colors.black,
              ),
            ),
          ),
          ...children,
        ];
        break;

      case 'Multi':
        children = [
          Container(
            width: 40,
            height: 40,
            child: IgnorePointer(
              child: Checkbox(
                value: _selectedOptions[option.objectId] == 1,
                onChanged: (value) {},
              ),
            ),
          ),
          ...children,
        ];
        break;

      case 'Number':
        children = [
          Container(
            width: 40,
            height: 40,
          ),
          ...children,
          _countCalc(key: option.objectId),
        ];
        break;

      default:
        children = [
          ...children,
          _countCalc(key: option.objectId),
        ];
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          switch (selectionType) {
            case 'Single':
              group.items.forEach((item) {
                _selectedOptions[item.objectId] =
                    item.objectId == option.objectId ? 1 : 0;
              });
              _radioMap[group.objectId] = option.objectId;
              break;

            case 'Multi':
              _selectedOptions[option.objectId] =
                  _selectedOptions[option.objectId] != 1 ? 1 : 0;
              break;
          }

          setState(() {});
        },
        child: Container(
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
            child: Row(
              children: [
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }

  _save() async {
    if (requiredOptions?.isNotEmpty ?? false) {
      if (!requiredOptions.every((item) =>
          item.items.any((child) => _selectedOptions[child.objectId] > 0))) {
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
      product: widget.product,
      optionAmount: optionAmount,
      optionQuantity: _selectedOptions,
      quantity: _quantity,
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
