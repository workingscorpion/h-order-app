import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/serviceButton.dart';
import 'package:h_order/constants/sampleData.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/layout/layoutModel.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/models/homeModel.dart';

class HomeView extends StatefulWidget {
  HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  LayoutModel layouts;
  List<ServiceModel> services;

  HomeModel home;

  @override
  void initState() {
    super.initState();
    home = SampleData.home();
    load();
  }

  load() async {
    layouts = await Client.create().layout();
    services = await Client.create().services();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _menu(),
          _cards(),
          _carousel(),
        ],
      );

  _menu() => Expanded(
        flex: 3,
        child: Container(
          child: Material(
            color: Colors.transparent,
            child: GridView.count(
              padding: EdgeInsets.only(
                top: 40,
                bottom: 40,
                left: 50,
                right: 60,
              ),
              mainAxisSpacing: 20,
              crossAxisCount: 5,
              children: [
                ...services
                    .where((item) =>
                        item.items
                            .singleWhere(
                                (element) => element.type == 'position',
                                orElse: () => null)
                            ?.value !=
                        "bottom")
                    .map((item) => ServiceButton(service: item)),
              ],
            ),
          ),
        ),
      );

  _cards() => Expanded(
        flex: 2,
        child: Container(
          child: ListView(
            padding: EdgeInsets.only(
              top: 24,
              bottom: 24,
              left: 24,
              right: 24,
            ),
            scrollDirection: Axis.horizontal,
            children: [
              ...services
                  .where((item) =>
                      item.items
                          .singleWhere((element) => element.type == 'position',
                              orElse: () => null)
                          ?.value ==
                      "bottom")
                  .map((item) {
                final position = item.items.singleWhere(
                    (element) => element.type == 'position',
                    orElse: () => null);

                final hashTags = position.children
                        ?.singleWhere((element) => element.type == 'hashTag',
                            orElse: () => null)
                        ?.children
                        ?.map((element) => element.value) ??
                    List();

                final businessPeriod = position.children
                        ?.singleWhere(
                            (element) => element.type == 'businessPeriod',
                            orElse: () => null)
                        ?.value ??
                    '';

                return Container(
                  margin: EdgeInsets.only(right: 8),
                  child: AspectRatio(
                    aspectRatio: 1.413 / 1,
                    child: InkWell(
                      onTap: () {
                        AppRouter.toShopPage(service: item);
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
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.fitWidth,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(hashTags.map((e) => '#$e').join(' ')),
                                  Text(businessPeriod),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );

  _carousel() => AspectRatio(
        aspectRatio: 16 / 7,
        child: LayoutBuilder(
          builder: (context, constraint) => CarouselSlider(
            items: [
              ...home.bannerImages.map(
                (item) => Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    item,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: constraint.maxHeight,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 10),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      );
}
