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
  PaymentStore paymentStore = PaymentStore.instance;
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
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                  _cardNumberInput(),
                  Spacer(),
                  _expireMonthAndYear(),
                ],
              ),
            ),
            _cardPassword(),
            _birth(),
            _phone(),
            _nameInput(),
            _email(),
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
        child: TextField(
          focusNode: _cardNumberFocusNode,
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
        child: Row(
          children: [
            Container(
              width: 30,
              child: _expireMonthInput(),
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
              child: _expireYearInput(),
            ),
          ],
        ),
      );

  _expireMonthInput() => TextField(
        focusNode: _expireMonthFocusNode,
        controller: _expireMonthController,
        decoration: _inputDecoration(text: '월'),
        maxLengthEnforced: true,
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

  _expireYearInput() => TextField(
        focusNode: _expireYearFocusNode,
        controller: _expireYearController,
        decoration: _inputDecoration(text: '연'),
        maxLengthEnforced: true,
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
        margin: EdgeInsets.only(bottom: 20),
        child: TextField(
          obscureText: true,
          focusNode: _cardPasswordFocusNode,
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
        margin: EdgeInsets.only(bottom: 20),
        child: TextField(
          focusNode: _birthFocusNode,
          controller: _birthController,
          decoration: _inputDecoration(text: '생일(6자리)'),
          maxLengthEnforced: true,
          maxLength: 6,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_phoneFocusNode);
          },
        ),
      );

  _phone() => Container(
        margin: EdgeInsets.only(bottom: 20),
        child: TextField(
          focusNode: _phoneFocusNode,
          controller: _phoneController,
          decoration: _inputDecoration(text: '핸드폰'),
          maxLengthEnforced: true,
          maxLength: 11,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_nameFocusNode);
          },
        ),
      );

  _nameInput() => Container(
        margin: EdgeInsets.only(bottom: 20),
        child: TextField(
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
        margin: EdgeInsets.only(bottom: 20),
        child: TextField(
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
            await paymentStore.loadCards();
            AppRouter.pop();
          } catch (ex) {
            print(ex.toString());
            await Fluttertoast.showToast(
              msg: "카드를 등록할 수 없습니다.",
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
