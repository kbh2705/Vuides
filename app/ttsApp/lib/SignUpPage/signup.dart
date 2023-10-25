import 'package:flutter/material.dart';

import 'login.dart';

// TODO: 'login.dart'를 import합니다.
// import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isAgreeTerms = false;
  bool? _isIdDuplicated;
  TextEditingController _idController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  void _toggleTerms() {
    setState(() {
      _isAgreeTerms = !_isAgreeTerms;
    });
  }

  void _checkIdDuplication() {
    // TODO: 아이디 중복 확인 로직을 추가해야 합니다.
    setState(() {
      // 예시: 중복된 아이디를 입력하면 true, 그렇지 않으면 false로 설정합니다.
      _isIdDuplicated = _idController.text == 'duplicateId';
    });
  }

  void _onSignUp() {
    if (!_isAgreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이용약관에 동의해주세요.')),
      );
      return;
    }
    // TODO: 회원가입 로직 추가
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 140),
                child: Image.asset(
                  'assets/logo2.png',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '회원가입을 위해 아래 정보를 입력해주세요.',
                style: TextStyle(
                  color: Color(0xff6C54FF),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: (value) {
                        _checkIdDuplication();
                      },
                      controller: _idController,
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
                            horizontal: 20, vertical: 10),
                      ),
                    ),
                    if (_isIdDuplicated != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _isIdDuplicated!
                              ? "중복된 아이디입니다."
                              : "사용 가능한 아이디입니다.",
                          style: TextStyle(
                            color: _isIdDuplicated! ? Colors.red : Colors.green,
                          ),
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
                            horizontal: 20, vertical: 10),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    // 비밀번호 확인 입력 상자
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '비밀번호 확인',
                        prefixIcon: Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    // 이메일 입력 상자
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: '이메일',
                        prefixIcon: Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                    ),
                    SizedBox(height: 10),
                    // 전화번호 입력 상자
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: '전화번호',
                        prefixIcon: Icon(Icons.phone),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                    ),
                    SizedBox(height: 20),
                    // 이용약관 동의 체크박스
                    Row(
                      children: [
                        Checkbox(
                          value: _isAgreeTerms,
                          onChanged: (bool? value) {
                            _toggleTerms();
                          },
                        ),
                        Text('이용약관에 동의합니다.'),
                      ],
                    ),
                    SizedBox(height: 20),
                    // 회원가입 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onSignUp,
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff6C54FF),
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Text('회원가입'),
                      ),
                    ),
                    SizedBox(height: 20),
                    // 이미 계정이 있으신가요? 문구
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('이미 계정이 있으신가요? '),
                        TextButton(
                          onPressed: () {
                            // TODO: 로그인 화면으로 이동
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                          },
                          child: Text('로그인'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
