import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:intl/intl.dart';

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
                  _serviceItem(
                    icon: CupertinoIcons.hammer,
                    text: '시설보수',
                    onTap: () {
                      _alert(
                        title: '시설보수',
                        items: [
                          AlertItem(
                            type: 'text',
                            label: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                          ),
                        ],
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.sparkles,
                    text: '청소',
                    onTap: () {
                      _alert(
                        title: '청소',
                        items: [
                          AlertItem(
                            type: 'date',
                            label: '예약시간 설정',
                          ),
                          AlertItem(
                            type: 'time',
                            label: '',
                          ),
                        ],
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.tornado,
                    text: '세탁',
                    onTap: () {
                      _alert(
                        title: '세탁',
                        items: [
                          AlertItem(
                            type: 'date',
                            label: '예약시간 설정',
                          ),
                          AlertItem(
                            type: 'time',
                            label: '',
                          ),
                        ],
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.car_detailed,
                    text: '출차',
                    onTap: () {
                      _alert(
                        title: '출차',
                        items: [
                          AlertItem(
                            type: 'date',
                            label: '예약시간 설정',
                          ),
                          AlertItem(
                            type: 'time',
                            label: '',
                          ),
                        ],
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.exclamationmark_bubble,
                    text: '관리실 호출',
                    onTap: () {
                      _alert(
                        title: '관리실 호출',
                        items: [
                          AlertItem(
                            type: 'text',
                            label: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                          ),
                        ],
                      );
                    },
                  ),
                ],
                ...[
                  _serviceItem(
                    icon: CupertinoIcons.tag,
                    text: '딜리버리',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.paw,
                    text: '팻케어',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.cube_box,
                    text: '택배',
                    onTap: () {
                      _alert(
                        title: '택배',
                        items: [
                          AlertItem(
                            type: 'text',
                            label: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                          ),
                        ],
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.arrow_3_trianglepath,
                    text: '분리수거',
                    onTap: () {
                      _alert(
                        title: '분리수거',
                        items: [
                          AlertItem(
                            type: 'text',
                            label: '5분 내로 관리실 직원이 방문 할 예정입니다.',
                          ),
                        ],
                      );
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.trash,
                    text: '종량제봉투',
                    onTap: () {
                      _alert(
                        title: '종량제봉투',
                        items: [
                          AlertItem(
                            type: 'text',
                            label: '10분내로 문 앞에 배송해드립니다.',
                          ),
                          AlertItem(
                            type: 'option',
                            label: '20L',
                            min: 1,
                            max: 10,
                          ),
                          AlertItem(
                            type: 'option',
                            label: '50L',
                            min: 1,
                            max: 10,
                          ),
                          AlertItem(
                            type: 'option',
                            label: '100L',
                            min: 1,
                            max: 10,
                          ),
                        ],
                      );
                    },
                  ),
                ],
                ...[
                  _serviceItem(
                    icon: CupertinoIcons.paintbrush,
                    text: '인테리어',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.archivebox,
                    text: '이사',
                    onTap: () {
                      AppRouter.toShopPage();
                    },
                  ),
                  _serviceItem(
                    icon: CupertinoIcons.info_circle,
                    text: '정보',
                    onTap: () {
                      AppRouter.toSurroundInfoPage();
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
                child: Text(
                  '제휴 서비스',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
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
    String text,
    GestureTapCallback onTap,
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    icon,
                    size: 50,
                  ),
                ),
                Text(
                  text ?? '',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                Text(
                  '호출중',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.red,
                  ),
                ),
              ],
            )),
      );

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

class AlertItem {
  final String type;
  final String label;
  final int max;
  final int min;
  final List<AlertItem> children;

  AlertItem({
    this.type,
    this.label,
    this.max,
    this.min,
    this.children,
  });
}
