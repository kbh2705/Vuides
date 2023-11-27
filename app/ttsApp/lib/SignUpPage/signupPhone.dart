import 'package:firstflutterapp/SignUpPage/signup2.dart';
import 'package:flutter/material.dart';

import 'package:firstflutterapp/server/apiserver.dart';
import 'package:firstflutterapp/user/userModel.dart';

import 'package:firstflutterapp/twilio_sms/twilioSMS.dart';


class SignupPhone extends StatefulWidget {
  final TabController tabController;
  SignupPhone({Key? key, required this.tabController}) : super(key: key);

  @override
  _SignupPhoneState createState() => _SignupPhoneState();
}

class _SignupPhoneState extends State<SignupPhone> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController authenticationNumberController = TextEditingController();
  bool isButtonEnabled = false;
  bool isAuthFieldEnabled = false;
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

      setState(() {
        _messageNum = TwilioSMS().generateRandomCode(); // 인증번호 생성
        print(_messageNum);
        isAuthFieldEnabled = true;
        // 인증번호 입력 칸 활성화
        TwilioSMS().sendSMS("+82${phoneNumberController.text}", "인증번호 : $_messageNum");
      });
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
                  widget.tabController.animateTo(2);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SignUp(isSelected: 2,))
                  // );
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
                              // Navigator.of(context).pop(); // 알림 창 닫기
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => SignupPhone()));
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
