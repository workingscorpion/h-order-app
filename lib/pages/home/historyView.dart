import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/collapsible.dart';
import 'package:h_order/components/viewHeader.dart';
import 'package:h_order/models/historyDetailModel.dart';
import 'package:h_order/models/historyModel.dart';
import 'package:h_order/models/keyValueModel.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  HistoryView();

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  FocusNode focusNode;
  String selectedPopupMenu = 'all';

  List<HistoryModel> origin;

  List<HistoryModel> list;

  List<int> ratio = [1, 2, 2, 2, 2, 2];

  List<String> headers = [
    'No.',
    '서비스명',
    '상세항목',
    '이용일자',
    '결제금액',
    '상태',
  ];

  @override
  void initState() {
    super.initState();

    final HistoryDetailModel detailMap = HistoryDetailModel(
      title: '종량제 봉투',
      createdTime: DateTime.now(),
      amount: 5300,
      paymentMethod: '국민카드',
      paymentData: '1234',
      detail: [
        KeyValueModel(key: '20L', value: 1, price: 1000),
        KeyValueModel(key: '50L', value: 1, price: 1800),
        KeyValueModel(key: '100L', value: 1, price: 2500),
      ],
      reservedTime: DateTime.now(),
      request: '문앞에 두고 벨을 눌러주세요',
    );

    origin = List.generate(
      30,
      (index) => HistoryModel(
        index: index + 1,
        serviceName: '서비스명$index',
        createdTime: DateTime.now(),
        summary: '상세항목$index',
        amount: index * 1000,
        status: index % 3,
        detail: detailMap,
      ),
    );

    list = [...origin];
  }

  @override
  void dispose() {
    super.dispose();
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

  _historiesBody() => Expanded(
        child: ListView(
          children: [
            ...list.map(
              (item) => _item(
                children: [
                  Text(
                    '${item.index}',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    item.serviceName != null ? '${item.serviceName}' : '-',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    item.summary != null ? '${item.summary}' : '-',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${DateFormat('yyyy/MM/dd').format(item.createdTime)}',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    item.amount != null
                        ? '${NumberFormat().format(item.amount)}원'
                        : '-',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _statusText(item.status),
                    maxLines: 1,
                    style: TextStyle(
                      color: _statusColor(item.status),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                content: item.detail,
              ),
            ),
          ],
        ),
      );

  _statusText(int status) {
    switch (status) {
      case 0:
        return '신청';

      case 1:
        return '접수';

      case 2:
        return '처리완료';

      default:
        return '신청';
    }
  }

  _statusColor(int status) {
    switch (status) {
      case 0:
        return Colors.red;

      case 1:
        return Colors.yellow;

      case 2:
        return Colors.green;

      default:
        return Colors.red;
    }
  }

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
                      flex: ratio[index],
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
      Collapsible(
        header: _row(
          children: children,
        ),
        body: _collapsibleBody(content),
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
                content.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Flex(
                direction: Axis.vertical,
                children: List.generate(
                  content.detail.length,
                  (index) => _detailItem(
                    content.detail[index],
                  ),
                ),
              ),
            ),
            Text(
              DateFormat('HH:mm').format(content.reservedTime),
            ),
            Text(content.request),
            Divider(
              height: 50,
              color: Colors.grey,
              thickness: 1,
            ),
            Column(
              children: List.generate(
                3,
                (index) => _collapisbleFooter(index, content),
              ),
            )
          ],
        ),
      );

  _collapisbleFooter(int index, HistoryDetailModel content) => Container(
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
                          _popupText(),
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
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "all",
                    child: Container(
                      child: Text(
                        '전체',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      width: 100,
                    ),
                  ),
                  PopupMenuItem(
                    value: "apply",
                    child: Container(
                      child: Text(
                        '신청',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      width: 100,
                    ),
                  ),
                  PopupMenuItem(
                    value: "receipted",
                    child: Container(
                      child: Text(
                        '접수',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      width: 100,
                    ),
                  ),
                  PopupMenuItem(
                    value: "done",
                    child: Container(
                      child: Text(
                        '처리완료',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      width: 100,
                    ),
                  ),
                ],
                onSelected: (value) {
                  selectedPopupMenu = value;
                  list = [...origin]
                      .where((h) => _popupIndex().contains(h.status))
                      .toList();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      );

  _popupText() {
    switch (selectedPopupMenu) {
      case 'all':
        return '전체';

      case 'apply':
        return '신청';

      case 'receipted':
        return '접수';

      case 'done':
        return '처리완료';

      default:
        return '전체';
    }
  }

  List<int> _popupIndex() {
    switch (selectedPopupMenu) {
      case 'all':
        return [0, 1, 2];

      case 'apply':
        return [0];

      case 'receipted':
        return [1];

      case 'done':
        return [2];

      default:
        return [0, 1, 2];
    }
  }
}
