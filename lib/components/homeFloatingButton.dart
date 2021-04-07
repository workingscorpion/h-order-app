import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/constants/customColors.dart';

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .12,
      width: MediaQuery.of(context).size.width * .12,
      child: FloatingActionButton(
        backgroundColor: CustomColors.backgroundGrey,
        onPressed: () {
          AppRouter.toHomePage();
        },
        child: Icon(
          CupertinoIcons.house,
          size: 50,
        ),
      ),
    );
  }
}
