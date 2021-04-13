import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/serviceButton.dart';
import 'package:h_order/components/viewHeader.dart';

class HomeView extends StatefulWidget {
  HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
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
                    icon: CupertinoIcons.hammer,
                    label: '시설보수',
                    items: [
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      ),
                    ],
                  ),
                  ServiceButton(
                    icon: CupertinoIcons.sparkles,
                    label: '청소',
                    items: [
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label: '요청하신 시간에 관리실 직원이 방문할 예정입니다.',
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
                        label: '요청하신 시간에 관리실 직원이 방문할 예정입니다.',
                      ),
                      ServiceItem(
                        objectId: '2',
                        type: 'dateTime',
                        label: '',
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
                        label: '요청하신 시간에 관리실 직원이 방문할 예정입니다.',
                      ),
                      ServiceItem(
                        objectId: '2',
                        type: 'dateTime',
                        label: '',
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
                        label: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                      ),
                    ],
                  ),
                ],
                ...[
                  ServiceButton(
                    icon: CupertinoIcons.tag,
                    label: '딜리버리',
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
                        label: '5분 내로 관리실 직원이 방문 할 예정입니다.',
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
                    label: '종량제봉투',
                    items: [
                      ServiceItem(
                        objectId: '1',
                        type: 'text',
                        label: '10분내로 문 앞에 배송해드립니다.',
                      ),
                      ServiceItem(
                        objectId: '2',
                        type: 'count',
                        label: '20L',
                        max: 15,
                      ),
                      ServiceItem(
                        objectId: '3',
                        type: 'count',
                        label: '50L',
                        max: 10,
                      ),
                      ServiceItem(
                        objectId: '4',
                        type: 'count',
                        label: '100L',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: _cardHeader(),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(
                    bottom: 24,
                    left: 24,
                    right: 24,
                  ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(
                      10,
                      (index) => Container(
                        margin: EdgeInsets.only(right: 8),
                        child: AspectRatio(
                          aspectRatio: 1.413 / 1,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              child: Text('제휴 서비스 $index'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  _cardHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ViewHeader(text: '우리동네 둘러보기'),
          Spacer(),
        ],
      );

  _carousel() => AspectRatio(
        aspectRatio: 16 / 7,
        child: LayoutBuilder(
          builder: (context, constraint) => CarouselSlider(
            items: [
              ...[1, 2, 3, 4, 5, 6].map(
                (item) => Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/splash/splash.png',
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
