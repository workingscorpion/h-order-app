import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:h_order/constants/cardCompanies.dart';
import 'package:h_order/models/paymentMethodModel.dart';
import 'package:h_order/store/paymentStore.dart';
import 'package:mobx/mobx.dart';

class CardsView extends StatelessWidget {
  final String text;
  final Function(int) onTap;

  CardsView({
    this.text,
    this.onTap,
  });

  bool get isChangeMode {
    return PaymentStore.instance.changeMode;
  }

  ObservableList<PaymentMethodModel> get cards {
    return PaymentStore.instance.cards;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Column(
        children: List.generate(
          cards?.length ?? 0,
          (index) => _card(
            item: PaymentModel(
              type: 'card',
              index: index,
              itemIndex: cards[index].index,
              image: CardCompanies.cardImageByCode[cards[index].bankCode],
              name: CardCompanies.cardNameByCode[cards[index].bankCode],
              numbers: cards[index].cardLastNumber,
              isPrimary: cards[index].isPrimary,
            ),
          ),
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
        child: Observer(
          builder: (BuildContext context) {
            return Row(
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
                    onTap: () async => isChangeMode
                        ? await PaymentStore.instance
                            .updatePrimary(item.itemIndex.toString())
                        : onTap(item.index),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Text(
                        isChangeMode ? '선택' : text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
}

class PaymentModel {
  final String type;
  final String image;
  final int itemIndex;
  final int index;
  final String name;
  final String numbers;
  final bool isPrimary;

  PaymentModel({
    this.type,
    this.index,
    this.itemIndex,
    this.image,
    this.name,
    this.numbers,
    this.isPrimary,
  });
}
