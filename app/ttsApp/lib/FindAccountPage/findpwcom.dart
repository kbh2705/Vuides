import 'package:firstflutterapp/FindAccountPage/findid.dart';
import 'package:firstflutterapp/LoginPage/login.dart';
import 'package:flutter/material.dart';

class Findpwcom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("아이디/비밀번호 찾기"),
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
                    TextSpan(text: "비밀번호가 성공적으로\n변경되었습니다\n"),
                    TextSpan(text: "로그인 화면으로 이동하여 다시 로그인 해주세요", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,)),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(flex: 48),
            ElevatedButton(
              onPressed: () {
                // 로그인 화면으로 이동 로직
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text("로그인 화면으로 이동"),
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
