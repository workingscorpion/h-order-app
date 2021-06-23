import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/collapsible.dart';
import 'package:h_order/components/spin.dart';
import 'package:h_order/components/viewHeader.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:h_order/store/billStore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';

class BillView extends StatefulWidget {
  BillView();

  @override
  _BillViewState createState() => _BillViewState();
}

class _BillViewState extends State<BillView> {
  BillStore billStore = BillStore.instance;

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

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    await billStore.load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Container(
        // padding: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/commontown.svg',
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(top: 70, bottom: 50),
              child: Text(
                '커먼타운 앱에서 확인해주세요.',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "커먼타운 앱 내 'MY' >> '계약/결제' >> '월별 청구서 조회'",
              style: TextStyle(
                fontSize: 23,
                color: CustomColors.addtionalInformationColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     _accountInfo(),
        //     DefaultTextStyle(
        //       style: TextStyle(
        //         fontSize: 17,
        //         color: Colors.black,
        //       ),
        //       child: _histories(),
        //     ),
        //   ],
        // ),
      );

  _accountInfo() => DefaultTextStyle(
        style: TextStyle(
          fontSize: 17,
          color: Theme.of(context).primaryColor,
        ),
        child: Container(
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
                  ),
                ),
                Text(
                  '[$_bankName] $_account $_accountOwner',
                ),
              ],
            ),
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
        child: Observer(
          builder: (BuildContext context) {
            return billStore.loading
                ? Center(
                    child: Spin(
                      size: 30,
                    ),
                  )
                : billStore.bills.length > 0
                    ? ListView(
                        children: [
                          ...(billStore.bills ?? ObservableList())?.map(
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
                                  '${DateFormat('yyyy-MM-dd').format(item.deadline)}',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  item.paymentDate != null
                                      ? '${DateFormat('yyyy-MM-dd').format(item.paymentDate)}'
                                      : "-",
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
                                  item.paymentDate != null ? '납부' : '미납',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: item.paymentDate != null
                                        ? Color(0xff21d021)
                                        : Color(0xffe02020),
                                  ),
                                ),
                                Container(
                                  height: 24,
                                  child: FlatButton(
                                    color: Theme.of(context).accentColor,
                                    onPressed: () {
                                      AppRouter.toBillDetailPage(item.contents);
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
                      );
          },
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
