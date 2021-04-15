import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/components/serviceButton.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<MenuModel> list;
  List<MenuModel> favoriteList;

  @override
  void initState() {
    super.initState();

    list = [
      MenuModel(
        icon: CupertinoIcons.hammer,
        name: '시설보수',
      ),
      MenuModel(
        icon: CupertinoIcons.sparkles,
        name: '청소',
      ),
      MenuModel(
        icon: CupertinoIcons.tornado,
        name: '세탁',
      ),
      MenuModel(
        icon: CupertinoIcons.car_detailed,
        name: '출차',
      ),
      MenuModel(
        icon: CupertinoIcons.exclamationmark_bubble,
        name: '관리실호출',
      ),
      MenuModel(
        icon: CupertinoIcons.tag,
        name: '딜리버리',
      ),
      MenuModel(
        icon: CupertinoIcons.paw,
        name: '펫케어',
      ),
      MenuModel(
        icon: CupertinoIcons.cube_box,
        name: '택배',
      ),
      MenuModel(
        icon: CupertinoIcons.arrow_3_trianglepath,
        name: '분리수거',
      ),
      MenuModel(
        icon: CupertinoIcons.trash,
        name: '종량제봉투',
      ),
      MenuModel(
        icon: CupertinoIcons.paintbrush,
        name: '인테리어',
      ),
      MenuModel(
        icon: CupertinoIcons.archivebox,
        name: '이사',
      ),
    ].toList();

    favoriteList = List();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                PageHeader(
                  title: '즐겨찾기',
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
                              icon: list[index].icon,
                              label: list[index].name,
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
                            icon: favoriteList[index].icon,
                            label: favoriteList[index].name,
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

  _serviceItem({
    IconData icon,
    String text,
    GestureTapCallback onTap,
  }) =>
      Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Icon(
                  icon,
                  size: 64,
                ),
              ),
              Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
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
