import 'package:flutter/material.dart';

class BillDetailPage extends StatefulWidget {
  BillDetailPage({Key key}) : super(key: key);

  @override
  _BillDetailPageState createState() => _BillDetailPageState();
}

class _BillDetailPageState extends State<BillDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _pageHeader(),
        ],
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
            onTap: () {},
            child: Text('목록보기 >'),
          ),
        ],
      );
}
