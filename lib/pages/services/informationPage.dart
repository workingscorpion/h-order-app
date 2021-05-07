import 'package:carousel_slider/carousel_slider.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/models/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:h_order/models/itemModel.dart';

class InformationPage extends StatefulWidget {
  final ServiceModel service;

  InformationPage({
    Key key,
    this.service,
  }) : super(key: key);

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage>
    with SingleTickerProviderStateMixin {
  GlobalKey _appBarKey;
  TabController _tabController;

  List<ItemModel> _categories;

  @override
  void initState() {
    super.initState();
    _appBarKey = GlobalKey();

    _categories = widget.service.items.where((item) => item.type == 'Group');

    _tabController = TabController(
      length: _categories.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _appBarKey,
        title: Text('정보'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          _body(),
        ],
      ),
    );
  }

  _header() => (_categories?.isNotEmpty ?? false)
      ? TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            ..._categories.map(
              (item) => Container(
                child: Text(
                  item.value,
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ],
        )
      : Container();

  _body() => Expanded(
        child: TabBarView(
          controller: _tabController,
          children: [
            ..._categories.map((category) => _carousel(category)),
          ],
        ),
      );

  _carousel(ItemModel category) => LayoutBuilder(
        builder: (context, constraint) => CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            height: constraint.maxHeight,
          ),
          items: [
            ...category.items
                .where((child) => child.type == 'Image')
                .map((child) => _image(child)),
          ],
        ),
      );

  _image(ItemModel item) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Image.asset(
          item.value,
          fit: BoxFit.fitHeight,
        ),
      );
}
