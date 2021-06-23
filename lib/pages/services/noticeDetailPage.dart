import 'package:flutter/material.dart';
import 'package:h_order/components/pageHeader.dart';
import 'package:h_order/components/webViewContent.dart';

class NoticeDetailPage extends StatefulWidget {
  NoticeDetailPage({this.contents});

  final String contents;

  @override
  _NoticeDetailPageState createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageHeader(
            title: ['공지사항', '상세보기'],
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
