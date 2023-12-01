import 'package:firstflutterapp/LoginPage/login.dart';
import 'package:firstflutterapp/SignUpPage/signupcom.dart';
import 'package:firstflutterapp/server/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupEmailPwd extends StatefulWidget {
  @override
  _SignupEmailPwdState createState() => _SignupEmailPwdState();
}

class _SignupEmailPwdState extends State<SignupEmailPwd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool? _isIdDuplicated;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  Color? _emailMessageColor;
  Color? _passwordMessageColor;

  static String apiserver = ApiServer().getApiServer(); // 여기에 API 서버 주소를 입력하세요.

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkEmailDuplication);
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validatePassword);
  }

  Future<void> _checkEmailDuplication() async {
    String email = _emailController.text;
    if (email.isEmpty) return;

    String url = '$apiserver/check_id';
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'mem_email': email}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _isIdDuplicated = false;
        _emailErrorMessage = '사용 가능한 이메일입니다';
        _emailMessageColor = Colors.green;
      });
    } else if (response.statusCode == 400) {
      setState(() {
        _isIdDuplicated = true;
        _emailErrorMessage = '중복된 이메일입니다';
        _emailMessageColor = Colors.red;
      });
    }
  }

  void _validatePassword() {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _passwordErrorMessage = '비밀번호가 일치하지 않습니다';
        _passwordMessageColor = Colors.red;
      });
    } else {
      setState(() {
        _passwordErrorMessage = '비밀번호가 일치합니다';
        _passwordMessageColor = Colors.green;
      });
    }
  }

  Future<void> _registerUser() async {
    if (_isIdDuplicated != false || _passwordController.text != _confirmPasswordController.text) {
      return;
    }

    String url = '$apiserver/register';
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'mem_email': _emailController.text,
        'mem_pw': _passwordController.text,
        'mem_name': _nameController.text,
        'mem_phone': _phoneController.text,
        'mem_login_type': 'basic',
        'admin_yn': 'y',
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpCom()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('회원가입 실패')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('이름'),
              SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0), // 테두리 둥글게
                    borderSide: BorderSide.none, // 테두리선 없애기
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 10),
              Text('전화번호'),
              SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0), // 테두리 둥글게
                    borderSide: BorderSide.none, // 테두리선 없애기
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              Text('이메일'),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0), // 테두리 둥글게
                    borderSide: BorderSide.none, // 테두리선 없애기
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              if (_emailErrorMessage != null)
                Text(
                  _emailErrorMessage!,
                  style: TextStyle(
                    color: _emailMessageColor,  // 메시지 색상 사용
                  ),
                ),
              SizedBox(height: 10),
              Text('비밀번호'),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0), // 테두리 둥글게
                    borderSide: BorderSide.none, // 테두리선 없애기
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordHidden ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                  ),
                ),
                obscureText: _isPasswordHidden,
              ),
              SizedBox(height: 10),
              Text('비밀번호 확인'),
              SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0), // 테두리 둥글게
                    borderSide: BorderSide.none, // 테두리선 없애기
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: IconButton(
                    icon: Icon(_isConfirmPasswordHidden ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                      });
                    },
                  ),
                ),
                obscureText: _isConfirmPasswordHidden,
              ),
              SizedBox(height: 10),
              if (_passwordErrorMessage != null)
                Text(
                  _passwordErrorMessage!,
                  style: TextStyle(
                    color: _passwordMessageColor,  // 메시지 색상 사용
                  ),
                ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: _registerUser,
                child: Text('다음'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xff473E7C),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
