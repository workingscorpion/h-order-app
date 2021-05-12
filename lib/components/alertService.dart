import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/dateTimeInput.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/service/actionModel.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/models/itemModel.dart';
import 'package:h_order/store/serviceStore.dart';

class AlertService extends StatefulWidget {
  final String serviceObjectId;

  AlertService({
    this.serviceObjectId,
  });

  @override
  _AlertServiceState createState() => _AlertServiceState();
}

class _AlertServiceState extends State<AlertService> {
  ServiceModel get service {
    return ServiceStore.instance.serviceMap[widget.serviceObjectId];
  }

  Map<String, dynamic> data = Map();
  Map<String, TextEditingController> textControllers = Map();

  @override
  void initState() {
    super.initState();

    data = service.items?.asMap()?.map((key, value) {
          switch (value.type) {
            case 'DateTime':
              return MapEntry(value.objectId, DateTime.now());

            case 'Number':
              return MapEntry(value.objectId, 0);

            case 'Input':
              return MapEntry(value.objectId, '');
          }

          return MapEntry(value.objectId, null);
        }) ??
        Map();

    textControllers = service.items
            ?.where((item) => item.type == 'Input')
            ?.toList()
            ?.asMap()
            ?.map(
              (key, value) => MapEntry(
                value.objectId,
                TextEditingController()
                  ..addListener(() {
                    data[value.objectId] = textControllers[value.objectId].text;
                  }),
              ),
            ) ??
        Map();
  }

  @override
  Widget build(BuildContext context) {
    final children = service.items
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
                          service.name,
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
                  ...(children?.isNotEmpty ?? false)
                      ? List.generate(children.length * 2 - 1, (index) {
                          final i = (index / 2).floor();
                          if (index % 2 == 1) {
                            if (i + 1 < children.length) {
                              if (service.items[i].type !=
                                  service.items[i + 1].type) {
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
                        })
                      : [],
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
                    onPressed: () async {
                      await Client.create().serviceAction(
                        service.objectId,
                        'call',
                        ActionModel(
                          data: data.map(
                              (key, value) => MapEntry(key, value.toString())),
                        ),
                      );

                      Navigator.of(context).pop(true);
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
      case 'Text':
        return _alertTextContent(item: item);

      case 'DateTime':
        return _alertDateTimeContent(item: item);

      case 'Number':
        return _alertCountContent(item: item);

      case 'Input':
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
          controller: textControllers[item.objectId],
        ),
      );

  _alertDateTimeContent({
    ItemModel item,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: DateTimeInput(
          onSelectTime: (value) {
            data[item.objectId] = value;
            setState(() {});
          },
        ),
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
