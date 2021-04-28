import 'package:flutter/material.dart';
import 'package:h_order/components/creditCard.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/payment/cardRegisterModel.dart';

class PaymentDialog extends StatefulWidget {
  PaymentDialog({Key key}) : super(key: key);

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
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

  String _cardNumber = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: _contentBox(),
    );
  }

  _contentBox() => Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: IntrinsicHeight(
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
              _name(),
              _email(),
              _submit(),
            ],
          ),
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
