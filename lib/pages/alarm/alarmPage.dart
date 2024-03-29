import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/alarmInput.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:intl/intl.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  int _selectedIndex;
  List<AlarmModel> list = List();

  final _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          child: Column(
            children: [
              PageHeader(
                title: ['알람 설정'],
                canBack: true,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 600,
                      child: _input(),
                    ),
                    Expanded(
                      child: AnimatedList(
                        key: _listKey,
                        padding: EdgeInsets.all(24),
                        initialItemCount: list.length,
                        itemBuilder: (context, index, animation) =>
                            SlideTransition(
                          position: animation.drive(
                            Tween<Offset>(
                              begin: Offset(-1, 0),
                              end: Offset(0, 0),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: animation,
                            child: _item(
                              index: index,
                              item: list[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  _input() => Container(
        padding: EdgeInsets.all(24),
        child: AlarmInput(
          onAdd: (item) {
            list.insert(0, item);

            _listKey.currentState.insertItem(
              0,
              duration: Duration(milliseconds: 225),
            );

            setState(() {});
          },
        ),
      );

  _item({
    int index,
    AlarmModel item,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: EdgeInsets.only(
          bottom: 24,
        ),
        child: InkWell(
          onTap: () {
            _selectItem(index);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? Colors.white24
                  : Colors.white.withOpacity(0),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Colors.white24,
                width: 1,
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 24),
                        child: Text(
                          '${DateFormat('a hh:mm').format(item.time)}',
                          style: TextStyle(
                            fontSize: 36,
                          ),
                        ),
                      ),
                      Text(
                        item.weekDays.join(', '),
                        style: TextStyle(
                          height: 1,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 1),
                  CupertinoSwitch(
                    value: item.enabled,
                    onChanged: (value) {
                      final index = list.indexOf(item);
                      if (index != -1) {
                        list.replaceRange(
                          index,
                          index + 1,
                          [
                            AlarmModel(
                              time: item.time,
                              weekDays: item.weekDays,
                              enabled: value,
                            ),
                          ],
                        );
                        setState(() {});
                      }
                    },
                  ),
                  Container(width: 16),
                  Material(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color(0xff606162),
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Text(
                          '삭제',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  _selectItem(
    int index,
  ) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
    } else {
      _selectedIndex = null;
    }

    if (_selectedIndex != null) {}

    setState(() {});
  }
}

class AlarmModel {
  final DateTime time;
  final List<String> weekDays;
  final bool enabled;

  AlarmModel({
    this.time,
    this.weekDays,
    this.enabled,
  });
}
