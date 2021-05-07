import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/http/types/service/serviceModel.dart';

class MiniBanner extends StatefulWidget {
  final ServiceModel service;

  MiniBanner({
    this.service,
  }) : super();

  @override
  MiniBannerState createState() => MiniBannerState();
}

class MiniBannerState extends State<MiniBanner> {
  @override
  void initState() {
    super.initState();

    // final position = widget.service.items.singleWhere(
    //     (element) => element.type == 'position',
    //     orElse: () => null);

    // final hashTags = position.children
    //         ?.singleWhere((element) => element.type == 'hashTag',
    //             orElse: () => null)
    //         ?.children
    //         ?.map((element) => element.value) ??
    //     List();

    // final businessPeriod = position.children
    //         ?.singleWhere((element) => element.type == 'businessPeriod',
    //             orElse: () => null)
    //         ?.value ??
    //     '';
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(right: 8),
        child: AspectRatio(
          aspectRatio: 1.413 / 1,
          child: InkWell(
            onTap: () {
              AppRouter.toShopPage(service: widget.service);
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
                    child: Image.network(
                      widget.service.image,
                      fit: BoxFit.cover,
                    ),
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
                          widget.service.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text(hashTags.map((e) => '#$e').join(' ')),
                        // Text(businessPeriod),
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
