import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/collapsible.dart';
import 'package:h_order/components/viewHeader.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/models/billModel.dart';
import 'package:intl/intl.dart';

class BillView extends StatefulWidget {
  BillView();

  @override
  _BillViewState createState() => _BillViewState();
}

class _BillViewState extends State<BillView> {
  List<int> ratio = [1, 2, 2, 2, 2, 1, 1];

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
        title: '${_calcExpiredDate(index).month}월분 고지서',
        expiredDate: _calcExpiredDate(index),
        paymentDate: DateTime(
          DateTime.now().year,
          DateTime.now().month - index,
          DateTime.now().day + 12,
        ),
        amount: (index + 10) * 1000,
        status: max - index >= max ? false : true,
      ),
    );
  }

  _calcExpiredDate(int index) {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month + 1 - index,
      DateTime.now().day - 1,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _accountInfo(),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
              child: _histories(),
            ),
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
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: Theme.of(context).accentColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '[납부계좌 안내]',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                '[$_bankName] $_account $_accountOwner',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      );

  _histories() => Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ViewHeader(text: '관리비 내역'),
                  Spacer(),
                ],
              ),
              _bill(),
            ],
          ),
        ),
      );

  _bill() => Expanded(
        child: IntrinsicHeight(
          child: Container(
            child: Column(
              children: [
                _billHeader(),
                _billBody(),
              ],
            ),
          ),
        ),
      );

  _billHeader() => DefaultTextStyle(
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        child: Container(
          color: Theme.of(context).accentColor,
          child: _row(
            children: List.generate(
              headers.length,
              (index) => Text(
                headers[index],
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );

  _billBody() => Expanded(
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
                    item.title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${DateFormat('yyyy-MM-dd').format(item.expiredDate)}',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    item.status
                        ? '${DateFormat('yyyy-MM-dd').format(item.paymentDate)}'
                        : "-",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${NumberFormat().format(item.amount)}원',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    item.status ? '납부' : '미납',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 24,
                    child: FlatButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        AppRouter.toBillDetailPage();
                      },
                      child: Text(
                        '고지서',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
      Container(
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
