import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firstflutterapp/FindAccountPage/pwchange.dart';
import 'package:firstflutterapp/server/apiserver.dart';
import 'package:flutter/material.dart';

import '../SignUpPage/signup2.dart';
import '../twilio_sms/twilioSMS.dart';

class Findpw extends StatefulWidget {
  @override
  _FindpwState createState() => _FindpwState();
}

class _FindpwState extends State<Findpw> {
  static String apiserver = ApiServer().getApiServer();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController authenticationNumberController = TextEditingController();
  bool isButtonEnabled = false;
  bool isAuthFieldEnabled = false;
  bool _isMember = false;
  String _messageNum="";
  String password="";

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    nameController.addListener(_updateButtonState);
    phoneNumberController.addListener(_updateButtonState);
    authenticationNumberController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    authenticationNumberController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = emailController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty &&
          authenticationNumberController.text.isNotEmpty;
    });
  }
  void _requestAuthNumber() {
    findUser();
    print(_isMember);
    if(_isMember){
      setState(() {
        _messageNum = TwilioSMS().generateRandomCode(); // 인증번호 생성
        print(_messageNum);
        isAuthFieldEnabled = true;
        print(phoneNumberController.text);
        // 인증번호 입력 칸 활성화
        TwilioSMS().sendSMS("+82${phoneNumberController.text}", "인증번호 : $_messageNum");
      });

    }
    // 인증번호 요청 로직
  }
  void findUser() async {
    var response = await http.post(
      Uri.parse('${apiserver}/find_pwd'),
      body: {
        'mem_email': emailController.text,
        'mem_name': nameController.text,
        'mem_phone': phoneNumberController.text
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body); // 응답 데이터를 디코드

      password = data[0];
      print(password);
      _isMember = true;
      print("!! : ${_isMember}");
    } else {
      // 사용자가 존재하지 않으면 알림 창 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("알림"),
            content: Text("가입되어 있지 않은 회원입니다. \n회원가입하시겠습니까?"),
            actions: <Widget>[
              TextButton (
                child: Text("예"),
                onPressed: () {
                  Navigator.of(context).pop(); // 알림 창 닫기
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                  // 회원가입 화면으로 이동
                },
              ),
              TextButton (
                child: Text("아니요"),
                onPressed: () {
                  Navigator.of(context).pop(); // 알림 창 닫기
                  // 로그인 화면으로 이동
                },
              ),
            ],
          );
        },
      );
      _isMember = false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('로그인 이메일 입력', style: Theme.of(context).textTheme.subtitle1),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: '이메일을 입력하세요',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            Text('휴대폰 인증', style: Theme.of(context).textTheme.titleLarge),
            Divider(height: 20, thickness: 2, color: Color(0xff473E7C),),
            Text('이름', style: Theme.of(context).textTheme.titleMedium),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: '이름을 입력하세요',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
            ),
            SizedBox(height: 20),
            Text('휴대폰 번호', style: Theme.of(context).textTheme.titleMedium),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: '휴대폰 번호를 입력하세요',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: authenticationNumberController,
                    decoration: InputDecoration(
                      hintText: '인증번호 입력',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[300],
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: _requestAuthNumber,
                  child: Text('인증번호 요청'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff473E7C),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: isButtonEnabled ? () {
                if(_messageNum == authenticationNumberController.text){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Pwchange(email: emailController.text ))
                  );
                }else{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("인증실패"),
                        content: Text("인증번호가 맞지 않습니다. \n요청 후 다시 입력해 주세요."),
                        actions: <Widget>[
                          TextButton (
                            child: Text("예"),
                            onPressed: () {
                              Navigator.of(context).pop(); // 알림 창 닫기
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => Pwchange(email: emailController.text)));
                              // 비밀번호 변경페이지로 이동
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              } : null,
              child: Text('확인'),
              style: ElevatedButton.styleFrom(
                primary: isButtonEnabled ? Color(0xff473E7C) : Colors.grey,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
