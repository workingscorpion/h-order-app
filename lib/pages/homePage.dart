import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/clock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();

  static showNotice(BuildContext context, bool checkOpen) async {
    if (checkOpen) {
      final sp = await SharedPreferences.getInstance();
      final lastPopup = sp.getString('lastPopup');

      if (lastPopup != null && lastPopup.isNotEmpty) {
        final date = DateTime.parse(lastPopup);
        if (date.isBefore(DateTime.now())) {
          return;
        }
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        content: Container(
          child: Image.asset(
            "assets/notice.png",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final sp = await SharedPreferences.getInstance();
              sp.setString('lastPopup', DateTime.now().toString());
              Navigator.of(context).pop();
            },
            child: Text(
              '그만보기',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: Text(
              '닫기',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<InnerDrawerState> innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  DateTime currentBackPressTime;
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    currentBackPressTime = null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            WillPopScope(
              onWillPop: _onWillPop,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _status(),
                    _info(),
                    _menu(),
                    _carousel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  _serviceItem({
    IconData icon,
    String text,
    GestureTapCallback onTap,
  }) =>
      Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Icon(
                  icon,
                  size: 28,
                ),
              ),
              Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );

  Future<bool> _onWillPop() async {
    try {
      final now = DateTime.now();

      if (currentBackPressTime != null &&
          now.difference(currentBackPressTime) <= Duration(seconds: 2)) {
        return true;
      }

      currentBackPressTime = now;

      await Fluttertoast.showToast(
        msg: '뒤로가기를 한 번 더 누르면 종료 됩니다.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        fontSize: 14.0,
      );

      return false;
    } catch (ex) {
      return false;
    }
  }

  _status() => Container(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Clock(),
            ),
            Text(
              '진주오피스텔 A동 102호',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white24,
              ),
            ),
          ],
        ),
      );

  _info() => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Text(
                    '202호',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '2월분 납부완료',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                '서울특별시 구로구 구로동 3-25, 신도림 커먼타운 (우: 12345)',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: .5,
                    color: Colors.white10,
                  ),
                ),
              ),
            ),
            Container(
              height: 26,
              child: Row(
                children: [
                  _infoButton(
                    onPressed: () {},
                    text: '빌라정보',
                  ),
                  Container(
                    width: 6,
                  ),
                  _infoButton(
                    onPressed: () {},
                    text: '신청내역',
                  ),
                  Container(
                    width: 6,
                  ),
                  _infoButton(
                    onPressed: () {},
                    text: '관리비내역',
                  ),
                  Container(
                    width: 6,
                  ),
                  _infoButton(
                    onPressed: () {},
                    text: '마이페이지',
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _infoButton({
    VoidCallback onPressed,
    String text,
  }) =>
      Expanded(
        child: OutlineButton(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white54,
          ),
          highlightedBorderColor: Colors.blueGrey,
          textColor: Colors.white,
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ),
      );

  _carousel() => CarouselSlider(
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
          height: 180,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 10),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      );

  _menu() => Expanded(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Material(
            color: Colors.transparent,
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              children: [
                ...[
                  _serviceItem(
                    icon: CupertinoIcons.hammer,
                    text: '시설보수',
                    onTap: () {},
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.sparkles,
                    text: '청소',
                    onTap: () {},
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.tornado,
                    text: '세탁',
                    onTap: () {},
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.car_detailed,
                    text: '출차',
                    onTap: () {},
                  ),
                ],
                ...[
                  _serviceItem(
                    icon: CupertinoIcons.exclamationmark_bubble,
                    text: '관리실호출',
                    onTap: () {},
                  ),
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
                    onTap: () {},
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.cube_box,
                    text: '택배',
                    onTap: () {},
                  ),
                ],
                ...[
                  _serviceItem(
                    icon: CupertinoIcons.arrow_3_trianglepath,
                    text: '분리수거',
                    onTap: () {},
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.trash,
                    text: '종량제봉투',
                    onTap: () {},
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.paintbrush,
                    text: '인테리어',
                    onTap: () {},
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.archivebox,
                    text: '이사',
                    onTap: () {},
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}
