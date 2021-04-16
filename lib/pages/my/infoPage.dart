import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/constants/sampleData.dart';
import 'package:h_order/models/homeModel.dart';
import 'package:intl/intl.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final _listKey = GlobalKey<AnimatedListState>();

  int _selectedIndex;
  List<InfoModel> list = List();

  HomeModel home;

  @override
  void initState() {
    super.initState();
    home = SampleData.home();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xfff6f7fb),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                PageHeader(
                  title: ['내 정보'],
                  canBack: true,
                ),
                Expanded(
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
                                child: _card(text: home.name),
                              ),
                              Container(width: 32),
                              Spacer(flex: 2),
                            ],
                          ),
                          _header(text: '연락처'),
                          Row(
                            children: [
                              Expanded(
                                child: _card(
                                    label: '휴대폰 번호', text: '${home.cellPhone}'),
                              ),
                              Container(width: 16),
                              Expanded(
                                child: _card(
                                    label: '유선 번호', text: '${home.phone}'),
                              ),
                              Container(width: 16),
                              Expanded(
                                child: _card(
                                    label: '비상 연락망',
                                    text: '${home.emergencyPhone}'),
                              ),
                            ],
                          ),
                          _header(text: '입주 기간'),
                          Row(
                            children: [
                              Expanded(
                                child: _card(
                                  text:
                                      '${DateFormat('yyyy-MM-dd').format(home.contractStartDate)} ~ ${DateFormat('yyyy-MM-dd').format(home.contractEndDate)} ${(home.contractEndDate.difference(home.contractStartDate).inDays / 30).floor()}개월',
                                ),
                              ),
                              Container(width: 16),
                              Spacer(),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _header(text: '입주 호실'),
                                    _card(text: '${home.roomDetail}'),
                                  ],
                                ),
                              ),
                              Container(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _header(text: '입주 형태'),
                                    _card(text: '${home.contractType}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          _header(text: '지급 물품 현황'),
                          _card(text: home.items.join('\n')),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
