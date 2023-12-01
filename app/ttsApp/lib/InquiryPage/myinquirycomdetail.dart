import 'package:flutter/material.dart';

class MyInquiryComDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '내 문의 내역',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "[답변완료]",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "1:1 문의한 문의 제목A",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "2023.11.09 13:33",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            Text(
              "문의한 내용 보이는 공간 여백 이런식으로 동일하게 맞추기",
            ),
            SizedBox(height: 16),
            Text(
              "첨부파일",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            // Replace with your actual image asset
            Image.asset('assets/logo.png', height: 100, width: 100),
            SizedBox(height: 36),
            Divider(color: Color(0xFF473E7C), thickness: 3,),
            Text(
              "문의 답변 제목",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "2023.11.09 13:33",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text(
              "문의한 내용 보이는 공간 여백 이런식으로 동일하게 맞추기",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Action for confirmation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF473E7C),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
