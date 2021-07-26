import 'package:flutter/material.dart';
import 'package:h_order/constants/customColors.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              margin: EdgeInsets.all(10),
              child: Text(
                '결제 비밀번호 6자리를 입력해주세요',
                style: TextStyle(
                  color: CustomColors.aWhite,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                pinNumber.isEmpty ? 'O O O O O O' : pinNumber,
                style: TextStyle(
                  color: CustomColors.aWhite,
                  fontSize: 20,
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   child: TextButton(
            //     onPressed: () {},
            //     child: Text(
            //       '비밀번호를 잊었어요',
            //       style: TextStyle(
            //         color: CustomColors.aWhite,
            //         decoration: TextDecoration.underline,
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: SizedBox(
                height: 800,
                child: _numberButtons(),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  pinNumber.isEmpty
                      ? Navigator.of(context).pop()
                      : pinNumber =
                          pinNumber.substring(0, pinNumber.length - 1);
                  setState(() {});
                },
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
        ),
      ),
    );
  }

  Widget _numberButtons() {
    return GridView.count(
      padding: EdgeInsets.only(
        top: 30,
      ),
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 3 / 2,
      children: List.generate(
        _numbers.length,
        (index) => _numberButton(
          _numbers[index],
        ),
      ),
    );
  }

  _numberButton(String number) => InkWell(
        onTap: () {
          if (pinNumber.length < 6) {
            pinNumber = pinNumber + number;

            setState(() {});
          }
          if (pinNumber.length == 6) {
            // TODO : API 연결 필요
            print('pinNumber 저장하는 API 호출');
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
}
