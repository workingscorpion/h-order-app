import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/alertService.dart';
import 'package:intl/intl.dart';

class ServiceButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final List<ServiceItem> items;
  final GestureTapCallback onTap;

  ServiceButton({
    this.icon,
    this.label,
    this.items,
    this.onTap,
  });

  @override
  _ServiceButtonState createState() => _ServiceButtonState();
}

class _ServiceButtonState extends State<ServiceButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: InkWell(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap();
          } else {
            _alert(
              title: widget.label,
              items: widget.items,
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Icon(
                widget.icon,
                size: 64,
              ),
            ),
            Text(
              widget.label ?? '',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _alert({
    String title,
    List<ServiceItem> items,
  }) async {
    final result = await showDialog(
      barrierColor: Colors.black.withOpacity(.85),
      context: context,
      child: AlertDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        clipBehavior: Clip.antiAlias,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        title: Container(
          decoration: BoxDecoration(
            color: Color(0xf0f9f9f9),
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color(0x22000000),
              ),
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(CupertinoIcons.xmark),
                    iconSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        content: AlertService(
          icon: widget.icon,
          label: widget.label,
          items: widget.items,
        ),
      ),
    );

    print(result);
  }
}

class ServiceItem {
  final String objectId;
  final String type;
  final String label;
  final int max;
  final List<ServiceItem> children;

  ServiceItem({
    this.objectId,
    this.type,
    this.label,
    this.max,
    this.children,
  });
}
