import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';

class MyView extends StatefulWidget {
  MyView();

  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
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
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            _item(
              title: '내 정보',
              onTap: () {
                AppRouter.toInfoPage();
              },
            ),
            _item(
              title: '결제수단 관리',
              onTap: () {
                AppRouter.toPaymentPage();
              },
            ),
            _item(
              title: '즐겨찾기',
              onTap: () {
                AppRouter.toFavoritePage();
              },
            ),
            _item(
              title: '화면 설정',
              onTap: () {
                AppRouter.toScreenPage();
              },
            ),
            _item(
              title: '알람 설정',
              onTap: () {
                AppRouter.toAlarmPage();
              },
            ),
          ],
        ),
      );

  _item({
    String title,
    void Function() onTap,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                width: 1,
                color: Colors.white24,
              ),
            ),
            child: Row(
              children: [
                Text(title),
              ],
            ),
          ),
        ),
      );
}
