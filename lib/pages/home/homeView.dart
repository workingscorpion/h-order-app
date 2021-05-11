import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:h_order/components/miniBanner.dart';
import 'package:h_order/components/serviceButton.dart';
import 'package:h_order/http/types/layout/layoutModel.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/store/layoutStore.dart';
import 'package:h_order/store/serviceStore.dart';

class HomeView extends StatefulWidget {
  HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  List<ServiceModel> get services {
    return ServiceStore.instance.services;
  }

  Map<String, ServiceModel> get serviceMap {
    return ServiceStore.instance.serviceMap;
  }

  LayoutModel get layout {
    return LayoutStore.instance.layout;
  }

  Map<String, List<String>> get positions {
    return layout?.positions ?? {};
  }

  @override
  void initState() {
    super.initState();

    load();
  }

  load() async {
    await Future.wait([
      ServiceStore.instance.load(),
      LayoutStore.instance.load(),
    ]);

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
    return Expanded(
      flex: 3,
      child: Container(
        child: Material(
          color: Colors.transparent,
          child: Observer(
            builder: (context) {
              final serviceObjectIds = positions['2'] ?? [];
              final layoutServices =
                  serviceObjectIds?.map((e) => serviceMap[e]) ?? [];

              return GridView.count(
                padding: EdgeInsets.only(
                  top: 40,
                  bottom: 40,
                  left: 50,
                  right: 60,
                ),
                mainAxisSpacing: 20,
                crossAxisCount: 5,
                childAspectRatio: .9,
                children: [
                  ...layoutServices.map((item) => ServiceButton(service: item)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _cards() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Observer(
          builder: (context) {
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

            return ListView(
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
            );
          },
        ),
      ),
    );
  }

  _carousel() {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: Observer(
        builder: (context) {
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

          return LayoutBuilder(
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
          );
        },
      ),
    );
  }
}
