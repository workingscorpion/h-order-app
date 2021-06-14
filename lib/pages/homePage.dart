import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/components/homeFloatingButton.dart';
import 'package:h_order/http/types/layout/layoutModel.dart';
import 'package:h_order/pages/home/myView.dart';
import 'package:h_order/pages/home/noticeView.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/store/deviceStore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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

  LayoutModel layout;

  @override
  void initState() {
    super.initState();
    load();
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

  load() async {
    await DeviceStore.instance.getDevice();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: Column(
            children: [
              _info(),
              _body(),
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: _tabController.index != 0 ? 1 : 0,
        child: HomeFloatingButton(
          callback: () {
            _tabController.animateTo(0);
            setState(() {});
          },
        ),
      ));

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

  _infoHeader() => Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Text(
              '관리비납부현황',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 20,
                  ),
            ),
            Container(
              height: 15,
              child: VerticalDivider(
                color: Colors.black,
                thickness: 1,
                width: 20,
              ),
            ),
            Text(
              '납부완료',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff21d021),
              ),
            ),
          ],
        ),
      );

  _leftPanel() => Expanded(
        flex: 3,
        child: Observer(
          builder: (BuildContext context) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${DeviceStore.instance.device?.name?.split("/")?.first ?? ''}',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      '(${DeviceStore.instance.device?.name?.split("/")?.last ?? '입주민'} 님)',
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontSize: 25,
                          ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Text(
                  '${DeviceStore.instance.device?.boundaryAddress ?? ''} ${DeviceStore.instance.device?.boundaryName ?? ''}',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 20,
                    color: CustomColors.addressBlack,
                  ),
                ),
              ),
              Container(height: 20),
              _infoHeader(),
              Container(height: 20),
              // _infoButtons(),
            ],
          ),
        ),
      );

  _rightPanel() => Expanded(
        flex: 4,
        child: _infoButtons(),
      );

  // _verticalDivider() => Container(
  //       height: 15,
  //       child: VerticalDivider(
  //         color: Theme.of(context).accentColor,
  //         thickness: 1,
  //         width: 10,
  //         indent: 14,
  //         endIndent: 11,
  //       ),
  //     );

  _infoButtons() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  _infoTextButton(
                    onPressed: () {
                      _tabController.animateTo(1);
                      setState(() {});
                    },
                    text: '입주민 공지',
                    selected: _tabController.index == 1,
                  ),
                  Container(
                    width: 20,
                  ),
                  _infoTextButton(
                    onPressed: () {
                      _tabController.animateTo(2);
                      setState(() {});
                    },
                    text: '이용내역',
                    selected: _tabController.index == 2,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _infoTextButton(
                  onPressed: () {
                    _tabController.animateTo(3);
                    setState(() {});
                  },
                  text: '관리비 내역',
                  selected: _tabController.index == 3,
                ),
                Container(
                  width: 20,
                ),
                _infoTextButton(
                  onPressed: () {
                    _tabController.animateTo(4);
                    setState(() {});
                  },
                  text: '설정',
                  selected: _tabController.index == 4,
                ),
              ],
            ),
          ],
        ),
        // child: Row(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     ...[
        //       '입주민 공지',
        //       '이용내역',
        //       '관리비 내역',
        //       '설정',
        //     ]
        //         .asMap()
        //         .map(
        //           (index, text) => MapEntry(
        //             index,
        //             _infoTextButton(
        //               onPressed: () {
        //                 _tabController.animateTo(index + 1);
        //                 setState(() {});
        //               },
        //               text: text,
        //               selected: _tabController.index == (index + 1),
        //             ),
        //           ),
        //         )
        //         .entries
        //         .expand((item) => item.key != 0
        //             ? [_verticalDivider(), item.value]
        //             : [item.value]),
        //   ],
        // ),
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
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected
                  ? CustomColors.selectedButton
                  : CustomColors.backgroundLightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              maxLines: 1,
              style: Theme.of(context).textTheme.headline2.copyWith(
                    letterSpacing: -1,
                    fontSize: 16,
                    color: selected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
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

      await Fluttertoast.cancel();
      await Fluttertoast.showToast(
        msg: '뒤로가기를 한 번 더 누르면 종료 됩니다.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.66),
        textColor: Theme.of(context).textTheme.bodyText1.color,
        fontSize: 17,
      );

      return false;
    } catch (ex) {
      return false;
    }
  }
}
