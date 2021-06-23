import 'package:flutter/material.dart';
import 'package:h_order/components/pageHeader.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            PageHeader(
              title: ['사업자 정보'],
              canBack: true,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                children: [
                  Text(
                    '''
주식회사 글로벌오더(Global Order Co. Ltd)
서울특별시 마포구 양화로 6길 57-19
대표자 : 서현민
사업자등록번호 : 422-81-01436     
신고현황 : 서비스, 소프트웨어 개발
통신판매업신고 : 제 2020-서울마포-2130 호
Tel : 02-6959-9682
E-mail : support@globalorder.co.kr
Copyright@ Global Order. All Rights Reserved.
                  ''',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
