import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/dateTimeInput.dart';
import 'package:h_order/components/serviceButton.dart';

class AlertService extends StatefulWidget {
  final IconData icon;
  final String label;
  final List<ServiceItem> items;

  AlertService({
    this.icon,
    this.label,
    this.items,
  });

  @override
  _AlertServiceState createState() => _AlertServiceState();
}

class _AlertServiceState extends State<AlertService> {
  Map<String, dynamic> data = Map();

  @override
  void initState() {
    super.initState();

    data = widget.items?.asMap()?.map((key, value) {
          switch (value.type) {
            case 'date':
              return MapEntry(value.objectId, DateTime.now());

            case 'time':
              return MapEntry(value.objectId, null);

            case 'count':
              return MapEntry(value.objectId, 0);
          }

          return MapEntry(value.objectId, null);
        }) ??
        Map();
  }

  @override
  Widget build(BuildContext context) {
    final children =
        widget.items.map((item) => _alertContent(item: item)).toList();

    return Container(
      width: 560,
      color: Colors.white,
      child: IntrinsicHeight(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xf0f9f9f9),
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0x22000000),
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          widget.label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(CupertinoIcons.xmark),
                          iconSize: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...List.generate(children.length * 2 - 1, (index) {
                    final i = (index / 2).floor();
                    if (index % 2 == 1) {
                      if (i + 1 < children.length) {
                        if (widget.items[i].type != widget.items[i + 1].type) {
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
                      return false;
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
                      // FIXME
                      Navigator.of(context).pop(true);
                      // Navigator.of(context).pop(data);
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
    );
  }

  _alertContent({
    ServiceItem item,
  }) {
    switch (item.type) {
      case 'text':
        return _alertTextContent(item: item);

      case 'dateTime':
        return _alertDateTimeContent(item: item);

      case 'count':
        return _alertCountContent(item: item);
    }

    return Container();
  }

  _alertTextContent({
    ServiceItem item,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: Text(
          item.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      );

  _alertDateTimeContent({
    ServiceItem item,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: DateTimeInput(),
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

  _alertCountContent({
    ServiceItem item,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 100),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  item.label,
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
                  color: Color(0xff606162),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    data[item.objectId] -= 1;
                    if (data[item.objectId] < 0) {
                      data[item.objectId] = 0;
                    }
                    setState(() {});
                  },
                  iconSize: 24,
                  icon: Icon(
                    CupertinoIcons.minus,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 52,
                child: Text(
                  '${data[item.objectId]}',
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
                  color: Color(0xff606162),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    data[item.objectId] += 1;
                    if (data[item.objectId] > item.max) {
                      data[item.objectId] = item.max;
                    }
                    setState(() {});
                  },
                  iconSize: 24,
                  icon: Icon(
                    CupertinoIcons.add,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
