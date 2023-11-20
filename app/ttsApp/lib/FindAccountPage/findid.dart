import 'dart:convert';
import 'package:firstflutterapp/SignUpPage/signup.dart';
import 'package:firstflutterapp/server/apiserver.dart';
import 'package:firstflutterapp/user/userModel.dart';
import 'package:http/http.dart' as http;

import 'package:firstflutterapp/FindAccountPage/findidcom.dart';
import 'package:firstflutterapp/twilio_sms/twilioSMS.dart';
import 'package:flutter/material.dart';
import 'package:firstflutterapp/FindAccountPage/findpw.dart';

class IdPw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('아이디/비밀번호 찾기'),
          bottom: TabBar(
            tabs: [
              Tab(text: '아이디 찾기'),
              Tab(text: '비밀번호 찾기'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Findid(), // 아이디 찾기 페이지 위젯
            Findpw(), // 비밀번호 찾기 페이지 위젯
          ],
        ),
      ),
    );
  }
}

class Findid extends StatefulWidget {
  @override
  _FindidState createState() => _FindidState();
}

class _FindidState extends State<Findid> {
  static String apiserver = ApiServer().getApiServer(); // 서버 주소
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController authenticationNumberController = TextEditingController();
  bool isButtonEnabled = false;
  bool isAuthFieldEnabled = false;
  bool _isMember = false;
  String email = "";
  String _messageNum =  TwilioSMS().generateRandomCode();
  @override
  void initState() {
    super.initState();
    nameController.addListener(_updateButtonState);
    phoneNumberController.addListener(_updateButtonState);
    authenticationNumberController.addListener(_updateButtonState);

  }
  void _requestAuthNumber() {
    findUser();
    print(_isMember);
    if(_isMember){
      setState(() {
        _messageNum = TwilioSMS().generateRandomCode(); // 인증번호 생성
        print(_messageNum);
        isAuthFieldEnabled = true;
        // 인증번호 입력 칸 활성화
        TwilioSMS().sendSMS("+82${phoneNumberController.text}", "인증번호 : $_messageNum");
      });

    }
    // 인증번호 요청 로직
  }
  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    authenticationNumberController.dispose();
    super.dispose();
  }

  void _updateButtonState() {

    setState(() {
      if(nameController.text.isNotEmpty && phoneNumberController.text.isNotEmpty && authenticationNumberController.text.isNotEmpty){
        print(_messageNum);
        print(UserMem().phone);
        if(_messageNum == authenticationNumberController.text){
            isButtonEnabled = true;
        }else{
          isButtonEnabled = false;
        }

      }


    });
  }

  void findUser() async {
    var response = await http.post(
      Uri.parse('${apiserver}/find_id'),
      body: {
        'mem_name': nameController.text,
        'mem_phone': phoneNumberController.text
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body); // 응답 데이터를 디코드

      email = data[0];
      _isMember = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("알림"),
            content: Text("가입되어 있지 않은 회원입니다. 회원가입하시겠습니까?"),
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
    } else {
      // 사용자가 존재하지 않으면 알림 창 표시
      _isMember = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
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
                ),
              ],
            ),
            SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: authenticationNumberController,
                  enabled: isAuthFieldEnabled, // 여기서 입력 칸의 활성화 상태를 관리

                  decoration: InputDecoration(
                    hintText: '인증번호 입력',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[300],
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    // 나머지 설정 생략
                  ),
                  keyboardType: TextInputType.number, // 인증번호는 숫자 키보드 사용
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _requestAuthNumber, // 버튼을 누를 때 실행할 메소드
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
                  String name = nameController.text;
                  // 사용자의 이메일을 얻는 코드 추가// 백엔드로부터 받은 이메일 데이터
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Findidcom(
                          key: UniqueKey(),
                          name: name,
                          email: email
                      ))
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Findid()));
                              // 회원가입 화면으로 이동
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
                foregroundColor: Colors.white,
                backgroundColor: isButtonEnabled ? Color(0xff473E7C) : Colors.grey,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
