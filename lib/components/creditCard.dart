import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  CreditCard({
    this.cardNumber,
    this.expireYear,
    this.expireMonth,
    this.name,
  });

  final String cardNumber;
  final String expireYear;
  final String expireMonth;
  final String name;

  _cardTextStyle() => TextStyle(
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Colors.black.withOpacity(.7),
            offset: Offset(5.0, 5.0),
          ),
        ],
      );

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
              image: DecorationImage(
                image: AssetImage("assets/sample/payment/card_shinhan.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 150,
                  left: 30,
                  child: Row(
                    children: List.generate(
                      4,
                      (index) => Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          cardNumber.substring(index * 4, index * 4 + 4),
                          style: _cardTextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 320,
                  child: Text(
                    expireMonth.length >= 2 ||
                            (expireYear != "" && expireYear != null)
                        ? '$expireMonth/$expireYear'
                        : expireMonth,
                    style: _cardTextStyle(),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 30,
                  child: Text(
                    name,
                    style: _cardTextStyle(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
