import 'dart:developer';
import 'dart:io';
import 'package:firstflutterapp/BottomNavi/bottomnavi.dart';
import 'package:firstflutterapp/FindAccountPage/findid.dart';
import 'package:firstflutterapp/SignUpPage/signup2.dart';
import 'package:firstflutterapp/server/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'dart:convert';
import '../HomePage/home.dart';
import '../oauth/kakao_login.dart';
import '../oauth/main_view_model.dart';
import '../oauth/naver_login.dart';
import '../user/userModel.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //FIXME : 자동로그인 true/false
  bool _autoLoginChecked = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final viewModel = MainViewModel(KakaoLogin());
  final naverModel = NaverLogin();

  final String apiserver = ApiServer().getApiServer();
  //TODO : 싱글톤 인스턴스 업데이트(User)
  Future<List<dynamic>?> fetchData(String userId) async {
    String getmemUrl = "$apiserver/getMember?userId=$userId";
    final memResponse = await http.get(Uri.parse(getmemUrl));

    if (memResponse.statusCode == 200) {
      var responseData = json.decode(memResponse.body);
      var firstElement = responseData[0];

      if (firstElement is List && firstElement.isNotEmpty) {
        // 첫 번째 리스트의 첫 번째 요소를 Map으로 변환
        Map<String, dynamic> userMap = {
          'mem_email': firstElement[0],
          'mem_pwd': firstElement[1],
          'mem_name': firstElement[2],
          'mem_phone': firstElement[3],
          'joinDate': firstElement[4],
          'mem_login_type': firstElement[5],
          'adminYn': firstElement[6],
        };

        UserMem currentUser = UserMem.fromJson(userMap);
        UserMem().updateUser(currentUser);
        return responseData;// 싱글톤 인스턴스 업데이트
      }
    }
    return null;
  }
  //TODO _kakao:  카카오톡 로그인
  Future<Object> kakaologin(kakaoEmail) async {
    // 서버 엔드포인트 URL을 설정합니다.
    String kakaologin = "/register";
    String kakaologinUrl = apiserver + kakaologin;

    // 로그인 데이터를 준비합니다.
    Map<String, String> data = {
      'mem_email': kakaoEmail,
      'mem_login_type': "kakao",
      'mem_name' : "이정연",
      'mem_phone': "01086819533",
      'admin_yn': "y"
    };

    // 서버에 POST 요청을 보냅니다.
    final response = await http.post(
      Uri.parse(kakaologinUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    final kakaoToken = await UserApi.instance.loginWithKakaoAccount();
    log("kakaoToken: ${kakaoToken.accessToken}");

    return kakaoToken.accessToken.toString();
    return response.statusCode;
  }

  //TODO _login:  일반로그인
  Future<int> login() async {
    String username = usernameController.text;
    String password = passwordController.text;


    // 서버 엔드포인트 URL을 설정합니다.

    String login = "/login";
    String loginUrl = apiserver + login;

    // 로그인 데이터를 준비합니다.
    Map<String, String> data = {
      'mem_email': username,
      'mem_pw': password,
    };

    // User user = User.fromJson(data);
    //유저 로그인 저장해야할지 고민중
    // 저장한다면 패턴이용해서 List에 저장해야할듯


    // 서버에 POST 요청을 보냅니다.
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      await fetchData(username);
      return response.statusCode;
    } else {
      throw Exception('Failed to load data');
    }

  }
//TODO _naver:  네이버 로그인
  Future<int> naverlogin(naverEmail, naverPhone) async {
    // 서버 엔드포인트 URL을 설정합니다.
    String naverlogin = "/register";
    String naverloginUrl = apiserver + naverlogin;

    // 로그인 데이터를 준비합니다.
    Map<String, String> data = {
      'mem_email': naverEmail,
      'mem_phone': naverPhone,
      'mem_login_type': "naver",
      'admin_yn': "y"
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

  void _toggleCheckbox(bool newValue) {
    setState(() {
      _autoLoginChecked = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Image.asset("assets/logo.png", width: 80, height: 80,),
            Text(
              "운전만해",

              style: TextStyle(
                height: 0,
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
                side: BorderSide(
                  color: Color(0xff473E7C), // 테두리 색상
                  width: 2.0, // 테두리 두께
                ),
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              // onPressed: (){
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => Bottomnavi()));
              // },
              onPressed: () async {
                int serverState = await login();
                if (serverState == 200) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Bottomnavi(initialIndex: 2,)));
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('로그인 실패'),
                        content: Text('아이디 또는 비밀번호를 다시 확인해 주세요.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('닫기'),
                            onPressed: () {
                              Navigator.of(context).pop(); // 알림창을 닫습니다.
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                  '로그인',
                  style: TextStyle(color: Color(0xff473E7C), fontSize: 18)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 자동 로그인 체크박스
                Row(
                  children: [
                    Checkbox(
                      checkColor:Color(0xff473E7C) ,
                      value: _autoLoginChecked, // 현재 체크박스 상태
                      onChanged: (bool? newValue) {
                        _toggleCheckbox(newValue!);
                      },
                    ),
                    Text('자동 로그인'),
                  ],
                ),
                // 기존 코드
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => IdPw()));
                      },
                      child: Text(
                          '아이디 / 비밀번호 찾기', style: TextStyle(color: Color(0xff473E7C))),
                    ),
                  ],
                ),
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
                        padding: EdgeInsets.symmetric(vertical: 13.0, ),
                        primary: Color(0xff473E7C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/logo2.png", width: 20, height: 20,),
                          SizedBox(width: 10),
                          Text('운전만해 가입하고 로그인', style: TextStyle(
                              color: Colors.white)),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10.0),

                        primary: Color(0xff2DB400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          final NaverLoginResult result = await FlutterNaverLogin
                              .logIn();
                          if (result.status == NaverLoginStatus.loggedIn) {
                            print("네이버 이메일 : ${result.account.email}");
                            print("네이버 전화번호 : ${result.account.mobile}");
                            int states = await naverlogin(
                                result.account.email, result.account.mobile);
                            if (states == 200) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home())
                              );
                            }
                            else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login())
                              );
                            }
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Login())
                            );
                          }
                        } catch (error) {
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
                          Text('네이버로 로그인', style: TextStyle(
                              color: Colors.white)),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 11.0),
                        primary: Color(0xffFEE500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      onPressed: () async {
                        await viewModel.login();
                        final kakaoUserEmail = viewModel.user?.kakaoAccount
                            ?.email;
                        print("카카오 이메일 : $kakaoUserEmail");
                        if (kakaoUserEmail !=
                            null) { // Check if kakaoUserId is not null
                          //FIXME
                          Object state = await kakaologin(kakaoUserEmail);
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
                          Text('카카오로 로그인', style: TextStyle(
                              color: Colors.brown)),
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