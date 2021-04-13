import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final List<ServiceItem> items;
  final GestureTapCallback onTap;

  ServiceButton({
    this.icon,
    this.label,
    this.items,
    this.onTap,
  });

  @override
  _ServiceButtonState createState() => _ServiceButtonState();
}

class _ServiceButtonState extends State<ServiceButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: InkWell(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap();
          } else {
            _alert(
              title: widget.label,
              items: widget.items,
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Icon(
                widget.icon,
                size: 64,
              ),
            ),
            Text(
              widget.label ?? '',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _alert({
    String title,
    List<ServiceItem> items,
  }) async {
    final children = items.map((item) => _alertContent(item: item)).toList();

    await showDialog(
      barrierColor: Colors.black.withOpacity(.85),
      context: context,
      child: AlertDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        clipBehavior: Clip.antiAlias,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        title: Container(
          decoration: BoxDecoration(
            color: Color(0xf0f9f9f9),
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color(0x22000000),
              ),
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(CupertinoIcons.xmark),
                    iconSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        content: Container(
          width: 560,
          color: Colors.white,
          child: IntrinsicHeight(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...List.generate(children.length * 2 - 1, (index) {
                        final i = (index / 2).floor();
                        if (index % 2 == 1) {
                          if (i + 1 < children.length) {
                            if (items[i].type != items[i + 1].type) {
                              return Container(
                                height: 40,
                              );
                            } else {
                              return Divider(
                                color: Color(0xffe5e5e5),
                                height: 30,
                                thickness: 1,
                                indent: 100,
                                endIndent: 100,
                              );
                            }
                          }

                          return Container();
                        }

                        return children[i];
                      }),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        minWidth: 140,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '취소',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        width: 24,
                      ),
                      FlatButton(
                        minWidth: 140,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.black,
                        child: Text(
                          '신청',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _alertContent({
    ServiceItem item,
  }) {
    switch (item.type) {
      case 'text':
        return _alertTextContent(label: item.label);

      case 'date':
        return _alertDateContent(label: item.label);

      case 'time':
        return _alertTimeContent(label: item.label);

      case 'option':
        return _alertOptionContent(
          label: item.label,
          max: item.max,
          min: item.min,
        );
    }

    return Container();
  }

  _alertTextContent({
    String label,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      );

  _alertDateContent({
    String label,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(width: 80),
              _datePicker(),
            ],
          ),
        ),
      );

  _alertTimeContent({
    String label,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(width: 100),
              _timePicker(),
            ],
          ),
        ),
      );

  _datePicker() => InkWell(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(
              Duration(days: 100),
            ),
          );
        },
        child: Container(
          child: Text('${DateFormat('yyyy-MM-dd').format(DateTime.now())}'),
        ),
      );

  _timePicker() => InkWell(
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
        },
        child: Text('${TimeOfDay.now().format(context)}'),
      );

  _alertOptionContent({
    String label,
    int max,
    int min,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 100),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(width: 100),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  iconSize: 24,
                  icon: Icon(
                    CupertinoIcons.minus,
                    size: 14,
                  ),
                ),
              ),
              Container(
                width: 52,
                child: Text(
                  '$min',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  iconSize: 24,
                  icon: Icon(
                    CupertinoIcons.add,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class ServiceItem {
  final String type;
  final String label;
  final int max;
  final int min;
  final List<ServiceItem> children;

  ServiceItem({
    this.type,
    this.label,
    this.max,
    this.min,
    this.children,
  });
}
