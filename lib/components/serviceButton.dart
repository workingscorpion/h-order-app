import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/alertService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/service/serviceModel.dart';

class ServiceButton extends StatefulWidget {
  final ServiceModel service;
  final GestureTapCallback onTap;
  final Color color;

  ServiceButton({
    this.service,
    this.onTap,
    this.color,
  });

  @override
  ServiceButtonState createState() => ServiceButtonState();
}

class ServiceButtonState extends State<ServiceButton> {
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
            return;
          }

          ServiceButtonState.openService(
            context: context,
            service: widget.service,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 92,
              width: 92,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10),
              child: Stack(
                children: [
                  Container(
                    child: (widget.service.image?.isNotEmpty ?? false)
                        ? Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Image.network(
                              widget.service.image,
                            ),
                          )
                        : Container(),
                  ),
                  (widget.service.processing ?? false)
                      ? Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            alignment: Alignment.center,
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Text(
                              '${widget.service.status?.length ?? 0}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Text(
              widget.service.name ?? '',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static openService({
    BuildContext context,
    ServiceModel service,
  }) async {
    final _service = await Client.create().service(service.objectId);

    switch (_service.type) {
      case 'Information':
        AppRouter.toInformationPage(service: _service);
        return;

      case 'Shop':
        AppRouter.toShopPage(service: _service);
        return;

      case 'Call':
        alert(context: context, service: _service);
        return;
    }
  }

  static alert({
    BuildContext context,
    ServiceModel service,
  }) async {
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
      final resultMessage = service?.items
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
