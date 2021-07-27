import 'package:flutter/material.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/payment/paymentPinModel.dart';

class PaymentPinDialog extends StatefulWidget {
  PaymentPinDialog();

  @override
  _PaymentPinDialogState createState() => _PaymentPinDialogState();
}

class _PaymentPinDialogState extends State<PaymentPinDialog> {
  final List<String> _numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];

  String pinNumber = '';

  @override
  void initState() {
    _numbers.shuffle();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: CustomColors.backgroundDarkGrey,
      child: contents(context),
    );
  }

  contents(BuildContext context) => IntrinsicHeight(
        child: Container(
          child: Column(
            children: [
              title(),
              password(),
              _numberButtons(),
              actions(),
            ],
          ),
        ),
      );

  title() => Container(
        margin: EdgeInsets.only(
          top: 50,
        ),
        child: Text(
          '결제 비밀번호 6자리를 입력해주세요',
          style: TextStyle(
            color: CustomColors.aWhite,
            fontSize: 25,
          ),
        ),
      );

  password() => Container(
        margin: EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) => _blankContainer(5 - index),
          ),
        ),
      );

  _blankContainer(index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.only(
        bottom: 3,
        left: 5,
        right: 5,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomColors.aWhite,
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        5 - pinNumber.split('').length < index ? '*' : ' ',
        style: TextStyle(
          color: CustomColors.aWhite,
          fontSize: 30,
          letterSpacing: 15,
        ),
      ),
    );
  }

  Widget _numberButtons() {
    return Container(
      height: 600,
      child: GridView.count(
        padding: EdgeInsets.only(
          top: 60,
        ),
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 4 / 2,
        children: List.generate(
          _numbers.length,
          (index) => _numberButton(
            _numbers[index],
          ),
        ),
      ),
    );
  }

  _numberButton(String number) => InkWell(
        onTap: () async {
          if (pinNumber.length < 6) {
            pinNumber = pinNumber + number;

            setState(() {});
          }

          if (pinNumber.length == 6) {
            final pin = PaymentPinModel(pinNumber: pinNumber);
            await Client.create().pinRegister(pin);
            Navigator.of(context).pop();
            showToast();
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: CustomColors.aWhite,
              fontSize: 25,
            ),
          ),
        ),
      );

  actions() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 30,
              bottom: 10,
            ),
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {},
              child: Text(
                '비밀번호를 잊었어요',
                style: TextStyle(
                  color: CustomColors.aWhite,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: 30,
              bottom: 10,
            ),
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => delete(),
              child: Text(
                pinNumber.isEmpty ? '취소' : '삭제',
                style: TextStyle(
                  color: CustomColors.aWhite,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      );

  showToast() async {
    await Fluttertoast.showToast(
      msg: '결제 비밀번호가 저장되었습니다.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Theme.of(context).accentColor.withOpacity(0.66),
      textColor: Theme.of(context).textTheme.bodyText1.color,
      fontSize: 17,
    );
  }

  delete() {
    pinNumber = (pinNumber.split("")..removeLast()).join('');
    setState(() {});
  }
}
