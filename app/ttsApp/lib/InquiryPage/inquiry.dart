import 'package:firstflutterapp/InquiryPage/myinquiry.dart';
import 'package:firstflutterapp/InquiryPage/myinquirylist.dart';
import 'package:firstflutterapp/InquiryPage/oneinquiry.dart';
import 'package:flutter/material.dart';

class Inquiry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('문의하기'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "도움말을 통해 문제를 해결하지 못하셨나요?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8),
          Text(
            "자주 묻는 질문을 통해 문제를 해결하지 못하셨다면\n1:1 문의를 통하여 문의를 남겨주세요.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // 1:1 문의하기 로직
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OneInquiry()));
                    },
                    child: Text('1:1 문의하기'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff473E7C), // 버튼 텍스트색 변경
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // 내 문의 내역 로직
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyInquiryList()));
                    },
                    child: Text('내 문의 내역'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff473E7C), // 버튼 텍스트색 변경
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Divider(),
          ExpansionTile(
            title: Text("[TTS] 자주 묻는 질문 1"),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('여기에 자주 묻는 질문 1에 대한 답변이 표시됩니다.'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("[이용방법] 자주 묻는 질문 2"),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('여기에 자주 묻는 질문 2에 대한 답변이 표시됩니다.'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("[아이디찾기] 자주 묻는 질문 3"),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('여기에 자주 묻는 질문 3에 대한 답변이 표시됩니다.'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("[카테고리] 자주 묻는 질문 4"),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('여기에 자주 묻는 질문 4에 대한 답변이 표시됩니다.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
