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
              ),
              child: Table(
                columnWidths: [
                  IntrinsicColumnWidth(),
                  FlexColumnWidth(),
                ].asMap(),
                children: [
                  _item(
                    label: '이름',
                    value: '김오더',
                  ),
                  _item(
                    label: '연락처',
                    value: '010-1234-5678',
                  ),
                  _item(
                    label: '비상연락처',
                    value: '010-1234-5678',
                  ),
                  _item(
                    label: '입주호실 (평형/타입)',
                    value: '남동 202호 (52.3m/D타입)',
                  ),
                  _item(
                    label: '입주기간',
                    value: '2020.01.01 ~ 2021.01.01 (12개월)',
                  ),
                  _item(
                    label: '지급 물품 현황',
                    value: [
                      '- 현관 출입카드 1매​',
                      '- 시스템 에어컨 리모컨 1개',
                      '- 우편함 열쇠 2개​​'
                    ].join('\n'),
                  ),
                ],
              ),
            ),
          ),
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
