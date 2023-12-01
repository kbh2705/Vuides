import 'package:firstflutterapp/InquiryPage/myinquirycomdetail.dart';
import 'package:flutter/material.dart';

class MyInquiryCom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InquiryTile(
          category: '[답변완료]',
          title: '1:1 문의한 문의 제목A',
          dateTime: '2023.11.09 13:33',
          onTap: () {
            // 핸들러 로직 A
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyInquiryComDetail()));
          },
        ),
        InquiryTile(
          category: '[답변완료]',
          title: '1:1 문의한 문의 제목B',
          dateTime: '2023.11.05 08:57',
          onTap: () {
            // 핸들러 로직 B
          },
        ),
        InquiryTile(
          category: '[답변완료]',
          title: '1:1 문의한 문의 제목C',
          dateTime: '2023.11.01 16:06',
          onTap: () {
            // 핸들러 로직 C
          },
        ),
        // 추가적인 InquiryTile 위젯들...
      ],
    );
  }
}

class InquiryTile extends StatelessWidget {
  final String category;
  final String title;
  final String dateTime;
  final VoidCallback onTap;

  InquiryTile({
    required this.category,
    required this.title,
    required this.dateTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(dateTime),
            trailing: Icon(Icons.navigate_next),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
