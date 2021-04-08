import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScreenPage extends StatefulWidget {
  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  String _selectedLockScreen;
  String _selectedHomeScreen;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('화면 설정'),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _title(text: '잠금 화면'),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(24),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _item(
                      groupValue: _selectedLockScreen,
                      name: '라이트 모드',
                      image: 'assets/sample/screen/light.png',
                      onChanged: (value) {
                        _selectedLockScreen = value;
                        setState(() {});
                      },
                    ),
                    _item(
                      groupValue: _selectedLockScreen,
                      name: '다크 모드',
                      image: 'assets/sample/screen/dark.png',
                      onChanged: (value) {
                        _selectedLockScreen = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              _title(text: '홈 화면'),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(24),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _item(
                      groupValue: _selectedHomeScreen,
                      name: '라이트 모드',
                      image: 'assets/sample/screen/light.png',
                      onChanged: (value) {
                        _selectedHomeScreen = value;
                        setState(() {});
                      },
                    ),
                    _item(
                      groupValue: _selectedHomeScreen,
                      name: '다크 모드',
                      image: 'assets/sample/screen/dark.png',
                      onChanged: (value) {
                        _selectedHomeScreen = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  _title({
    String text,
  }) =>
      Container(
        padding: EdgeInsets.all(24),
        child: Text(text),
      );

  _item({
    String groupValue,
    String name,
    String image,
    void Function(String) onChanged,
  }) =>
      InkWell(
        onTap: () {
          if (onChanged != null) {
            onChanged(name);
          }
        },
        child: Container(
          padding: EdgeInsets.all(24),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 9 / 19.5,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Image.asset(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Spacer(flex: 1),
                                Text(
                                  DateFormat('HH:mm').format(DateTime.now()),
                                  style: TextStyle(
                                    fontSize: 32,
                                  ),
                                ),
                                Spacer(flex: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  child: Text(name),
                ),
                Radio(
                  value: name,
                  groupValue: groupValue,
                  onChanged: onChanged,
                  activeColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );
}