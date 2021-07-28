import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:h_order/components/cardsView.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/components/paymentDialog.dart';
import 'package:h_order/constants/cardCompanies.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/models/paymentMethodModel.dart';
import 'package:h_order/store/paymentStore.dart';
import 'package:h_order/components/paymentPinDialog.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethodModel get primaryMethod {
    return (PaymentStore.instance.cards?.isNotEmpty ?? false)
        ? PaymentStore.instance.cards
            .where((element) => element.isPrimary)
            .first
        : null;
  }

  @override
  void initState() {
    super.initState();

    load();
  }

  load() async {
    await PaymentStore.instance.loadCards();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                PageHeader(
                  title: ['결제수단 관리'],
                  canBack: true,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(24),
                          children: [
                            _title(
                              text: '주 결제 수단',
                            ),
                            Observer(
                              builder: (context) => Container(
                                padding: EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                  child: primaryMethod != null
                                      ? Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                CardCompanies.cardNameByCode[
                                                    primaryMethod.bankCode],
                                              ),
                                            ),
                                            Text(
                                                '**** - **** - **** - ${primaryMethod.cardLastNumber}'),
                                            Spacer(),
                                            _button(text: '수정'),
                                          ],
                                        )
                                      : Text('미설정'),
                                ),
                              ),
                            ),
                            Container(height: 12),
                            Row(
                              children: [
                                Spacer(),
                                Container(
                                  child: Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              PaymentPinDialog(
                                            routeFrom: true,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        alignment: Alignment.center,
                                        width: 200,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          '결제비밀번호 설정',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(width: 24),
                                Container(
                                  child: Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          child: PaymentDialog(),
                                          context: context,
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        alignment: Alignment.center,
                                        width: 200,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          '결제수단 추가',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(height: 30),
                            _title(
                              text: '등록 카드',
                            ),
                            CardsView(
                              text: '삭제',
                              onTap: (index) async {
                                // PaymentStore.instance.deleteCard(index);
                                try {
                                  await Client.create().deleteCard(
                                    PaymentStore.instance.cards[index].index
                                        .toString(),
                                  );
                                } catch (e) {} finally {
                                  await PaymentStore.instance.loadCards();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  _button({
    String text,
  }) =>
      Material(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

  _title({
    String text,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: EdgeInsets.only(bottom: 12),
        child: Text(text),
      );
}
