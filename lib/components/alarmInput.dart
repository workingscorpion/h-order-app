import 'package:flutter/material.dart';
import 'package:h_order/pages/alarm/alarmPage.dart';
import 'package:intl/intl.dart';

class AlarmInput extends StatefulWidget {
  final DateTime selectedTime;
  final DateTime selectedWeekDays;
  final void Function(AlarmModel) onAdd;

  AlarmInput({
    Key key,
    this.selectedTime,
    this.selectedWeekDays,
    this.onAdd,
  }) : super(key: key);

  @override
  AlarmInputState createState() => AlarmInputState();
}

class AlarmInputState extends State<AlarmInput> {
  static const int _minuteStep = 5;
  static const double _itemExtent = 120;

  final _hours = List.generate(12, (value) => value + 1);
  final _minutes =
      List.generate((60 / _minuteStep).round(), (value) => value * _minuteStep);
  final _noons = ['오전', '오후'];
  final _weekDays = ['월', '화', '수', '목', '금', '토', '일'];

  ScrollController _hourListViewController;
  ScrollController _minuteListViewController;
  ScrollController _noonListViewController;

  DateTime _selectedTime;
  List<String> _selectedWeekDays;

  @override
  void initState() {
    super.initState();

    final time = widget.selectedTime ?? DateTime.now();
    final hour = time.hour;
    final minute = (time.minute / _minuteStep).round() * _minuteStep;

    _selectedTime = DateTime(0, 0, 0, hour, minute);
    _selectedWeekDays = widget.selectedWeekDays ?? [];

    _hourListViewController = FixedExtentScrollController(
      initialItem: (hour + 11) % 12,
    );
    _minuteListViewController = FixedExtentScrollController(
      initialItem: (minute / _minuteStep).round(),
    );
    _noonListViewController = FixedExtentScrollController(
      initialItem: (hour / 12).floor(),
    );
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Color(0xfff6f7fb),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.only(bottom: 12),
              child: Text('시간 설정'),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: _time(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.only(bottom: 12),
              child: Text('요일반복 설정'),
            ),
            Row(
              children: [
                ..._weekDays
                    .map(
                      (item) => _weekDayItem(
                        value: item,
                      ),
                    )
                    .toList()
                    .asMap()
                    .entries
                    .expand(
                      (e) => e.key < _weekDays.length - 1
                          ? [
                              e.value,
                              Container(
                                width: 10,
                              ),
                            ]
                          : [e.value],
                    ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: FlatButton(
                color: Colors.black,
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                onPressed: () {
                  _add();
                },
                child: Text(
                  widget.selectedTime == null ? '추가' : '저장',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  _add() {
    if (widget.onAdd != null) {
      _selectedWeekDays
        ..sort((a, b) => _weekDays.indexOf(a) > _weekDays.indexOf(b) ? 1 : -1);

      widget.onAdd(AlarmModel(
        time: _selectedTime,
        weekDays: _selectedWeekDays,
        enabled: true,
      ));

      _selectedTime = DateTime.now();
      _selectedWeekDays = [];

      final duration = Duration(seconds: 1);
      final curve = Curves.ease;

      _hourListViewController.animateTo(
        (_selectedTime.hour + 11) % 12 * _itemExtent,
        duration: duration,
        curve: curve,
      );

      _minuteListViewController.animateTo(
        (_selectedTime.minute / _minuteStep).round() * _itemExtent,
        duration: duration,
        curve: curve,
      );

      _noonListViewController.animateTo(
        (_selectedTime.hour / 12).floor() * _itemExtent,
        duration: duration,
        curve: curve,
      );
    }
  }

  _weekDayItem({
    String value,
  }) =>
      Expanded(
        child: InkWell(
          onTap: () {
            if (_selectedWeekDays.contains(value)) {
              _selectedWeekDays.remove(value);
            } else {
              _selectedWeekDays.add(value);
            }

            setState(() {});
          },
          child: AnimatedContainer(
            padding: EdgeInsets.symmetric(vertical: 12),
            duration: Duration(milliseconds: 150),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _selectedWeekDays.contains(value)
                  ? Colors.black
                  : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 17,
                color: _selectedWeekDays.contains(value)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      );

  _time() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _hour(),
          _colon(),
          _minute(),
          _noon(),
        ],
      );

  _listWheelScrollView({
    ScrollController controller,
    ValueChanged<int> onSelectedItemChanged,
    List<Widget> children,
  }) =>
      ListWheelScrollView.useDelegate(
        controller: controller,
        onSelectedItemChanged: onSelectedItemChanged,
        physics: FixedExtentScrollPhysics(),
        itemExtent: _itemExtent,
        overAndUnderCenterOpacity: .1,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: children,
        ),
      );

  _divier() => Container(
        width: 40,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black),
          ),
        ),
      );

  _hour() => Expanded(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 90,
              child: _divier(),
            ),
            _listWheelScrollView(
              controller: _hourListViewController,
              onSelectedItemChanged: (value) {
                _selectTime(hour: _hours[value]);
              },
              children: [
                ..._hours.map(
                  (value) => Center(
                    child: Text(
                      NumberFormat('00').format(value),
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 90,
              child: _divier(),
            ),
          ],
        ),
      );

  _minute() => Expanded(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 90,
              child: _divier(),
            ),
            _listWheelScrollView(
              controller: _minuteListViewController,
              onSelectedItemChanged: (value) {
                _selectTime(minute: _minutes[value]);
              },
              children: [
                ..._minutes.map(
                  (value) => Center(
                    child: Text(
                      NumberFormat('00').format(value),
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 90,
              child: _divier(),
            ),
          ],
        ),
      );

  _noon() => Expanded(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 90,
              child: _divier(),
            ),
            _listWheelScrollView(
              controller: _noonListViewController,
              onSelectedItemChanged: (value) {
                _selectTime(noon: _noons[value]);
              },
              children: [
                ..._noons.map(
                  (item) => Center(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 90,
              child: _divier(),
            ),
          ],
        ),
      );

  _dot() => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      );

  _colon() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dot(),
            Container(
              height: 20,
            ),
            _dot(),
          ],
        ),
      );

  _selectTime({
    int hour,
    int minute,
    String noon,
  }) {
    if (hour != null) {
      _selectedTime = DateTime(0, 0, 0, hour, _selectedTime.minute);
    }

    if (minute != null) {
      _selectedTime = DateTime(0, 0, 0, _selectedTime.hour, minute);
    }

    if (noon != null) {
      switch (noon) {
        case '오후':
          _selectedTime =
              DateTime(0, 0, 0, _selectedTime.hour + 12, _selectedTime.minute);
          break;
      }
    }

    setState(() {});
  }
}
