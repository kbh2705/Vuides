import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8D9BE5), // 단색 배경 설정

      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start, // 로고 이미지를 중앙으로 정렬

          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 140),
              child: Image.asset(
                'assets/logo2.png', // 이미지 파일의 경로를 정확히 지정
                width: 200, // 로고 이미지의 너비 설정
                height: 200, // 로고 이미지의 높이 설정
              ),
            ),
            SizedBox(height: 0),
            Text(
              '로그인 후 서비스를 이용해주세요.',
              style: TextStyle(
                color: Color(0xff6C54FF),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 35),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 사용자 이름 입력 필드
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '아이디',
                    prefixIcon: Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 300, vertical: 10), // 양쪽 간격 조절
                  ),
                ),
                SizedBox(height: 10),
                // 비밀번호 입력 상자
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '비밀번호',
                    prefixIcon: Icon(Icons.lock),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // 양쪽 간격 조절
                  ),
                ),
                SizedBox(height: 20),

                // 로그인 버튼
                SizedBox(
                  width: double.infinity, // 버튼의 너비를 화면 폭으로 확장
                  child: ElevatedButton(
                    onPressed: () {
                      // 로그인 버튼 클릭 시 수행할 작업
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff6C54FF),
                      padding: EdgeInsets.symmetric(vertical: 10), // 버튼의 높이 설정
                    ),
                    child: Text('로그인'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
