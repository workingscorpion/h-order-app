import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/spin.dart';
import 'package:h_order/components/viewHeader.dart';
import 'package:h_order/constants/constants.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/models/historyDetailModel.dart';
import 'package:h_order/models/historyModel.dart';
import 'package:h_order/models/keyValueModel.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryView extends StatefulWidget {
  HistoryView();

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  bool loading;
  FocusNode focusNode;

  List<HistoryModel> list = List();
  List<HistoryModel> visibleList = List();

  final List<String> headers = [
    '서비스명',
    '상세항목',
    '이용일자',
    '결제금액',
    '상태',
  ];

  Map<int, OrderStatusModel> newOrderStatus = {
    -2: OrderStatusModel(
      name: '전체',
      color: Colors.black,
    ),
  };

  List<String> statusTexts;

  List<Color> statusColors;

  String _selectedPopupMenu = '전체';

  @override
  void initState() {
    loading = true;
    newOrderStatus.addAll(orderStatus);
    statusTexts = newOrderStatus.values.map((e) => e.name).toList();
    statusColors = newOrderStatus.values.map((e) => e.color).toList();
    super.initState();

    load();
  }

  load() async {
    final res = await Client.create().histories();
    list = res.list.map((e) => HistoryModel.fromJson(e)).toList();
    list.sort((a, b) => a.createdTime.isAfter(b.createdTime) ? -1 : 1);
    visibleList = List.of(list);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 25,
          right: 25,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header(),
              _histories(),
            ],
          ),
        ),
      );

  _header() => Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: ViewHeader(text: '이용내역'),
          ),
          Spacer(),
          _filter(),
        ],
      );

  _histories() => Expanded(
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(),
            child: Column(
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  child: _historiesHeader(),
                ),
                _historiesBody(),
              ],
            ),
          ),
        ),
      );

  _historiesHeader() => Container(
        color: Theme.of(context).accentColor,
        child: _row(
          color: Colors.black,
          children: List.generate(
            headers.length,
            (index) => Text(
              headers[index],
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

  String _getFirstMenu(HistoryModel history) {
    var menuName = '-';
    try {
      if (history.data != null) {
        final data = jsonDecode(history.data);
        if (data['cart'] != null) {
          menuName = jsonDecode(data['cart'])?.first['name'] ?? '-';
        }
      }
    } catch (e) {}
    return menuName;
  }

  _historiesBody() => Expanded(
        child: loading != false
            ? Center(
                child: Spin(
                  size: 30,
                ),
              )
            : visibleList.length > 0
                ? ListView(
                    children: [
                      ...visibleList.map(
                        (item) => _item(
                          children: [
                            Text(
                              item.serviceName != null
                                  ? '${item.serviceName}'
                                  : '-',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              _getFirstMenu(item) != null
                                  ? '${_getFirstMenu(item)}'
                                  : '-',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${DateFormat('yyyy/MM/dd').format(item.createdTime)}',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              item.amount != null && item.amount > 0
                                  ? '${NumberFormat().format(item.amount)}원'
                                  : '-',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              orderStatus[item.status].name,
                              maxLines: 1,
                              style: TextStyle(
                                color: orderStatus[item.status].color,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          content: null,
                          // content: item.detail,
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/common/empty.svg',
                          height: 200,
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(top: 30),
                        //   child: Text('데이터가 없습니다.'),
                        // ),
                      ],
                    ),
                  ),
      );

  _row({
    Color color,
    List<Widget> children,
  }) =>
      Container(
        color: color ?? Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 26,
        ),
        child: Row(
          children: [
            ...children
                .asMap()
                .map(
                  (index, item) => MapEntry(
                    index,
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: index < children.length - 1
                            ? EdgeInsets.only(right: 10)
                            : EdgeInsets.zero,
                        child: item,
                      ),
                    ),
                  ),
                )
                .values,
          ],
        ),
      );

  _item({
    List<Widget> children,
    HistoryDetailModel content,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: CustomColors.tableInnerBorder,
            ),
          ),
        ),
        child: _row(
          children: children,
        ),
      );

  _collapsibleBody(HistoryDetailModel content) => Container(
        padding: EdgeInsets.all(35),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                content?.title ?? '-',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text('asdf'
                  // direction: Axis.vertical,
                  // children: List.generate(
                  //   content.detail.length,
                  //   (index) => _detailItem(
                  //     content.detail[index],
                  //   ),
                  // ),
                  ),
            ),
            Text(
              '시간시간',
              // DateFormat('HH:mm').format(content.reservedTime),
            ),
            Text('1241234'),
            // Text(content.request),
            Divider(
              height: 50,
              color: Colors.grey,
              thickness: 1,
            ),
            Column(
              children: List.generate(
                3,
                (index) => _collapsibleFooter(index, content),
              ),
            )
          ],
        ),
      );

  _collapsibleFooter(int index, HistoryDetailModel content) => Container(
        margin: EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Text(
              _footerText(index),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            _footerValue(index, content),
          ],
        ),
      );

  _footerValue(int index, HistoryDetailModel content) {
    switch (index) {
      case 0:
        return Text(DateFormat('yyyy/MM/dd hh:mm').format(content.createdTime));

      case 1:
        return Text('${NumberFormat().format(content.amount)}원');

      case 2:
        return Text('${content.paymentMethod}(${content.paymentData})');
    }
  }

  _footerText(int index) {
    switch (index) {
      case 0:
        return '이용일시';

      case 1:
        return '결제금액';

      case 2:
        return '결제방법';
    }
  }

  _detailItem(KeyValueModel item) => Container(
        margin: EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Text('• ${item.key} ${item.value}개'),
            Spacer(),
            Text('${NumberFormat().format(item.price)}원'),
          ],
        ),
      );

  _filter() => DefaultTextStyle(
        style: TextStyle(fontSize: 16),
        child: Container(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  width: 160,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 30),
                        child: Text(
                          _selectedPopupMenu,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(CupertinoIcons.chevron_down),
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                offset: Offset(0, 100),
                itemBuilder: (context) => newOrderStatus.entries
                    .map(
                      (e) => PopupMenuItem(
                        value: e.key,
                        child: Container(
                          child: Text(
                            e.value.name,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          width: 100,
                        ),
                      ),
                    )
                    .toList(),
                onSelected: (value) {
                  _selectedPopupMenu = newOrderStatus[value].name;
                  if (value != -2) {
                    visibleList = list.where((h) => h.status == value).toList();
                  } else {
                    visibleList = list;
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      );
}
