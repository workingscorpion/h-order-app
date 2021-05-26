import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/models/itemModel.dart';

class ShoppingCompletePage extends StatefulWidget {
  ShoppingCompletePage();

  @override
  _ShoppingCompletePageState createState() => _ShoppingCompletePageState();
}

class _ShoppingCompletePageState extends State<ShoppingCompletePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '주문이 완료되었습니다.',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Container(height: 30),
                  Text(
                    '주문하신 매장에서 주문을 수락한 뒤에는 결제취소가 불가합니다.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.black,
            child: InkWell(
              onTap: () {
                _save();
              },
              child: Container(
                height: 80,
                alignment: Alignment.center,
                child: Text(
                  '메인으로',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _save() async {
    AppRouter.toHomePage();
  }
}
