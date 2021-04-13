import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int _selectedIndex;
  List<InfoModel> list = List();

  final _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xfff6f7fb),
        appBar: AppBar(
          title: Text('내 정보'),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(24),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 24,
                height: 1.6,
                color: Colors.black,
              ),
              child: ListView(
                children: [
                  _header(text: '이름'),
                  Row(
                    children: [
                      Expanded(
                        child: _card(text: 'Kim order'),
                      ),
                      Container(width: 32),
                      Spacer(flex: 2),
                    ],
                  ),
                  _header(text: '연락처'),
                  Row(
                    children: [
                      Expanded(
                        child: _card(label: '휴대폰 번호', text: '010-1234-5678'),
                      ),
                      Container(width: 16),
                      Expanded(
                        child: _card(label: '유선 번호', text: '02-1234-5678'),
                      ),
                      Container(width: 16),
                      Expanded(
                        child: _card(label: '비상 연락망', text: '-'),
                      ),
                    ],
                  ),
                  _header(text: '입주 기간'),
                  Row(
                    children: [
                      Expanded(
                        child: _card(text: '2020.01.01 ~ 2021.12.31 (12개월)'),
                      ),
                      Container(width: 16),
                      Spacer(),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _header(text: '입주 호실'),
                            _card(text: '남동 202호 (52.3 m2  / D타입)​'),
                          ],
                        ),
                      ),
                      Container(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _header(text: '입주 형태'),
                            _card(text: '월세   ㅣ   월 600,000원'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _header(text: '지급 물품 현황'),
                  _card(
                      text:
                          '현관 출입카드 1매​\n시스템 에어컨 리모컨 1개​\n우편함 열쇠 2개\nH-Order 패드 1개'),
                  // _item(
                  //   label: '이름',
                  //   value: '김오더',
                  // ),
                  // _item(
                  //   label: '연락처',
                  //   value: '010-1234-5678',
                  // ),
                  // _item(
                  //   label: '비상연락처',
                  //   value: '010-1234-5678',
                  // ),
                  // _item(
                  //   label: '입주호실 (평형/타입)',
                  //   value: '남동 202호 (52.3m/D타입)',
                  // ),
                  // _item(
                  //   label: '입주기간',
                  //   value: '2020.01.01 ~ 2021.01.01 (12개월)',
                  // ),
                  // _item(
                  //   label: '지급 물품 현황',
                  //   value: [
                  //     '- 현관 출입카드 1매​',
                  //     '- 시스템 에어컨 리모컨 1개',
                  //     '- 우편함 열쇠 2개​​'
                  //   ].join('\n'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );

  _header({
    String text,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.only(bottom: 10, top: 20),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      );

  _card({
    String label,
    String text,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            (label?.isNotEmpty ?? false)
                ? Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                : Container(),
            Text(
              text,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  _item({
    String label,
    String value,
  }) =>
      TableRow(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.white24,
            ),
          ),
        ),
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 24,
            ),
            child: Text(label),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 24,
            ),
            child: Text(value),
          ),
        ],
      );
}

class InfoModel {
  final DateTime time;
  final List<String> weekDays;
  final bool enabled;

  InfoModel({
    this.time,
    this.weekDays,
    this.enabled,
  });
}
