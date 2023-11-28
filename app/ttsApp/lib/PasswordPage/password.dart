import 'dart:convert';

import 'package:firstflutterapp/LoginPage/login.dart';
import 'package:firstflutterapp/server/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../user/userModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Password(),
    );
  }
}

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final String apiserver = ApiServer().getApiServer();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isCurrentPasswordHidden = true;
  bool isNewPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  bool isButtonEnabled = false;
  bool isPwd = false;
  bool passwordsMatch = false;
  String? _passwordErrorMessage;
  Color? _passwordMessageColor;
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
  void initState() {
    super.initState();
    newPasswordController.addListener(_validatePasswords);
    confirmPasswordController.addListener(_validatePasswords);
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  void _validatePasswords() {
    passwordsMatch = newPasswordController.text == confirmPasswordController.text;
    bool passwordsNotEmpty = newPasswordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty;
    if(passwordsMatch && passwordsNotEmpty){
      setState(() {
        _passwordErrorMessage = '비밀번호가 일치합니다';
        _passwordMessageColor = Colors.green;
      });
    }
    else if(!passwordsMatch){
      setState(() {
        _passwordErrorMessage = '비밀번호가 일치하지 않습니다';
        _passwordMessageColor = Colors.red;
      });
    }
    setState(() {
      isButtonEnabled = passwordsMatch && passwordsNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('비밀번호 변경'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://placekitten.com/200/200'),
              ),
              SizedBox(height: 16),
              Text(UserMem().name, style: Theme.of(context).textTheme.headline6),
              SizedBox(height: 8),
              Text(UserMem().email, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 24),
              _buildPasswordTextField('현재 비밀번호', currentPasswordController, isCurrentPasswordHidden, () {

                setState(() {
                  isCurrentPasswordHidden = !isCurrentPasswordHidden;

                });
              }),
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
              if (_passwordErrorMessage != null)
                Text(
                  _passwordErrorMessage!,
                  style: TextStyle(
                    color: _passwordMessageColor,  // 메시지 색상 사용
                  ),
                ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: isButtonEnabled ? () async {
                  // TODO: Implement password change logic
                  if(currentPasswordController.text == UserMem().pwd){
                    isPwd = true;
                  }
                  if (!isPwd) {

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('비밀번호 오류'),
                          content: const Text('현재 비밀번호가 맞지 않습니다.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop(); // 알림창을 닫습니다.
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else if(newPasswordController.text == UserMem().pwd){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('동일한 비밀번호'),
                          content: const Text('현재 비밀번호와 변경하려는 비밀번호가 같습니다. 새 비밀번호를 다시 입력해주세요.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop(); // 알림창을 닫습니다.
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else{
                    int responeState = await changePwd(UserMem().email);
                     if(responeState == 200){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('비밀번호 변경 성공'),
                            content: const Text('비밀번호 변경에 성공하였습니다.\n다시 로그인 해주세요.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('확인'),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => Login())); // 알림창을 닫습니다.
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }else{
                       showDialog(
                         context: context,
                         builder: (BuildContext context) {
                           return AlertDialog(
                             title: const Text('비밀번호 변경 실패'),
                             content: const Text('죄송합니다.\n다시 시도해 주세요.'),
                             actions: <Widget>[
                               TextButton(
                                 child: const Text('확인'),
                                 onPressed: () {
                                   Navigator.of(context).pop(); // 알림창을 닫습니다.
                                 },
                               ),
                             ],
                           );
                         },
                       );
                     }
                  }
                } : null,
                child: const Text('변경하기'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: isButtonEnabled ? Theme.of(context).primaryColor : Colors.grey,
                  minimumSize: const Size(double.infinity, 36), // Match the button's width to the text fields
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
