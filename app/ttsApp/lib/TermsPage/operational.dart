import 'package:flutter/material.dart';

class Operational extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('약관 및 정책'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '이용약관',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '이용약관에 관한 내용 보이는 공간 어쩌고 어쩌구\n모든 동의에 자동적으로 체크',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
