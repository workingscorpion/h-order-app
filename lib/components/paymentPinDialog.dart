import 'package:flutter/material.dart';
import 'package:h_order/constants/customColors.dart';

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
    '9'
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: CustomColors.backgroundDarkGrey,
      child: passwordInput(context),
    );
  }

  passwordInput(context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  '취소',
                  style: TextStyle(
                    color: CustomColors.dialogText,
                  ),
                ),
              ),
            ),
            Text(
              '결제 비밀번호 6자리를 입력해주세요',
              style: TextStyle(
                color: CustomColors.aWhite,
              ),
            ),
            Text('입력한 비번 들어갈 자리'),
            ..._numbers.map((e) {
              return _numberButtons(e);
            })
          ],
        ),
      ),
    );
  }

  Widget _numberButtons(String number) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          _numbers.length,
          (index) => _numberButton(
            _numbers[index],
          ),
        ),
      ),
    );
  }

  _numberButton(String number) => Expanded(
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                color: CustomColors.aWhite,
                fontSize: 25,
              ),
            ),
          ),
        ),
      );
}
