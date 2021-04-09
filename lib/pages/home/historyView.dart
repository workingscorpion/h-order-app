import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/collapsible.dart';
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

  List<int> ratio = [1, 2, 2, 2, 1, 1];

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _popup(),
            _historiesHeader(),
            _historiesBody(),
          ],
        ),
      );

  _historiesHeader() => Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: _row(
          children: List.generate(
            headers.length,
            (index) => Text(
              headers[index],
              maxLines: 1,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      );

  _historiesBody() => Expanded(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            ...list.map(
              (item) => _item(
                children: [
                  Text(
                    '${item.index}',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    item.serviceName != null ? '${item.serviceName}' : '-',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    item.summary != null ? '${item.summary}' : '-',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${DateFormat('yyyy-MM-dd').format(item.createdTime)}',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    item.amount != null
                        ? '${NumberFormat().format(item.amount)}'
                        : '-',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    _statusText(item.status),
                    maxLines: 1,
                    style: TextStyle(
                      color: _statusColor(item.status),
                      fontSize: 20,
                    ),
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
    List<Widget> children,
  }) =>
      DefaultTextStyle(
        style: TextStyle(
          fontSize: 24,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
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
          border: Border(
            top: BorderSide(
              color: Colors.white12,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Text(content.title),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
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

  _collapisbleFooter(int index, HistoryDetailModel content) => Row(
        children: [
          Text(_footerText(index)),
          Spacer(),
          _footerValue(index, content),
        ],
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

  _detailItem(KeyValueModel item) => Row(
        children: [
          Text('• ${item.key} ${item.value}개'),
          Spacer(),
          Text('${NumberFormat().format(item.price)}원'),
        ],
      );

  _popup() => Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        child: Row(
          children: [
            Spacer(),
            PopupMenuButton(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Text(_popupText()),
                  ),
                  Icon(CupertinoIcons.ellipsis_circle),
                ],
              ),
              padding: EdgeInsets.zero,
              offset: Offset(-24, 0),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "all",
                  child: Text('전체'),
                ),
                PopupMenuItem(
                  value: "apply",
                  child: Text('신청'),
                ),
                PopupMenuItem(
                  value: "receipted",
                  child: Text('접수'),
                ),
                PopupMenuItem(
                  value: "done",
                  child: Text('처리완료'),
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
