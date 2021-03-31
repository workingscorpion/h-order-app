import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/collapsible.dart';
import 'package:h_order/models/historyModel.dart';
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

    origin = List.generate(
      5,
      (index) => HistoryModel(
        index: index + 1,
        serviceName: '서비스명$index',
        createdTime: DateTime.now(),
        summary: '상세항목$index',
        amount: index * 1000,
        status: index % 3,
        detail: '디테일$index',
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
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _popup(),
            _row(
              children: List.generate(
                  headers.length,
                  (index) => Text(
                        headers[index],
                        maxLines: 1,
                      )),
            ),
            Expanded(
              child: ListView(
                children: [
                  ...list.map(
                    (item) => _item(
                      children: [
                        Text(
                          '${item.index}',
                          maxLines: 1,
                        ),
                        Text(
                          item.serviceName != null
                              ? '${item.serviceName}'
                              : '-',
                          maxLines: 1,
                        ),
                        Text(
                          item.summary != null ? '${item.summary}' : '-',
                          maxLines: 1,
                        ),
                        Text(
                          '${DateFormat('yyyy-MM-dd').format(item.createdTime)}',
                          maxLines: 1,
                        ),
                        Text(
                          item.amount != null ? '${item.amount}' : '-',
                          maxLines: 1,
                        ),
                        Text(
                          _statusText(item.status),
                          maxLines: 1,
                          style: TextStyle(color: _statusColor(item.status)),
                        ),
                      ],
                      content: item.detail,
                    ),
                  ),
                ],
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
                          padding: index != children.length - 1
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
    String content,
  }) =>
      Collapsible(
        header: _row(
          children: children,
        ),
        body: _collapsibleBody(content),
      );

  _collapsibleBody(String content) => Container(
        padding: EdgeInsets.all(26),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white12,
            ),
          ),
        ),
        child: Text(
          content != null ? content : '-',
        ),
      );

  _popup() => Row(
        children: [
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(_popupText()),
          ),
          PopupMenuButton(
            child: Icon(CupertinoIcons.ellipsis_circle),
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
              setState(() {
                selectedPopupMenu = value;
                list = [...origin]
                    .where((h) => _popupIndex().contains(h.status))
                    .toList();
              });
            },
          ),
        ],
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
        return List<int>.generate(3, (i) => i);
      case 'apply':
        return List<int>.of([0]);
      case 'receipted':
        return List<int>.of([1]);
      case 'done':
        return List<int>.of([2]);
      default:
        return List<int>.generate(3, (i) => i);
    }
  }
}
