import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/creditCard.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/payment/cardRegisterModel.dart';
import 'package:h_order/store/paymentStore.dart';
import 'package:h_order/utils/cardGenHelper.dart';

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
  String _expireYear = '';
  String _expireMonth = '';
  String _name = '';

  @override
  void initState() {
    _cardNumber = ' ' * 16;
    super.initState();
  }

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => AppRouter.pop(),
              child: Container(
                child: Icon(CupertinoIcons.xmark),
                alignment: Alignment.centerRight,
              ),
            ),
            CreditCard(
              cardNumber: _cardNumber,
              expireYear: _expireYear,
              expireMonth: _expireMonth,
              name: _name,
              image: CardGenHelper.getCardImage(
                text: CardGenHelper.cardCompanyByCardNumber(_cardNumber),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _cardNumberInput(),
                  ),
                  Container(
                    width: 50,
                  ),
                  Expanded(
                    child: _expireMonthAndYear(),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _cardPassword(),
                  ),
                  Container(
                    width: 50,
                  ),
                  Expanded(
                    child: _birth(),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _phone(),
                  ),
                  Container(
                    width: 50,
                  ),
                  Expanded(
                    flex: 1,
                    child: _nameInput(),
                  ),
                ],
              ),
            ),
            _email(),
            _submit(),
          ],
        ),
      );

  _underlineBoxDecoration() => BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      );

  _inputDecoration({String text, String hint}) => InputDecoration(
        labelText: text,
        hintText: hint ?? '',
        labelStyle: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          height: .8,
          letterSpacing: 0,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counterText: '',
        border: InputBorder.none,
      );

  _cardNumberInput() => Container(
        decoration: _underlineBoxDecoration(),
        margin: EdgeInsets.only(right: 10),
        child: TextFormField(
          focusNode: _cardNumberFocusNode,
          style: TextStyle(letterSpacing: 3.0),
          controller: _cardNumberController,
          decoration: _inputDecoration(text: '카드번호'),
          maxLength: 16,
          onChanged: (String text) {
            _cardNumber = text + (" " * (16 - text.length));

            setState(() {});
          },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_expireMonthFocusNode);
          },
        ),
      );

  _expireMonthAndYear() => Container(
        decoration: _underlineBoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              child: _expireMonthInput(),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '/',
                style: TextStyle(fontSize: 20, height: 2.5),
              ),
            ),
            Container(
              width: 60,
              child: _expireYearInput(),
            ),
          ],
        ),
      );

  _expireMonthInput() => TextFormField(
        focusNode: _expireMonthFocusNode,
        controller: _expireMonthController,
        decoration: _inputDecoration(text: '유효기간', hint: 'MM'),
        maxLengthEnforced: true,
        style: TextStyle(letterSpacing: 3.0),
        textAlign: TextAlign.center,
        maxLength: 2,
        onChanged: (String text) {
          _expireMonth = text;
          // _expireMonth = text + (" " * (2 - text.length));
          setState(() {});
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(_expireYearFocusNode);
        },
      );

  _expireYearInput() => TextFormField(
        focusNode: _expireYearFocusNode,
        controller: _expireYearController,
        decoration: _inputDecoration(text: '', hint: 'YY'),
        maxLengthEnforced: true,
        style: TextStyle(letterSpacing: 3.0),
        textAlign: TextAlign.center,
        maxLength: 2,
        onChanged: (String text) {
          _expireYear = text;
          setState(() {});
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(_cardPasswordFocusNode);
        },
      );

  _cardPassword() => Container(
        decoration: _underlineBoxDecoration(),
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          obscureText: true,
          focusNode: _cardPasswordFocusNode,
          style: TextStyle(letterSpacing: 3.0),
          controller: _cardPasswordController,
          decoration: _inputDecoration(text: '비밀번호'),
          maxLengthEnforced: true,
          maxLength: 4,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_birthFocusNode);
          },
        ),
      );

  _birth() => Container(
        decoration: _underlineBoxDecoration(),
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          focusNode: _birthFocusNode,
          style: TextStyle(letterSpacing: 3.0),
          controller: _birthController,
          decoration: _inputDecoration(text: '생년월일(6자리)'),
          maxLengthEnforced: true,
          maxLength: 6,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_phoneFocusNode);
          },
        ),
      );

  _phone() => Container(
        decoration: _underlineBoxDecoration(),
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          focusNode: _phoneFocusNode,
          style: TextStyle(letterSpacing: 3.0),
          controller: _phoneController,
          decoration: _inputDecoration(text: '휴대폰번호'),
          maxLengthEnforced: true,
          maxLength: 11,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_nameFocusNode);
          },
        ),
      );

  _nameInput() => Container(
        decoration: _underlineBoxDecoration(),
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          focusNode: _nameFocusNode,
          controller: _nameController,
          decoration: _inputDecoration(text: '이름'),
          onChanged: (String text) {
            _name = text;
            setState(() {});
          },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_emailFocusNode);
          },
        ),
      );

  _email() => Container(
        decoration: _underlineBoxDecoration(),
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          focusNode: _emailFocusNode,
          controller: _emailController,
          decoration: _inputDecoration(text: '이메일'),
          onEditingComplete: () {
            _submit();
          },
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
            await Client.create().cardRegister(CardRegisterModel(
              identity: _birthController.text,
              cardNumber: _cardNumberController.text,
              cardPassword: _cardPasswordController.text,
              expireMonth: _expireMonthController.text,
              expireYear: _expireYearController.text,
              name: _nameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
            ));

            await PaymentStore.instance.loadCards();

            AppRouter.pop();
          } catch (ex) {
            var message = '카드를 등록할 수 없습니다.';

            if (ex is DioError) {
              if (ex.response.statusCode == 409) {
                message = '이미 등록된 카드입니다.';
              }
            }

            await Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.66),
              textColor: Theme.of(context).textTheme.bodyText1.color,
              fontSize: 17,
            );
          }
        },
      );
}
