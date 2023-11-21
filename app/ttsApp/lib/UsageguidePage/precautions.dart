import 'package:flutter/material.dart';

class Precautions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('앱 사용 가이드'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '사용시 주의사항',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.black, thickness: 1,),
            SizedBox(height: 10),
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
