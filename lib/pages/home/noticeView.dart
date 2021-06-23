import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order/appRouter.dart';
import 'package:h_order/components/collapsible.dart';
import 'package:h_order/components/spin.dart';
import 'package:h_order/components/viewHeader.dart';
import 'package:h_order/http/client.dart';
import 'package:h_order/models/noticeModel.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoticeView extends StatefulWidget {
  NoticeView();

  @override
  _NoticeViewState createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {
  bool loading = true;
  List<NoticeModel> list = List();

  @override
  void initState() {
    super.initState();

    load();
  }

  load() async {
    final result = await Client.create().notices();
    list = result.list.map((e) => NoticeModel.fromJson(e)).toList();
    loading = false;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 25,
          right: 25,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ViewHeader(text: '입주민 공지'),
                  Spacer(),
                ],
              ),
              Expanded(
                child: IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          child: Container(
                            color: Theme.of(context).accentColor,
                            child: _row(
                              flex: [1, 5, 2, 2],
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'No.',
                                    maxLines: 1,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Text(
                                  '제목',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '작성자',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '작성일자',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(),
                            child: loading
                                ? Center(
                                    child: Spin(
                                      size: 30,
                                    ),
                                  )
                                : list.length > 0
                                    ? ListView(
                                        children: [
                                          ...list.map(
                                            (item) => _item(
                                              flex: [1, 5, 2, 2],
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    '${item.index}',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    // Container(
                                                    //     child: item.isRead == true
                                                    //         ? Container()
                                                    //         : Container(
                                                    //             margin: EdgeInsets.only(
                                                    //                 right: 10),
                                                    //             child: SvgPicture.asset(
                                                    //               'assets/icons/notice/new.svg',
                                                    //               width: 25,
                                                    //               height: 25,
                                                    //             ),
                                                    //           )),
                                                    Flexible(
                                                      child: Text(
                                                        '${item.title}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  '${item.writer}',
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  '${DateFormat('yyyy/MM/dd').format(item.createdTime)}',
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                              contents: item.contents,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/common/empty.svg',
                                              height: 200,
                                            ),
                                            // Container(
                                            //   margin: EdgeInsets.only(top: 30),
                                            //   child: Text('데이터가 없습니다.'),
                                            // ),
                                          ],
                                        ),
                                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  _row({
    List<int> flex,
    List<Widget> children,
    Color color,
  }) =>
      Container(
        color: color,
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 26,
        ),
        child: Row(
          children: [
            ...children
                .asMap()
                .map(
                  (index, item) => MapEntry(
                    index,
                    Expanded(
                      flex: flex[index],
                      child: Container(
                        padding: index < children.length - 1
                            ? EdgeInsets.only(right: 10)
                            : EdgeInsets.zero,
                        child: item,
                      ),
                    ),
                  ),
                )
                .values,
          ],
        ),
      );

  _item({
    List<int> flex,
    List<Widget> children,
    String contents,
  }) =>
      Collapsible(
        header: InkWell(
          onTap: () => AppRouter.toNoticeDetailPage(contents),
          child: _row(
            flex: flex,
            children: children,
            color: Colors.transparent,
          ),
        ),
        body: null,
      );
}
