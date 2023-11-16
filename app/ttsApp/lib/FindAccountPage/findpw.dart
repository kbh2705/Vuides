import 'package:firstflutterapp/FindAccountPage/pwchange.dart';
import 'package:flutter/material.dart';

class Findpw extends StatefulWidget {
  @override
  _FindpwState createState() => _FindpwState();
}

class _FindpwState extends State<Findpw> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController authenticationNumberController = TextEditingController();
  bool isButtonEnabled = false;

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
                // Implement password recovery
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Pwchange()));
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
