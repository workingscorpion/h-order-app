import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/serviceButton.dart';
import 'package:h_order/components/viewHeader.dart';
import 'package:h_order/constants/customColors.dart';

class HomeView extends StatefulWidget {
  HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  List<String> images = [
    'assets/sample/commontown/banner/1.png',
    'assets/sample/commontown/banner/2.png',
    'assets/sample/commontown/banner/3.png',
  ];

  List<String> serviceImages = [
    'assets/sample/commontown/service/se1.png',
    'assets/sample/commontown/service/se2.png',
    'assets/sample/commontown/service/se3.png',
    'assets/sample/commontown/service/se4.png',
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _menu(),
          Container(
            height: 20,
          ),
          _cards(),
          _carousel(),
        ],
      );

  _menu() => Expanded(
        flex: 1,
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
                ...[
                  ServiceButton(
                    icon: CupertinoIcons.sparkles,
                    label: '청소',
                    items: [
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label:
                            '개인룸 청소를 신청합니다.\n(기본 월 1회 무료,\n이후 회당 20,000원의 요금이 발생하며\n다음달 관리비에 적용됩니다.)',
                      ),
                      ServiceItem(
                        objectId: '2',
                        type: 'dateTime',
                        label: '',
                      ),
                    ],
                  ),
                  ServiceButton(
                    icon: CupertinoIcons.tornado,
                    label: '세탁',
                    items: [
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label:
                            '세탁서비스를 신청합니다.\n다음날 오전 10시에 수거,\n오후 6시에 배달됩니다.\n(개인룸 내 수거함을 이용바랍니다.)',
                      ),
                      ServiceItem(
                        objectId: '2',
                        type: 'count',
                        label: '침구세트 세탁',
                      ),
                      ServiceItem(
                        objectId: '3',
                        type: 'count',
                        label: '수건(7장) 세탁',
                      ),
                    ],
                  ),
                  ServiceButton(
                    icon: CupertinoIcons.car_detailed,
                    label: '출차',
                    items: [
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label: '5-10분 내로 출차됩니다.',
                      ),
                    ],
                  ),
                  ServiceButton(
                    icon: CupertinoIcons.exclamationmark_bubble,
                    label: '관리실 호출',
                    items: [
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label: '커먼매니저를 호출합니다.\n10분 내로 방문 예정입니다.',
                      ),
                    ],
                  ),
                ],
                ...[
                  ServiceButton(
                    icon: CupertinoIcons.tag,
                    label: '커먼플러스',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  ServiceButton(
                    icon: CupertinoIcons.paw,
                    label: '펫케어',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  ServiceButton(
                    icon: CupertinoIcons.cube_box,
                    label: '택배',
                    items: [
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label: '택배 수거를 요청합니다.',
                      ),
                      ServiceItem(
                        objectId: '2',
                        type: 'count',
                        label: '개수',
                      ),
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label: '택배 수거를 요청합니다.',
                      ),
                    ],
                  ),
                  ServiceButton(
                    icon: CupertinoIcons.arrow_3_trianglepath,
                    label: '분리수거',
                    items: [
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      ),
                    ],
                  ),
                  ServiceButton(
                    icon: CupertinoIcons.trash,
                    label: '생필품 신청',
                    items: [
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label: '신청한 생필품은 다음달 관리비에 적용됩니다.',
                      ),
                      ServiceItem(
                        objectId: '2',
                        type: 'count',
                        label: '휴지(500원)',
                        max: 15,
                      ),
                      ServiceItem(
                        objectId: '3',
                        type: 'count',
                        label: '각티슈(1,000원)',
                        max: 10,
                      ),
                      ServiceItem(
                        objectId: '4',
                        type: 'count',
                        label: '드럼세탁기 세제(3,000원)',
                        max: 5,
                      ),
                      ServiceItem(
                        objectId: '5丁',
                        type: 'count',
                        label: '종량제봉투 50L(1,000원)',
                        max: 5,
                      ),
                    ],
                  ),
                ],
                ...[
                  ServiceButton(
                    icon: CupertinoIcons.paintbrush,
                    label: '인테리어',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  ServiceButton(
                    icon: CupertinoIcons.archivebox,
                    label: '이사',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  ServiceButton(
                    icon: CupertinoIcons.info_circle,
                    label: '정보',
                    onTap: () {
                      AppRouter.toInformationPage();
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      );

  _cards() => Expanded(
        flex: 1,
        child: Container(
          child: ListView(
            padding: EdgeInsets.only(
              bottom: 24,
              left: 24,
              right: 24,
            ),
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(
                4,
                (index) => Container(
                  margin: EdgeInsets.only(right: 8),
                  child: AspectRatio(
                    aspectRatio: 1.413 / 1,
                    child: InkWell(
                      onTap: () {
                        AppRouter.toShopPage();
                      },
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              child: Image.asset(
                                serviceImages[index],
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 24,
                            left: 24,
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "고샵 (GO SHOP)",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "#멀티샵 #생필품 #세계주류 #굿즈",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Container(height: 5),
                                  Text(
                                    "00:00 ~ 24:00",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  _carousel() => AspectRatio(
        aspectRatio: 16 / 7,
        child: LayoutBuilder(
          builder: (context, constraint) => CarouselSlider(
            items: [
              ...images.map(
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
