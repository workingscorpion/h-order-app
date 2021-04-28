import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/components/creditCard.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/payment/cardRegisterModel.dart';
import 'package:mobx/mobx.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expireMonthController = TextEditingController();
  TextEditingController _expireYearController = TextEditingController();
  TextEditingController _cardPasswordController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  FocusNode _cardNumberFocusNode = FocusNode();
  FocusNode _expireMonthFocusNode = FocusNode();
  FocusNode _expireYearFocusNode = FocusNode();
  FocusNode _cardPasswordFocusNode = FocusNode();
  FocusNode _birthFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  @observable
  String _cardNumber = '';

  @override
  void initState() {
    _cardNumber = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: Container(
          child: Column(
            children: [
              PageHeader(
                title: ['결제수단 관리'],
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
                                    onTap: () {
                                      showDialog(
                                        // child: _cardInputDialog(),
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _cardInputDialog(),
                                      );
                                    },
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

  _cardInputDialog() => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: _contentBox(),
      );

  _contentBox() => Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CreditCard(cardNumber: _cardNumber),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    _cardNumberInput(),
                    Spacer(),
                    _expireMonthAndYear(),
                  ],
                ),
              ),
            ),
            _cardPassword(),
            _birth(),
            _phone(),
            Row(
              children: [
                _name(),
                Spacer(),
                _email(),
              ],
            ),
            _submit(),
          ],
        ),
      );

  _inputDecoration({String text}) => InputDecoration(
        hintText: text,
        counterText: '',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      );

  _cardNumberInput() => Container(
        margin: EdgeInsets.only(right: 10),
        width: 500,
        child: IntrinsicWidth(
          child: TextField(
            focusNode: _cardNumberFocusNode,
            controller: _cardNumberController,
            decoration: _inputDecoration(text: '카드번호'),
            maxLength: 16,
            onChanged: (text) {
              _cardNumber = text;
              setState(() {});
            },
          ),
        ),
      );

  _expireMonthAndYear() => Container(
        child: IntrinsicWidth(
          child: Row(
            children: [
              Container(
                width: 30,
                child: _expireMonth(),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '/',
                  style: TextStyle(fontSize: 20, height: 2),
                ),
              ),
              Container(
                width: 30,
                child: _expireYear(),
              ),
            ],
          ),
        ),
      );

  _expireMonth() => TextField(
        focusNode: _expireMonthFocusNode,
        controller: _expireMonthController,
        decoration: _inputDecoration(text: '월'),
        maxLengthEnforced: true,
        maxLength: 2,
      );

  _expireYear() => TextField(
        focusNode: _expireYearFocusNode,
        controller: _expireYearController,
        decoration: _inputDecoration(text: '연'),
        maxLengthEnforced: true,
        maxLength: 2,
      );

  _cardPassword() => Container(
        margin: EdgeInsets.only(bottom: 20),
        child: IntrinsicWidth(
          child: TextField(
            obscureText: true,
            focusNode: _cardPasswordFocusNode,
            controller: _cardPasswordController,
            decoration: _inputDecoration(text: '비밀번호'),
            maxLengthEnforced: true,
            maxLength: 4,
          ),
        ),
      );

  _birth() => Container(
        margin: EdgeInsets.only(bottom: 20),
        child: IntrinsicWidth(
          child: TextField(
            focusNode: _birthFocusNode,
            controller: _birthController,
            decoration: _inputDecoration(text: '생일(6자리)'),
            maxLengthEnforced: true,
            maxLength: 6,
          ),
        ),
      );

  _phone() => Container(
        margin: EdgeInsets.only(bottom: 20),
        child: IntrinsicWidth(
          child: TextField(
            focusNode: _phoneFocusNode,
            controller: _phoneController,
            decoration: _inputDecoration(text: '핸드폰'),
            maxLengthEnforced: true,
            maxLength: 11,
          ),
        ),
      );

  _name() => Container(
        margin: EdgeInsets.only(bottom: 20),
        width: 200,
        child: IntrinsicWidth(
          child: TextField(
            focusNode: _nameFocusNode,
            controller: _nameController,
            decoration: _inputDecoration(text: '이름'),
          ),
        ),
      );

  _email() => Container(
        width: 500,
        margin: EdgeInsets.only(bottom: 20),
        child: IntrinsicWidth(
          child: TextField(
            focusNode: _emailFocusNode,
            controller: _emailController,
            decoration: _inputDecoration(text: '이메일'),
          ),
        ),
      );

  _submit() => InkWell(
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '등록',
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () async {
          try {
            final result = await Client.create().cardRegister(CardRegisterModel(
              identity: _birthController.text,
              cardNumber: _cardNumberController.text,
              cardPassword: _cardPasswordController.text,
              expireMonth: _expireMonthController.text,
              expireYear: _expireYearController.text,
              name: _nameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
            ));
          } catch (ex) {
            print(ex.toString());
          }
        },
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
