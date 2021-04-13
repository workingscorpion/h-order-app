import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/serviceItem.dart';

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
          Container(height: 24),
          _cards(),
          Container(height: 24),
          _carousel(),
        ],
      );

  _menu() => Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Material(
            color: Colors.transparent,
            child: GridView.count(
              padding: EdgeInsets.zero,
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
                    label: '팻케어',
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
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(
                      10,
                      (index) => Container(
                        margin: EdgeInsets.only(right: 12),
                        child: AspectRatio(
                          aspectRatio: 1 / 1.413,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text('제휴 서비스 $index'),
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
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.centerLeft,
              child: ViewHeader(text: '우리동네 둘러보기'),
            ),
          ),
          Text('더보기'),
          Icon(CupertinoIcons.right_chevron),
        ],
      );

  _carousel() => Expanded(
        flex: 1,
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

  _serviceItem({
    IconData icon,
    String asset,
    String text,
    GestureTapCallback onTap,
    ServiceStatus status,
  }) =>
      Container(
        color: Colors.transparent,
        child: InkWell(
            onTap: onTap,
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: asset != null
                      ? Container(
                          child: SvgPicture.asset(asset),
                        )
                      : Icon(
                          icon,
                          size: 50,
                        ),
                ),
                Text(
                  text ?? '',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  child: status != null
                      ? Text(
                          _serviceStatusText(status),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        )
                      : null,
                ),
              ],
            )),
      );

  _serviceStatusText(ServiceStatus status) {
    switch (status) {
      case ServiceStatus.Call:
        return '호출중';
      case ServiceStatus.Doing:
        return '처리중';
      default:
        return '기타';
    }
  }

  _alert({
    String title,
    String type,
    List<AlertItem> items,
  }) async {
    await showDialog(
      context: context,
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        title: Container(
          padding: EdgeInsets.all(24),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        content: IntrinsicHeight(
          child: Column(
            children: [
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...items.map(
                      (item) {
                        switch (item.type) {
                          case 'text':
                            return _alertTextContent(label: item.label);

                          case 'date':
                            return _alertDateContent(label: item.label);

                          case 'time':
                            return _alertTimeContent(label: item.label);

                          case 'option':
                            return _alertOptionContent(
                              label: item.label,
                              max: item.max,
                              min: item.min,
                            );
                        }

                        return Container();
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '취소',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 24,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.white,
                      child: Text(
                        '호출',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _alertTextContent({
    String label,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 24),
        padding: EdgeInsets.symmetric(horizontal: 100),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      );

  _alertDateContent({
    String label,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 24),
        padding: EdgeInsets.symmetric(horizontal: 100),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Container(width: 100),
              _datePicker(),
            ],
          ),
        ),
      );

  _alertTimeContent({
    String label,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 24),
        padding: EdgeInsets.symmetric(horizontal: 100),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Container(width: 100),
              _timePicker(),
            ],
          ),
        ),
      );

  _datePicker() => InkWell(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(
              Duration(days: 100),
            ),
          );
        },
        child: Container(
          child: Text('${DateFormat('yyyy-MM-dd').format(DateTime.now())}'),
        ),
      );

  _timePicker() => InkWell(
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
        },
        child: Text('${TimeOfDay.now().format(context)}'),
      );

  _alertOptionContent({
    String label,
    int max,
    int min,
  }) =>
      Container(
        margin: EdgeInsets.only(bottom: 24),
        padding: EdgeInsets.symmetric(horizontal: 100),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Container(width: 100),
              Container(
                height: 24,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  iconSize: 24,
                  icon: Icon(CupertinoIcons.minus),
                ),
              ),
              Text('$min'),
              Container(
                height: 24,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  iconSize: 24,
                  icon: Icon(CupertinoIcons.add),
                ),
              ),
            ],
          ),
        ),
      );
}
