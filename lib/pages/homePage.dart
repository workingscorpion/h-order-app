import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/appRouter.dart';
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
                color: Colors.white,
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
                color: Colors.white,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CarouselSlider(
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
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Material(
                        color: Colors.transparent,
                        child: GridView.count(
                          padding: EdgeInsets.zero,
                          crossAxisCount: 4,
                          children: [
                            _serviceItem(
                              icon: CupertinoIcons.cart,
                              text: '주문',
                              onTap: () {
                                AppRouter.toShopPage();
                              },
                            ),
                            _serviceItem(
                              icon: CupertinoIcons.placemark,
                              text: '주변정보',
                              onTap: () {
                                AppRouter.toBoardPage();
                              },
                            ),
                            _serviceItem(
                              icon: CupertinoIcons.alarm,
                              text: '알람',
                              onTap: () {
                                AppRouter.toAlarmPage();
                              },
                            ),
                            _serviceItem(
                              icon: CupertinoIcons.slider_horizontal_3,
                              text: '설정',
                              onTap: () {
                                AppRouter.toSettingsPage();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      '현주오피스텔 502호',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(.2),
                      ),
                    ),
                  ),
                ],
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
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
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
        textColor: Colors.white,
        fontSize: 14.0,
      );

      return false;
    } catch (ex) {
      return false;
    }
  }
}
