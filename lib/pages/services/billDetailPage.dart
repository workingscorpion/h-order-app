import 'package:flutter/material.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/components/webViewContent.dart';

class BillDetailPage extends StatefulWidget {
  BillDetailPage({this.contents});

  final String contents;

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
            child: IntrinsicHeight(
              child: WebViewContent(
                contents: widget.contents,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
