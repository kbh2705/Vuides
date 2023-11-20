import 'dart:convert';

import 'package:firstflutterapp/FindAccountPage/findpwcom.dart';
import 'package:firstflutterapp/LoginPage/login.dart';
import 'package:firstflutterapp/server/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Pwchange extends StatefulWidget {
  final String email;

  Pwchange({required this.email});

  @override
  _PwchangeState createState() => _PwchangeState();
}

class _PwchangeState extends State<Pwchange> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isNewPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  bool isButtonEnabled = false;

  static String apiserver =ApiServer().getApiServer();



  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(_validatePasswords);
    confirmPasswordController.addListener(_validatePasswords);
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    bool passwordsMatch = newPasswordController.text == confirmPasswordController.text;
    bool passwordsNotEmpty = newPasswordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty;
    setState(() {
      isButtonEnabled = passwordsMatch && passwordsNotEmpty;
    });
  }

  Future<int> changePwd(String email) async {
    var response = await http.post(
      Uri.parse('${apiserver}/update_pwd'),
      headers: {"Content-Type": "application/json"}, // 헤더 추가
      body: jsonEncode({ // JSON으로 인코딩
        'mem_email': email,
        'mem_pw': confirmPasswordController.text
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body); // 응답 데이터를 디코드
      print(data);
      return response.statusCode;
    } else {
      // 사용자가 존재하지 않으면 알림 창 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("알림"),
            content: Text("비밀번호를 변경하지 못했습니다.\n다시 시도해주세요."),
            actions: <Widget>[
              TextButton (
                child: Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop(); // 알림 창 닫기

                  // 회원가입 화면으로 이동
                },
              ),
            ],
          );
        },
      );
      return response.statusCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("아이디/비밀번호 찾기"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('비밀번호 재설정하기', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 16),
              _buildPasswordTextField('새 비밀번호', newPasswordController, isNewPasswordHidden, () {
                setState(() {
                  isNewPasswordHidden = !isNewPasswordHidden;
                });
              }),
              SizedBox(height: 16),
              _buildPasswordTextField('새 비밀번호 확인', confirmPasswordController, isConfirmPasswordHidden, () {
                setState(() {
                  isConfirmPasswordHidden = !isConfirmPasswordHidden;
                });
              }),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: isButtonEnabled ? () async {
                  int response = await changePwd(email);
                  if(response == 200){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Findpwcom()));
                  }
                } : null,
                child: Text('변경하기'),
                style: ElevatedButton.styleFrom(
                  primary: isButtonEnabled ? Theme.of(context).primaryColor : Colors.grey,
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 36), // Match the button's width to the text fields
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(String label, TextEditingController controller, bool isObscured, VoidCallback togglePasswordVisibility) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
          onPressed: togglePasswordVisibility,
        ),
      ),
      obscureText: isObscured,
    );
  }
}
