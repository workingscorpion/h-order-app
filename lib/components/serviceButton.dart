import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/alertService.dart';
import 'package:h_order/constants/serviceStatus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/service/serviceModel.dart';

class ServiceButton extends StatefulWidget {
  final ServiceModel service;
  final ServiceStatus status;
  final GestureTapCallback onTap;
  final Color color;

  ServiceButton({
    this.service,
    this.status,
    this.onTap,
    this.color,
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
        onTap: () async {
          if (widget.onTap != null) {
            widget.onTap();
            return;
          }

          final service =
              await Client.create().service(widget.service.objectId);

          switch (widget.service.type) {
            case 'Shop':
              AppRouter.toShopPage(service: service);
              return;

            case 'Call':
              _alert(service);
              return;
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              height: 92,
              width: 92,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10),
              child: Container(
                child: (widget.service.image?.isNotEmpty ?? false)
                    ? Image.network(
                        widget.service.image,
                      )
                    : Container(),
              ),
            ),
            Text(
              widget.service.name ?? '',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            widget.status != null
                ? Text(
                    _serviceStatusText(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _serviceStatusText() {
    switch (widget.status) {
      case ServiceStatus.Call:
        return '호출중';

      case ServiceStatus.Doing:
        return '처리중';

      default:
        return '기타';
    }
  }

  _alert(ServiceModel service) async {
    await Fluttertoast.cancel();

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
        content: AlertService(service: service),
      ),
    );

    if (result != null) {
      final resultMessage = widget.service?.items
              ?.singleWhere(
                (item) => item.type == 'resultMessage',
                orElse: () => null,
              )
              ?.value ??
          '신청되었습니다.';

      await Fluttertoast.showToast(
        msg: "   $resultMessage   ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.66),
        textColor: Theme.of(context).textTheme.bodyText1.color,
        fontSize: 17,
      );
    }
  }
}
