import 'package:firstflutterapp/FindAccountPage/findidcom.dart';
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
  _FindpwState createState() => _FindpwState();
}

class _FindpwState extends State<Findid> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController authenticationNumberController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_updateButtonState);
    phoneNumberController.addListener(_updateButtonState);
    authenticationNumberController.addListener(_updateButtonState);
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
      isButtonEnabled = nameController.text.isNotEmpty && phoneNumberController.text.isNotEmpty && authenticationNumberController.text.isNotEmpty;
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
                    decoration: InputDecoration(
                      hintText: '인증번호 입력',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[300],
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Implement phone number verification
                  },
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
                // Implement identity recovery
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Findidcom()));
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
