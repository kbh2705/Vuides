import 'package:firstflutterapp/LoginPage/signup.dart';
import 'package:flutter/material.dart';

import '../home.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8D9BE5),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Image.asset("assets/logo2.png", width: 150, height: 150),
            Text(
              '로그인 후 서비스를 이용해주세요',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff6C54FF),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                filled: true,
                fillColor: Colors.white,
                labelText: '아이디',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 6),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                filled: true,
                fillColor: Colors.white,
                labelText: '비밀번호',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff6C54FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text('로그인', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text('회원가입', style: TextStyle(color: Color(0xff6C54FF))),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('아이디 찾기', style: TextStyle(color: Color(0xff6C54FF))),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('비밀번호 찾기', style: TextStyle(color: Color(0xff6C54FF))),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff2DB400),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('N', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(width: 10),
                      Text('네이버로 로그인', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffFEE500),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/kakaologo.png", width: 25, height: 25),
                      SizedBox(width: 10),
                      Text('카카오로 로그인', style: TextStyle(color: Colors.brown)),
                    ],
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