import 'package:flutter/material.dart';
import 'package:h_order/constants/customColors.dart';

class Collapsible extends StatefulWidget {
  final Widget header;
  final Widget body;

  Collapsible({
    this.header,
    this.body,
  });

  @override
  _CollapsibleState createState() => _CollapsibleState();
}

class _CollapsibleState extends State<Collapsible> {
  bool collapsed = true;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          collapsed = !collapsed;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: CustomColors.tableInnerBorder,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.header,
              collapsed ? Container() : widget.body ?? Container(),
            ],
          ),
        ),
      );
}
