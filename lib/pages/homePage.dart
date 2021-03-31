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

  final _infoButtonData = ['입주민 공지', '신청내역', '관리비 내역', '마이페이지'];

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
                _infos(),
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
        child: Clock(
          fontSize: 24,
        ),
      );

  _infos() => Container(
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(
          width: 1,
          color: Colors.red,
        )),
        child: Column(
          children: [
            _infoHeader(),
            _info(),
          ],
        ),
      );

  _infoHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('202호'),
              Text('(김오더님)'),
            ],
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Text('관리비납부현황'),
                VerticalDivider(
                  color: Colors.white,
                  thickness: 2,
                  width: 12,
                ),
                Text('납부완료')
              ],
            ),
          ),
        ],
      );

  _info() => Expanded(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _infoPanel(),
              _weatherPanel(),
            ],
          ),
        ),
      );

  _weatherPanel() => Expanded(
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: _weatherGradient(),
          child: Row(
            children: [
              _weatherInfo(),
              Icon(
                CupertinoIcons.cloud_sun,
                size: 100,
              ),
            ],
          ),
        ),
      );

  _weatherInfo() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('오늘, 어제보다 2℃ 높아요'),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '38',
                        style: TextStyle(fontSize: 80),
                      ),
                      Text(
                        '℃',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  Text('/11℃ 약간 흐림'),
                ],
              ),
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

  _infoPanel() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '서울특별시 구로구 구로동 3-25, 신도림 커먼타운 (우 12345)',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              '(우 12345)(우 12345)(우 12345)',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            // Expanded(
            //   child: Container(
            //     child: _infoButtons(),
            //   ),
            // ),
            // Expanded(
            //   child: _infoButton(onPressed: (){}, text: '매일 오전'),
            //   )
          ],
        ),
      );

  _infoButtons() => Expanded(child: Container());

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
