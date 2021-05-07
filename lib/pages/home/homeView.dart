import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/components/miniBanner.dart';
import 'package:h_order/components/serviceButton.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/layout/layoutModel.dart';
import 'package:h_order/http/types/service/serviceModel.dart';

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

  Map<String, List<String>> get positions {
    return layout?.positions ?? {};
  }

  @override
  void initState() {
    super.initState();

    load();
  }

  load() async {
    layout = await Client.create().layout();
    services = await Client.create().services();
    serviceMap = services
            ?.asMap()
            ?.map((key, value) => MapEntry(value.objectId, value)) ??
        Map();

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

  _menu() {
    final serviceObjectIds = positions['2'] ?? [];
    final layoutServices = serviceObjectIds?.map((e) => serviceMap[e]) ?? [];

    return Expanded(
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
              ...layoutServices.map((item) => ServiceButton(service: item)),
            ],
          ),
        ),
      ),
    );
  }

  _cards() {
    final serviceObjectIds = positions['3'] ?? [];
    final layoutServices =
        serviceObjectIds?.map((e) => serviceMap[e])?.toList() ?? [];

    if ((layoutServices?.isEmpty ?? true) ||
        (layoutServices?.first?.items?.isEmpty ?? true)) {
      return Spacer(flex: 2);
    }

    final layoutService = layoutServices.first;
    var children = [];

    switch (layoutService.type) {
      case 'Group':
        children = layoutService?.items
                ?.map((item) => serviceMap[item.value])
                ?.map((item) => MiniBanner(service: item))
                ?.toList() ??
            [];
        break;

      case 'Shop':
        children = layoutService?.items
                ?.where((item) => item.type == 'Group')
                ?.map((item) => MiniBanner(item: item))
                ?.toList() ??
            [];
        break;

      case 'Information':
        children = layoutService?.items
                ?.where((item) => item.type == 'Image')
                ?.map((item) => MiniBanner(item: item))
                ?.toList() ??
            [];
        break;
    }

    return Expanded(
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
            ...children,
          ],
        ),
      ),
    );
  }

  _carousel() {
    final serviceObjectIds = positions['4'] ?? [];
    final layoutServices =
        serviceObjectIds?.map((e) => serviceMap[e])?.toList() ?? [];

    if ((layoutServices?.isEmpty ?? true) ||
        (layoutServices?.first?.items?.isEmpty ?? true)) {
      return AspectRatio(
        aspectRatio: 16 / 7,
        child: Container(),
      );
    }

    final layoutService = layoutServices.first;

    return AspectRatio(
      aspectRatio: 16 / 7,
      child: LayoutBuilder(
        builder: (context, constraint) => CarouselSlider(
          items: [
            ...layoutService?.items?.map(
                  (item) => Container(
                    alignment: Alignment.center,
                    child: Image.network(
                      item.value,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ) ??
                [],
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
}
