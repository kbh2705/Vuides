import 'package:flutter/material.dart';

class Signupcon extends StatefulWidget {
  @override
  _SignupconState createState() => _SignupconState();
}

class _SignupconState extends State<Signupcon> {
  final TextEditingController termsController = TextEditingController(text: '예시를 적어주세요');
  final TextEditingController privacyController = TextEditingController(text: '예시를 적어주세요');
  bool isTermsAgreed = false;
  bool isPrivacyAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('회원가입'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('이용약관', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.grey[200], // 박스의 배경색
            height: 100,
            width: 350,
            child: Text(termsController.text),
          ),
          CheckboxListTile(
            title: Text("동의합니다."),
            value: isTermsAgreed,
            onChanged: (bool? value) {
              setState(() {
                isTermsAgreed = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('개인정보취급방침', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.grey[200], // 박스의 배경색
            child: Text(privacyController.text),
          ),
          CheckboxListTile(
            title: Text("동의합니다."),
            value: isPrivacyAgreed,
            onChanged: (bool? value) {
              setState(() {
                isPrivacyAgreed = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          Spacer(), // 버튼을 아래로 밀어내기 위한 위젯
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: (isTermsAgreed && isPrivacyAgreed) ? () {
                // TODO: 다음 단계로 넘어가는 로직
              } : null,
              child: Text('다음'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // 버튼의 최소 크기
              ),
            ),
          ),
        ],
      ),
    );
  }
}
