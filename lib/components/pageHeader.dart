import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';

class PageHeader extends StatelessWidget {
  PageHeader({this.title, this.canBack});

  final String title;
  final bool canBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 40),
          ),
          Spacer(),
          canBack
              ? TextButton(
                  onPressed: () {
                    AppRouter.pop();
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          '뒤로 가기',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_right_2,
                        color: Theme.of(context).textTheme.bodyText2.color,
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
