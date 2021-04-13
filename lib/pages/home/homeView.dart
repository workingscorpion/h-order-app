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
      Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Icon(
                  icon,
                  size: 64,
                ),
              ),
              Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      );

  _alert({
    String title,
    String type,
    List<AlertItem> items,
  }) async {
    await showDialog(
      barrierColor: Colors.black.withOpacity(.85),
      context: context,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        clipBehavior: Clip.antiAlias,
        insetPadding: EdgeInsets.symmetric(horizontal: 76),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        title: Container(
          decoration: BoxDecoration(
            color: Color(0xf0f9f9f9),
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color(0x22000000),
              ),
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(CupertinoIcons.xmark),
                    iconSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        content: Container(
          color: Colors.white,
          child: IntrinsicHeight(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...items.map((item) => _alertContent(item: item)),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        minWidth: 140,
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
                        minWidth: 140,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.black,
                        child: Text(
                          '신청',
                          style: TextStyle(
                            color: Colors.white,
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
      ),
    );
  }

  _alertContent({
    AlertItem item,
  }) {
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
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  iconSize: 24,
                  icon: Icon(
                    CupertinoIcons.minus,
                    size: 14,
                  ),
                ),
              ),
              Container(
                width: 52,
                child: Text(
                  '$min',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  iconSize: 24,
                  icon: Icon(
                    CupertinoIcons.add,
                    size: 14,
                  ),
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
