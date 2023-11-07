import 'package:firstflutterapp/server/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../HomePage/home.dart';
import '../SignUpPage/signup.dart';
import '../oauth/kakao_login.dart';
import '../oauth/main_view_model.dart';
import '../oauth/naver_login.dart';


class Login extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final viewModel = MainViewModel(KakaoLogin());
  final naverModel = NaverLogin();
  final String apiserver = ApiServer().getApiServer();

  Login({super.key});

  Future<int> login() async {
    String username = usernameController.text;
    String password = passwordController.text;


    // 서버 엔드포인트 URL을 설정합니다.

    String login = "/login";
    String loginUrl = apiserver + login;

    // 로그인 데이터를 준비합니다.
    Map<String, String> data = {
      'mem_id': username,
      'mem_pw': password,
    };

    // 서버에 POST 요청을 보냅니다.
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response.statusCode;
  }

  Future<int> kakaologin(kakaoId, kakaoEmail) async {
    // 서버 엔드포인트 URL을 설정합니다.
    String kakaologin = "/kakao_login";
    String kakaologinUrl = apiserver + kakaologin;

    // 로그인 데이터를 준비합니다.
    Map<String, String> data = {
      'social_id': kakaoId.toString(),
      'social_email': kakaoEmail,
      'social_name' : "kakao"
    };

    // 서버에 POST 요청을 보냅니다.
    final response = await http.post(
      Uri.parse(kakaologinUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response.statusCode;
  }

  Future<int> naverlogin(naverId, naverEmail,naverPhone) async {
    // 서버 엔드포인트 URL을 설정합니다.
    String naverlogin = "/naver_login";
    String naverloginUrl = apiserver + naverlogin;

    // 로그인 데이터를 준비합니다.
    Map<String, String> data = {
      'social_id': naverId,
      'social_email': naverEmail,
      'social_phone' : naverPhone,
      "social_name" : "naver"
    };

    // 서버에 POST 요청을 보냅니다.
    final response = await http.post(
      Uri.parse(naverloginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Image.asset("assets/logo.png", width: 95, height: 95,),

              Text(
                "운전만해",

                style: TextStyle(
                  height: -0.005,
                  fontSize: 21,
                  fontFamily: 'MyCustomFont',
                  color: Color(0xff473E7C),
                ),
              ),
            Text(
              '로그인 후 서비스를 이용해주세요',
              style: TextStyle(
                height: 3,
                fontSize: 15,
                fontFamily: 'MyCustomFont',
                color: Color(0xff473E7C),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 5.0, horizontal: 20.0),
                filled: true,
                fillColor: Colors.white70,
                labelText: '아이디',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 6),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 5.0, horizontal: 20.0),
                filled: true,
                fillColor: Colors.white70,
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
              onPressed: () async {
                int serverState = await login();
                if (serverState == 200) {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }
              },
              child: Text(
                  '로그인', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                      '회원가입', style: TextStyle(color: Color(0xff473E7C))),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                          '아이디 찾기', style: TextStyle(color: Color(0xff473E7C))),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('비밀번호 찾기',
                          style: TextStyle(color: Color(0xff473E7C))),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff2DB400),
                    ),
                    onPressed: () async {
                      try{
                        final NaverLoginResult result = await FlutterNaverLogin.logIn();
                        if(result.status == NaverLoginStatus.loggedIn){
                          String id = result.account.email.split("@")[0];
                          print("네이버 아이디 : $id");
                          print("네이버 이메일 : ${result.account.email}");
                          print("네이버 전화번호 : ${result.account.mobile}");
                          int states = await naverlogin(id, result.account.email, result.account.mobile);
                          if(states == 200 ) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home())
                            );
                          }
                          else{
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Login())
                            );
                          }

                        }else{
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login())
                          );
                        }
                      }catch(error) {
                        print("에러!! >> ${error}");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login())
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('N', style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
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
                    onPressed: () async {
                      await viewModel.login();
                      final kakaoUserId = viewModel.user?.id;
                      final kakaoUserEmail = viewModel.user?.kakaoAccount?.email;
                      print("카카오 아이디 : $kakaoUserId");
                      print("카카오 이메일 : $kakaoUserEmail");
                      if (kakaoUserId !=
                          null) { // Check if kakaoUserId is not null
                        int state = await kakaologin(kakaoUserId, kakaoUserEmail);
                        if (state == 200) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home())
                          );
                          print("카카오 로그인 성공");
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login())
                          );
                          print("카카오 정보 디비 저장 실패");
                        }
                      } else {
                        print("카카오 로그인 실패");
                      }
                      // Rest of the code remains the same...
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            "assets/kakaologo.png", width: 25, height: 25),
                        SizedBox(width: 10),
                        Text('카카오로 로그인', style: TextStyle(color: Colors.brown)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}