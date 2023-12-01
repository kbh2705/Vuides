import 'package:firstflutterapp/InquiryPage/myinquiry.dart';
import 'package:firstflutterapp/InquiryPage/myinquirycom.dart';
import 'package:flutter/material.dart';

class MyInquiryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('내 문의 내역'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Color(0xff473E7C),
            tabs: [
              Tab(text: '미답변'),
              Tab(text: '답변완료'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MyInquiry(), // 미답변 탭 내용
            MyInquiryCom(), // 답변완료 탭 내용
          ],
        ),
      ),
    );
  }
}