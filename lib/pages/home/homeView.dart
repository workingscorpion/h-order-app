import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/miniBanner.dart';
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
  LayoutModel layout;
  List<ServiceModel> services;
  Map<String, ServiceModel> serviceMap;

  HomeModel home;

  @override
  void initState() {
    super.initState();
    home = SampleData.home();

    load();
  }

  load() async {
    layout = await Client.create().layout();
    services = await Client.create().services();
    serviceMap =
        services.asMap().map((key, value) => MapEntry(value.objectId, value));

    setState(() {});
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
                ...layout != null
                    ? layout.positions['2']
                        .map((e) => serviceMap[e])
                        .map((item) => ServiceButton(service: item))
                    : [],
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
              ...layout != null
                  ? layout.positions['3']
                      .map((e) => serviceMap[e])
                      .map((item) => MiniBanner(service: item))
                  : [],
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
