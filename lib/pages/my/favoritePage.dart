import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/components/serviceButton.dart';
import 'package:h_order/constants/sampleData.dart';
import 'package:h_order/models/serviceModel.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<ServiceModel> list;
  List<ServiceModel> favoriteList;

  @override
  void initState() {
    super.initState();

    list = SampleData.services();
    favoriteList = List();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                PageHeader(
                  title: ['즐겨찾기'],
                  canBack: true,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _title(
                        text: '전체 서비스',
                      ),
                      Expanded(
                        flex: 2,
                        child: DragAndDropGridView(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 1,
                          ),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return ServiceButton(
                              service: list[index],
                              color: favoriteList.indexOf(list[index]) != -1
                                  ? Color(0xfff7b500)
                                  : Colors.black,
                              onTap: () {
                                final item = list[index];
                                if (favoriteList.indexOf(item) != -1) {
                                  favoriteList.remove(item);
                                } else {
                                  favoriteList.add(item);
                                }

                                setState(() {});
                              },
                            );
                          },
                          onWillAccept: (oldIndex, newIndex) {
                            return true;
                          },
                          onReorder: (oldIndex, newIndex) {
                            final temp = list[newIndex];
                            list[newIndex] = list[oldIndex];
                            list[oldIndex] = temp;

                            setState(() {});
                          },
                        ),
                      ),
                      _title(
                        text: '잠금화면 즐겨찾기',
                      ),
                      Expanded(
                        flex: 1,
                        child: DragAndDropGridView(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 1,
                          ),
                          itemCount: favoriteList.length,
                          itemBuilder: (context, index) => ServiceButton(
                            service: favoriteList[index],
                            onTap: () {},
                          ),
                          onWillAccept: (oldIndex, newIndex) {
                            return true;
                          },
                          onReorder: (oldIndex, newIndex) {
                            final temp = favoriteList[newIndex];
                            favoriteList[newIndex] = favoriteList[oldIndex];
                            favoriteList[oldIndex] = temp;

                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  _title({
    String text,
  }) =>
      Container(
        padding: EdgeInsets.all(24),
        child: Text(text),
      );
}

class MenuModel {
  final IconData icon;
  final String name;

  MenuModel({
    this.icon,
    this.name,
  });
}
