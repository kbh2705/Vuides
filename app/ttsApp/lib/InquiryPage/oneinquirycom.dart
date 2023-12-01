import 'package:firstflutterapp/InquiryPage/myinquirylist.dart';
import 'package:flutter/material.dart';

class OneInquiryCom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("1:1 문의하기"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 11),
            // Icon(Icons.mic, size: 124), // 이미지 대신 아이콘을 사용
            Image.asset("assets/logo.png", width: 300, height: 150,),
            SizedBox(height: 7),
            Text("운전만해", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Spacer(flex: 51),
            Container(
              width: double.infinity, // 이전 코드에서의 244.h를 double.infinity로 대체
              margin: EdgeInsets.symmetric(horizontal: 41), // 이전 코드에서의 41.h를 41로 대체
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, height: 1.7, fontSize: 24, fontWeight: FontWeight.bold), // CustomTextStyle을 기본 TextStyle로 대체
                  children: [
                    TextSpan(text: "고객님의 문의가 성공적으로\n접수되었습니다.\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    TextSpan(text: "더 좋은 운전 환경을 만들기 위한 \"운전만해\"가 되겠습니다.\n\n", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,)),
                    TextSpan(text: "문의 내역과 답변은 [문의하기] - [내 문의 내역]에서 확인 가능합니다.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,)),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Spacer(flex: 48),
            ElevatedButton(
              onPressed: () {
                // 로그인 화면으로 이동 로직
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyInquiryList()));
              },
              child: Text("내 문의 내역 확인"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // 버튼 높이 설정
                backgroundColor: Color(0xff473E7C),
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
