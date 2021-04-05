import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';

class HomeView extends StatefulWidget {
  HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _menu(),
          Container(height: 24),
          _cards(),
          Container(height: 24),
          _carousel(),
        ],
      );

  _menu() => Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Material(
            color: Colors.transparent,
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 5,
              children: [
                ...[
                  _serviceItem(
                    icon: CupertinoIcons.hammer,
                    text: '시설보수',
                    onTap: () {
                      _alert(
                        title: '시설보수',
                        content: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.sparkles,
                    text: '청소',
                    onTap: () {
                      _alert(
                        title: '청소',
                        content: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.tornado,
                    text: '세탁',
                    onTap: () {
                      _alert(
                        title: '세탁',
                        content: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.car_detailed,
                    text: '출차',
                    onTap: () {
                      _alert(
                        title: '출차',
                        content: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.exclamationmark_bubble,
                    text: '관리실 호출',
                    onTap: () {
                      _alert(
                        title: '관리실 호출',
                        content: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      );
                    },
                  ),
                ],
                ...[
                  _serviceItem(
                    icon: CupertinoIcons.tag,
                    text: '딜리버리',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.paw,
                    text: '팻케어',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.cube_box,
                    text: '택배',
                    onTap: () {
                      _alert(
                        title: '택배',
                        content: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.arrow_3_trianglepath,
                    text: '분리수거',
                    onTap: () {
                      _alert(
                        title: '분리수거',
                        content: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.trash,
                    text: '종량제봉투',
                    onTap: () {
                      _alert(
                        title: '종량제봉투',
                        content: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      );
                    },
                  ),
                ],
                ...[
                  _serviceItem(
                    icon: CupertinoIcons.paintbrush,
                    text: '인테리어',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.archivebox,
                    text: '이사',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      );

  _cards() => Expanded(
        flex: 1,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Text(
                  '제휴 서비스',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(
                      10,
                      (index) => Container(
                        margin: EdgeInsets.only(right: 12),
                        child: AspectRatio(
                          aspectRatio: 1 / 1.413,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text('제휴 서비스 $index'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  _carousel() => Expanded(
        flex: 1,
        child: LayoutBuilder(
          builder: (context, constraint) => CarouselSlider(
            items: [
              ...[1, 2, 3, 4, 5, 6].map(
                (item) => Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/splash/splash.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: constraint.maxHeight,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 10),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
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

  _alert({
    String title,
    String content,
  }) async {
    await showDialog(
      context: context,
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        title: Container(
          padding: EdgeInsets.all(24),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        content: IntrinsicHeight(
          child: Column(
            children: [
              Divider(),
              Container(
                padding: EdgeInsets.all(100),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '취소',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 24,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.white,
                      child: Text(
                        '호출',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        ),
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
  }
}
