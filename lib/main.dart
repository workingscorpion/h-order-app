import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/app.dart';
import 'package:h_order/store/navigationStore.dart';

void main() async {
  runApp(App(
    key: NavigationStore.instance.appKey,
  ));
}
