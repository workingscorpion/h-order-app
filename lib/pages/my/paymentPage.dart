import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedIndex;
  List<PaymentModel> list = List();

  final _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('결제수단 관리'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(24),
                  children: [
                    _title(
                      text: '등록계좌',
                    ),
                    ...List.generate(
                      2,
                      (index) => _card(
                        item: PaymentModel(
                          type: 'account',
                          image: 'assets/sample/payment/bank_kb.jpg',
                          name: 'KB국민은행',
                          numbers: ['****', '1234'],
                        ),
                      ),
                    ),
                    _title(
                      text: '등록카드',
                    ),
                    ...List.generate(
                      5,
                      (index) => _card(
                        item: PaymentModel(
                          type: 'type',
                          image: 'assets/sample/payment/card_kakao.png',
                          name: '카카오뱅크 카드',
                          numbers: ['****', '****', '****', '1234'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        onPressed: () {},
                        child: Text('결제비밀번호 설정'),
                      ),
                    ),
                    Container(width: 24),
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        onPressed: () {},
                        child: Text('결제수단 추가'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  _title({
    String text,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 24),
        child: Text(text),
      );

  _card({
    PaymentModel item,
  }) =>
      Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: EdgeInsets.only(right: 24),
              width: 200,
              child: AspectRatio(
                aspectRatio: 8.56 / 5.398,
                child: Image.asset(
                  item.image,
                ),
              ),
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                  ),
                  Text(
                    item.numbers.join('-'),
                  ),
                ],
              ),
            ),
            Spacer(),
            FlatButton(
              onPressed: () {},
              child: Text('삭제'),
            ),
          ],
        ),
      );
}

class PaymentModel {
  final String type;
  final String image;
  final String name;
  final List<String> numbers;

  PaymentModel({
    this.type,
    this.image,
    this.name,
    this.numbers,
  });
}
