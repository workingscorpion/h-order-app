import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/clock.dart';
import 'package:h_order/components/homeFloatingButton.dart';
import 'package:h_order/components/statusBar.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/pages/home/myView.dart';
import 'package:h_order/pages/home/noticeView.dart';

import 'home/billView.dart';
import 'home/historyView.dart';
import 'home/homeView.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  DateTime currentBackPressTime;
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    currentBackPressTime = null;

    _tabController = TabController(
      vsync: this,
      initialIndex: 0,
      length: 5,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: SafeArea(
            child: Column(
              children: [
                _status(),
                _info(),
                _body(),
              ],
            ),
          ),
        ),
        floatingActionButton: HomeFloatingButton(),
      );

  _info() => Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 24,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              _leftPanel(),
              SizedBox(width: 24),
              _rightPanel(),
            ],
          ),
        ),
      );

  _leftPanel() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _infoText(text: '202호', isBold: true, size: 50),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: _infoText(text: '(김오더 님)', isBold: false, size: 25),
                ),
              ],
            ),
            Text(
              '서울특별시 구로구 구로동 3-25, 신도림 커먼타운 (우 12345)',
              style: TextStyle(
                fontSize: 16,
              ),
              softWrap: true,
            ),
            _infoButtons(),
            FlatButton(
              height: 50,
              color: Theme.of(context).accentColor,
              onPressed: () {
                AppRouter.toAlarmPage();
              },
              child: Text(
                '알림 설정',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      );

  _rightPanel() => Expanded(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _infoText(text: '관리비납부현황', isBold: false, size: 15),
                  _verticalDevider(height: 15),
                  _infoText(
                    text: '납부완료',
                    isBold: true,
                    size: 20,
                    color: Color.fromRGBO(33, 208, 33, 1),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                decoration: _weatherGradient(),
                child: Row(
                  children: [
                    _weatherInfo(),
                    Spacer(),
                    Icon(
                      CupertinoIcons.cloud_sun,
                      size: 80,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  _weatherInfo() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                '오늘, 어제보다 2℃ 높아요',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '38',
                      style: TextStyle(
                        fontSize: 70,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '℃',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  '/11℃ 약간 흐림',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      );

  _weatherGradient() => BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [
            0.1,
            0.8,
          ],
          colors: [
            Color.fromRGBO(62, 182, 223, 1),
            Color.fromRGBO(25, 128, 255, 1)
          ],
        ),
      );

  _verticalDevider({
    double height,
  }) =>
      Container(
        height: height != null ? height : 20,
        child: VerticalDivider(
          color: Theme.of(context).accentColor,
          thickness: 1,
          width: 20,
        ),
      );

  _infoText({String text, bool isBold, double size, Color color}) => Text(
        text,
        style: TextStyle(
          color: color != null
              ? color
              : Theme.of(context).textTheme.bodyText2.color,
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      );

  _status() => StatusBar();

  _infoButtons() => Expanded(
        child: Row(
          children: [
            ...[
              '입주민 공지',
              '이용내역',
              '관리비 내역',
              '마이페이지',
            ]
                .asMap()
                .map(
                  (index, text) => MapEntry(
                    index,
                    _infoTextButton(
                      onPressed: () {
                        _tabController.animateTo(index + 1);
                        setState(() {});
                      },
                      text: text,
                      selected: _tabController.index == (index + 1),
                    ),
                  ),
                )
                .entries
                .expand((item) => item.key != 0
                    ? [_verticalDevider(), item.value]
                    : [item.value]),
          ],
        ),
      );

  _infoTextButton({
    VoidCallback onPressed,
    String text,
    bool selected = false,
  }) =>
      Expanded(
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            maxLines: 1,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      );

  _body() => Expanded(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            HomeView(),
            NoticeView(),
            HistoryView(),
            BillView(),
            MyView(),
          ],
        ),
      );

  Future<bool> _onWillPop() async {
    try {
      if (_tabController.index != 0) {
        _tabController.animateTo(0);
        setState(() {});
        return false;
      }

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
        fontSize: 14,
      );

      return false;
    } catch (ex) {
      return false;
    }
  }
}
