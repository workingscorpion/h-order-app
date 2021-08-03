import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:package_info/package_info.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyView extends StatefulWidget {
  MyView();

  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  String versionNumber = '';

  @override
  void initState() {
    _getVersion();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionNumber = packageInfo.version;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Container(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(24),
              children: [
                _item(
                  title: '내 정보',
                  onTap: () {
                    // AppRouter.toInfoPage();
                    showToast();
                  },
                ),
                _item(
                  title: '결제수단 관리',
                  onTap: () {
                    // AppRouter.toPaymentPage();
                    showToast();
                  },
                ),
                _item(
                  title: '즐겨찾기',
                  onTap: () {
                    // AppRouter.toFavoritePage();
                    showToast();
                  },
                ),
                _item(
                  title: '화면 설정',
                  onTap: () {
                    // AppRouter.toScreenPage();
                    showToast();
                  },
                ),
                _item(
                  title: '알람 설정',
                  onTap: () {
                    // AppRouter.toAlarmPage();
                    showToast();
                  },
                ),
                _item(
                  title: '약관',
                  onTap: () {
                    AppRouter.toTermsPage();
                  },
                ),
                _item(
                  title: '사업자 정보',
                  onTap: () {
                    AppRouter.toBusinessPage();
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text('Version: $versionNumber'),
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
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              child: Row(
                children: [
                  Text(title),
                  Spacer(),
                  Icon(
                    CupertinoIcons.chevron_right_2,
                    size: 20,
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  showToast() async {
    await Fluttertoast.showToast(
      msg: '준비 중입니다.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Theme.of(context).accentColor.withOpacity(0.66),
      textColor: Theme.of(context).textTheme.bodyText1.color,
      fontSize: 17,
    );
  }
}
