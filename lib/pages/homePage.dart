import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/homeFloatingButton.dart';
import 'package:h_order/components/statusBar.dart';
import 'package:h_order/constants/sampleData.dart';
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
        floatingActionButton: HomeFloatingButton(
          callback: () {
            _tabController.animateTo(0);
            setState(() {});
          },
        ),
      );

  _info() => Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                _leftPanel(),
                SizedBox(width: 24),
                _rightPanel(),
              ],
            ),
          ),
        ],
      ));

  _infoHeader() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '관리비납부현황',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 20,
                      ),
                ),
                _verticalDevider(),
                Text(
                  '납부완료',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(33, 208, 33, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  _leftPanel() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${SampleHomeData.room}',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${SampleHomeData.name} 님',
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: 32,
                        ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${SampleHomeData.address}',
                softWrap: true,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(height: 20),
            FlatButton(
              height: 36,
              color: Theme.of(context).accentColor,
              onPressed: () {
                AppRouter.toAlarmPage();
              },
              child: Text(
                '알람 설정',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 17,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            _infoButtons(),
          ],
        ),
      );

  _rightPanel() => Expanded(
        child: Column(
          children: [
            Spacer(),
            _infoHeader(),
            _weather(),
          ],
        ),
      );

  _weather() => Container(
        decoration: _weatherGradient(),
        padding: EdgeInsets.all(24),
        child: DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.normal),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text('오늘, 어제보다 2℃ 높아요'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 60,
                            child: Text('18',
                                style: TextStyle(fontSize: 70, height: 1)),
                          ),
                          Text(
                            '℃',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Text(
                        '/8℃ 약간 흐림',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 100,
                height: 100,
                child: SvgPicture.asset(
                  'assets/icons/home/weather_cloudsun.svg',
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
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
            Color(0xff197fff),
            Color(0xff3fb6de),
          ],
        ),
      );

  _verticalDevider() => Container(
        height: 15,
        child: VerticalDivider(
          color: Theme.of(context).accentColor,
          thickness: 1,
          width: 10,
          indent: 14,
          endIndent: 11,
        ),
      );

  _status() => StatusBar();

  _infoButtons() => Container(
        height: 36,
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
        child: InkWell(
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(fontWeight: FontWeight.bold)
                  .copyWith(
                    letterSpacing: -1,
                    fontSize: 16,
                  ),
              textAlign: TextAlign.center,
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
