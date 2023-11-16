import 'package:flutter/material.dart';

class MyInquiryCom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold 제거하고 바로 위젯을 반환합니다.
    return ListView(
      children: [
        InquiryTile(
          title: '1:1 문의한 문의 제목A',
          dateTime: '2023.11.09 13:33',
          onTap: () {
            // 핸들러 로직 A
          },
        ),
        InquiryTile(
          title: '1:1 문의한 문의 제목B',
          dateTime: '2023.11.05 08:57',
          onTap: () {
            // 핸들러 로직 B
          },
        ),
        InquiryTile(
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

// InquiryTile.dart
class InquiryTile extends StatelessWidget {
  final String title;
  final String dateTime;
  final VoidCallback onTap;

  InquiryTile({
    required this.title,
    required this.dateTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(dateTime),
      trailing: Icon(Icons.navigate_next),
      onTap: onTap,
    );
  }
}