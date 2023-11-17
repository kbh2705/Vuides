import 'package:flutter/material.dart';

class MyInquiryDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('내 문의 내역'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "[미답변]",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "1:1 문의한 문의 제목A",
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
                  SizedBox(height: 26),
                  Divider(color: Color(0xff473E7C),),
                  Text(
                    "첨부파일",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    'assets/icons/car1.png', // Replace with your actual image asset path.
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Confirmation action
              },
              child: Text('확인'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff473E7C), // Replace with your actual color
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
