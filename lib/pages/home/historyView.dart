import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  HistoryView();

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  FocusNode focusNode;
  String selectedPopupMenu = 'all';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _popup(),
          ],
        ),
      );

  _popup() => Row(
        children: [
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(_popupText()),
          ),
          PopupMenuButton(
            child: Icon(CupertinoIcons.ellipsis_circle),
            padding: EdgeInsets.zero,
            offset: Offset(-24, 0),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "all",
                child: Text('전체'),
              ),
              PopupMenuItem(
                value: "apply",
                child: Text('신청'),
              ),
              PopupMenuItem(
                value: "receipted",
                child: Text('접수'),
              ),
              PopupMenuItem(
                value: "done",
                child: Text('처리완료'),
              ),
            ],
            onSelected: (value) {
              setState(() {
                selectedPopupMenu = value;
              });
            },
          ),
        ],
      );

  _popupText() {
    switch (selectedPopupMenu) {
      case 'all':
        return '전체';
      case 'apply':
        return '신청';
      case 'receipted':
        return '접수';
      case 'done':
        return '처리완료';
    }
  }
}
