import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  CreditCard({
    this.cardNumber,
    this.expireYear,
    this.expireMonth,
    this.name,
    this.image,
  });

  final String cardNumber;
  final String expireYear;
  final String expireMonth;
  final String name;
  final String image;

  _cardTextStyle() => TextStyle(
        color: Colors.white,
      );

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          width: 600,
          height: 400,
          decoration: BoxDecoration(
            image: image != null
                ? DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/cards/etc.png'),
                    fit: BoxFit.cover,
                  ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 230,
                left: 100,
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
                top: 230,
                left: 430,
                child: Text(
                  expireMonth.length >= 2 ||
                          (expireYear != "" && expireYear != null)
                      ? '$expireMonth/$expireYear'
                      : expireMonth,
                  style: _cardTextStyle(),
                ),
              ),
              Positioned(
                top: 280,
                left: 100,
                child: Text(
                  name,
                  style: _cardTextStyle(),
                ),
              ),
            ],
          ),
        ),
      );
}
