import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:h_order/constants/cardCompanies.dart';
import 'package:h_order/store/paymentStore.dart';

class CardsView extends StatelessWidget {
  CardsView({this.text, this.onTap});

  final String text;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    PaymentStore paymentStore = PaymentStore.instance;

    return Observer(
      builder: (context) => Column(
        children: List.generate(
          paymentStore.cards.length,
          (index) {
            final card = paymentStore.cards[index];
            return _card(
              item: PaymentModel(
                type: 'card',
                index: index,
                image: CardCompanies.cardImageByCode[card.bankCode],
                name: CardCompanies.cardNameByCode[card.bankCode],
                numbers: card.cardLastNumber,
              ),
            );
          },
        ),
      ),
    );
  }

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
                    '**** - **** - **** - ${item.numbers}',
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
                onTap: () => onTap(item.index),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Text(
                    text,
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
}

class PaymentModel {
  final String type;
  final String image;
  final int index;
  final String name;
  final String numbers;

  PaymentModel({
    this.type,
    this.index,
    this.image,
    this.name,
    this.numbers,
  });
}
