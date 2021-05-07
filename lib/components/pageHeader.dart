import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';

class PageHeader extends StatelessWidget {
  final List<String> title;
  final bool canBack;

  PageHeader({
    this.title,
    this.canBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List.generate(
                    (title.length * 2 - 1),
                    (index) {
                      if (index % 2 == 0) {
                        final i = (index / 2).floor();
                        return Text(
                          title[i],
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: index == 0 ? 28 : 20,
                                color: index == 0
                                    ? Colors.black
                                    : Color(0xff606162),
                              ),
                        );
                      }

                      return VerticalDivider(
                        color: Colors.black,
                        width: 24,
                        thickness: .5,
                        indent: 9,
                        endIndent: 6,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          canBack
              ? Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      AppRouter.pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        '뒤로 가기',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
