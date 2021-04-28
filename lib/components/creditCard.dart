import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  CreditCard({this.cardNumber});

  final String cardNumber;
  // const CreditCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        margin: EdgeInsets.only(bottom: 20),
        child: AspectRatio(
          aspectRatio: 1.586,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Column(
              children: [
                Text(cardNumber),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
