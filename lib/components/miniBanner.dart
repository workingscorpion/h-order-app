import 'package:flutter/material.dart';
import 'package:h_order/components/serviceButton.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/models/itemModel.dart';

class MiniBanner extends StatefulWidget {
  final ItemModel item;
  final ServiceModel service;

  MiniBanner({
    this.item,
    this.service,
  }) : super();

  @override
  MiniBannerState createState() => MiniBannerState();
}

class MiniBannerState extends State<MiniBanner> {
  String get name {
    return widget.service?.name;
  }

  String get image {
    return widget.item != null ? widget.item?.value : widget.service?.image;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(right: 8),
        child: AspectRatio(
          aspectRatio: 1.413 / 1,
          child: InkWell(
            onTap: () async {
              if (widget.service != null) {
                ServiceButtonState.openService(
                  context: context,
                  service: widget.service,
                );
              }
            },
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: (image?.isNotEmpty ?? false)
                        ? Image.network(
                            image,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Container(
                    color: Colors.black38,
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 24,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
