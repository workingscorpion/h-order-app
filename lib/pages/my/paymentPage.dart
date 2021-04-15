import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/components/statusBar.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: Container(
          child: Column(
            children: [
              StatusBar(),
              PageHeader(
                title: '결제수단 관리',
                canBack: true,
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(24),
                        children: [
                          _title(
                            text: '주 계좌',
                          ),
                          Container(
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                              child: Row(
                                children: [
                                  Text('김오더 계좌'),
                                  Text('kb국민은행'),
                                  Text('123456*****1235'),
                                  Spacer(),
                                  _button(text: '수정'),
                                ],
                              ),
                            ),
                          ),
                          Container(height: 12),
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                child: Material(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      alignment: Alignment.center,
                                      width: 200,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        '결제비밀번호 설정',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(width: 24),
                              Container(
                                child: Material(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      alignment: Alignment.center,
                                      width: 200,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        '결제수단 추가',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(height: 32),
                          _title(
                            text: '등록 계좌',
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
                          Container(height: 30),
                          _title(
                            text: '등록 카드',
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
                  ],
                ),
              ),
            ],
          ),
        )),
      );

  _button({
    String text,
  }) =>
      Material(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

  _title({
    String text,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: EdgeInsets.only(bottom: 12),
        child: Text(text),
      );

  _card({
    PaymentModel item,
  }) =>
      Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: Colors.white,
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
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    item.numbers.join('-'),
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color(0xff606162),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Text(
                    '삭제',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
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
