import 'package:flutter/material.dart';
import 'package:h_order/pages/alarm/alarmPage.dart';
import 'package:intl/intl.dart';

class DateTimeInput extends StatefulWidget {
  final DateTime selectedTime;
  final DateTime selectedWeekDays;
  final void Function(AlarmModel) onAdd;

  DateTimeInput({
    Key key,
    this.selectedTime,
    this.selectedWeekDays,
    this.onAdd,
  }) : super(key: key);

  @override
  DateTimeInputState createState() => DateTimeInputState();
}

class DateTimeInputState extends State<DateTimeInput> {
  static const int _minuteStep = 5;
  static const double _itemExtent = 60;

  List<DateTime> _dates = List();
  final _hours = List.generate(12, (value) => value + 1);
  final _minutes =
      List.generate((60 / _minuteStep).round(), (value) => value * _minuteStep);
  final _noons = ['오전', '오후'];

  ScrollController _dateListViewController;
  ScrollController _hourListViewController;
  ScrollController _minuteListViewController;
  ScrollController _noonListViewController;

  DateTime _selectedTime;

  @override
  void initState() {
    super.initState();

    final time = widget.selectedTime ?? DateTime.now();
    final hour = time.hour;
    final minute = (time.minute / _minuteStep).round() * _minuteStep;

    _selectedTime = DateTime(0, 0, 0, hour, minute);

    _dates = List.generate(
        100, (index) => DateTime.now().add(Duration(days: 50 - index)));

    _dateListViewController = FixedExtentScrollController(
      initialItem: (hour + 11) % 12,
    );
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
        height: 90,
        child: _dateTime(),
      );

  _add() {
    if (widget.onAdd != null) {
      // widget.onAdd(AlarmModel(
      //   time: _selectedTime,
      //   enabled: true,
      // ));

      _selectedTime = DateTime.now();

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

  _dateTime() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _date(),
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
        overAndUnderCenterOpacity: 0,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: children,
        ),
      );

  _divider() => Container(
        width: 40,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0xff979797),
            ),
          ),
        ),
      );

  _date() => Expanded(
        flex: 2,
        child: Column(
          children: [
            _divider(),
            Expanded(
              child: _listWheelScrollView(
                controller: _hourListViewController,
                onSelectedItemChanged: (value) {
                  _selectTime(date: _dates[value]);
                },
                children: [
                  ..._dates.map(
                    (value) => Center(
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(value),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _divider(),
          ],
        ),
      );

  _hour() => Expanded(
        child: Column(
          children: [
            _divider(),
            Expanded(
              child: _listWheelScrollView(
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
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _divider(),
          ],
        ),
      );

  _minute() => Expanded(
        child: Column(
          children: [
            _divider(),
            Expanded(
              child: _listWheelScrollView(
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
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _divider(),
          ],
        ),
      );

  _noon() => Expanded(
        child: Column(
          children: [
            _divider(),
            Expanded(
              child: _listWheelScrollView(
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
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _divider(),
          ],
        ),
      );

  _dot() => Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      );

  _colon() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dot(),
            Container(
              height: 10,
            ),
            _dot(),
          ],
        ),
      );

  _selectTime({
    DateTime date,
    int hour,
    int minute,
    String noon,
  }) {
    if (date != null) {
      _selectedTime = DateTime(
        date.year,
        date.month,
        date.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );
    }

    if (hour != null) {
      _selectedTime = DateTime(
        _selectedTime.year,
        _selectedTime.month,
        _selectedTime.day,
        hour,
        _selectedTime.minute,
      );
    }

    if (minute != null) {
      _selectedTime = DateTime(
        _selectedTime.year,
        _selectedTime.month,
        _selectedTime.day,
        _selectedTime.hour,
        minute,
      );
    }

    if (noon != null) {
      switch (noon) {
        case '오후':
          _selectedTime = DateTime(
            _selectedTime.year,
            _selectedTime.month,
            _selectedTime.day,
            _selectedTime.hour + 12,
            _selectedTime.minute,
          );
          break;
      }
    }

    setState(() {});
  }
}
