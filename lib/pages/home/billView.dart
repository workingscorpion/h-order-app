import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/collapsible.dart';
import 'package:h_order/models/billModel.dart';
import 'package:intl/intl.dart';

class BillView extends StatefulWidget {
  BillView();

  @override
  _BillViewState createState() => _BillViewState();
}

class _BillViewState extends State<BillView> {
  List<int> ratio = [1, 2, 2, 2, 1, 1, 1];

  List<String> headers = [
    'No.',
    '항목',
    '납부기한',
    '납부일',
    '금액',
    '상태',
    '',
  ];

  String _bankName = '국민은행';
  String _account = '12345-78-9101112';
  String _accountOwner = '리베토코리아';

  List<BillModel> list;

  @override
  void initState() {
    super.initState();

    final max = 30;
    list = List.generate(
      max,
      (index) => BillModel(
        index: max - index,
        title: '서비스명${max - index}',
        expiredDate: DateTime(DateTime.now().year,
            DateTime.now().month + 1 - index, DateTime.now().day - 1),
        paymentDate: DateTime(DateTime.now().year,
            DateTime.now().month + 1 - index, DateTime.now().day),
        amount: index * 1000,
        status: true,
      ),
    );
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
            _accountInfo(),
            _historiesHeader(),
            _historiesBody(),
          ],
        ),
      );

  _accountInfo() => Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 48,
            vertical: 24,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.white24,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '[납부계좌 안내]',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('[$_bankName] $_account $_accountOwner'),
            ],
          ),
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
                  ),
                  Text(
                    item.title,
                    maxLines: 1,
                  ),
                  Text(
                    '${DateFormat('yyyy-MM-dd').format(item.expiredDate)}',
                    maxLines: 1,
                  ),
                  Text(
                    item.status
                        ? '${DateFormat('yyyy-MM-dd').format(item.paymentDate)}'
                        : "-",
                    maxLines: 1,
                  ),
                  Text(
                    '${item.amount}',
                    maxLines: 1,
                  ),
                  Text(
                    item.status ? '납부' : '미납',
                    maxLines: 1,
                    style: TextStyle(
                      color: item.status ? Colors.green : Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      AppRouter.toBillDetailPage();
                    },
                    child: Text('고지서'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

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
  }) =>
      Collapsible(
        header: _row(
          children: children,
        ),
        body: null,
      );
}
