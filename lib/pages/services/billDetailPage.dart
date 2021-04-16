import 'package:flutter/material.dart';
import 'package:h_order/components/pageHeader.dart';

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
          PageHeader(
            title: ['관리비 내역', '고지서'],
            canBack: true,
          ),
          Expanded(
            child: ListView(
              children: [
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Image.asset(
                      'assets/sample/billSample.png',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
