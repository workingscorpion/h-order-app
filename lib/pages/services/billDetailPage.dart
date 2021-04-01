import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/clock.dart';

class BillDetailPage extends StatefulWidget {
  BillDetailPage({Key key}) : super(key: key);

  @override
  _BillDetailPageState createState() => _BillDetailPageState();
}

class _BillDetailPageState extends State<BillDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Clock(),
              _pageHeader(),
              Divider(
                color: Colors.white,
                height: 20,
                thickness: 1,
              ),
              Expanded(
                child: Image.asset(
                  'assets/sample/sample2.png',
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _pageHeader() => Row(
        children: [
          Text(
            '관리비 내역 > 고지서',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              AppRouter.pop();
            },
            child: Text('목록보기 >'),
          ),
        ],
      );
}
