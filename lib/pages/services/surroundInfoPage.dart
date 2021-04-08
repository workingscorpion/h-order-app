import 'package:carousel_slider/carousel_slider.dart';
import 'package:h_order/models/categoryModel.dart';
import 'package:flutter/material.dart';

class SurroundInfoPage extends StatefulWidget {
  SurroundInfoPage({Key key}) : super(key: key);

  @override
  _SurroundInfoPageState createState() => _SurroundInfoPageState();
}

class _SurroundInfoPageState extends State<SurroundInfoPage>
    with SingleTickerProviderStateMixin {
  GlobalKey _appBarKey;
  TabController _tabController;

  List<CategoryModel> _categories;
  List<String> _images;

  @override
  void initState() {
    super.initState();
    _appBarKey = GlobalKey();

    _categories = List.generate(5, (i) {
      return CategoryModel(
        index: i,
        name: 'Category ${i + 1}',
      );
    });

    _images = [
      'assets/sample/1.jpg',
      'assets/sample/2.jpg',
      'assets/sample/3.jpg',
      'assets/sample/4.jpg',
      'assets/sample/5.jpg',
      'assets/sample/6.jpg',
      'assets/sample/7.jpg',
    ];

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
        title: Text('주변 정보'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: [
              ..._categories.map(
                (item) => Container(
                  child: Text(
                    item.name,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ..._categories.map((item) => CarouselSlider(
                      options: CarouselOptions(height: 1500),
                      items: _images.map((i) {
                        // FIXME: 이미지 수정후 상황에 따라 fit 수정
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Image.asset(
                            i,
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      }).toList(),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
