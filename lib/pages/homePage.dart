import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/clock.dart';
import 'package:h_order/pages/home/myView.dart';
import 'package:h_order/pages/home/noticeView.dart';
import 'package:h_order/store/navigationStore.dart';

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _status(),
                _info(),
                _body(),
              ],
            ),
          ),
        ),
      );

  _status() => Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Clock(
              fontSize: 24,
            ),
            Text(
              '진주오피스텔 A동 102호',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      );

  _info() => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '202호',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  '2월분 납부완료',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Text(
              '서울특별시 구로구 구로동 3-25, 신도림 커먼타운 (우: 12345)',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Divider(
              height: 30,
            ),
            Container(
              height: 54,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          _infoButton(
                            onPressed: () {
                              _tabController.index = (index + 1);
                              setState(() {});
                            },
                            text: text,
                            selected: _tabController.index == (index + 1),
                          ),
                        ),
                      )
                      .entries
                      .expand((item) => item.key != 0
                          ? [Container(width: 12), item.value]
                          : [item.value]),
                ],
              ),
            ),
          ],
        ),
      );

  _infoButton({
    VoidCallback onPressed,
    String text,
    bool selected,
  }) =>
      Expanded(
        child: FlatButton(
          color: selected ? Colors.white24 : Colors.white.withOpacity(0),
          onPressed: onPressed,
          child: Text(text),
        ),
      );

  _body() => Expanded(
        child: TabBarView(
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
        _tabController.index = 0;
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
