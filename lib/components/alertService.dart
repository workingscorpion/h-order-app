import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/dateTimeInput.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/models/itemModel.dart';

class AlertService extends StatefulWidget {
  final ServiceModel service;

  AlertService({
    this.service,
  });

  @override
  _AlertServiceState createState() => _AlertServiceState();
}

class _AlertServiceState extends State<AlertService> {
  Map<String, dynamic> data = Map();

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    data = widget.service.items?.asMap()?.map((key, value) {
          switch (value.type) {
            case 'date':
              return MapEntry(value.objectId, DateTime.now());

            case 'time':
              return MapEntry(value.objectId, null);

            case 'count':
              return MapEntry(value.objectId, 0);

            case 'input':
              return MapEntry(value.objectId, '');
          }

          return MapEntry(value.objectId, null);
        }) ??
        Map();
  }

  @override
  Widget build(BuildContext context) {
    final children = widget.service.items
            ?.where((item) => item.type != 'resultMessage')
            ?.map((item) => _alertContent(item: item))
            ?.toList() ??
        List();

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
                          widget.service.name,
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
                        if (widget.service.items[i].type !=
                            widget.service.items[i + 1].type) {
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
    ItemModel item,
  }) {
    switch (item.type) {
      case 'text':
        return _alertTextContent(item: item);

      case 'dateTime':
        return _alertDateTimeContent(item: item);

      case 'count':
        return _alertCountContent(item: item);

      case 'input':
        return _alertInputContent(item: item);
    }

    return Container();
  }

  _alertTextContent({
    ItemModel item,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: Text(
          item.value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      );

  _alertInputContent({
    ItemModel item,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: TextField(
          cursorWidth: 1,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            hintText: item.value,
          ),
          controller: _textController,
        ),
      );

  _alertDateTimeContent({
    ItemModel item,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: DateTimeInput(),
      );

  _alertCountContent({
    ItemModel item,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 100),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  item.value,
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
                    if (item.max != null && data[item.objectId] > item.max) {
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
