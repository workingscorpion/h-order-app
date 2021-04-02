import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScreenPage extends StatefulWidget {
  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  int _selectedIndex;
  List<ScreenModel> list = List();

  final _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('화면 설정'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _input(),
              ),
              Expanded(
                child: AnimatedList(
                  key: _listKey,
                  padding: EdgeInsets.all(24),
                  initialItemCount: list.length,
                  itemBuilder: (context, index, animation) => SlideTransition(
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
      );

  _input() => Container(
        padding: EdgeInsets.all(24),
      );

  _item({
    int index,
    ScreenModel item,
  }) =>
      Container(
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 24),
                    child: Text(
                      '${DateFormat('a hh:mm').format(item.time)}',
                      style: TextStyle(
                        height: 1,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  Text(
                    item.weekDays.join(', '),
                    style: TextStyle(
                      height: 1,
                      fontSize: 22,
                      color: Colors.white54,
                    ),
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
                            ScreenModel(
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

class ScreenModel {
  final DateTime time;
  final List<String> weekDays;
  final bool enabled;

  ScreenModel({
    this.time,
    this.weekDays,
    this.enabled,
  });
}
