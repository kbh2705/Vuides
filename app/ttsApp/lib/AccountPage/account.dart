import 'package:firstflutterapp/AccountPage/memberDeletionService.dart';
import 'package:firstflutterapp/LoginPage/login.dart';
import 'package:firstflutterapp/server/apiserver.dart';
import 'package:flutter/material.dart';

import '../PasswordPage/password.dart';
import '../user/userModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Account(),
    );
  }
}

class Account extends StatelessWidget {
  String apiserver = ApiServer().getApiServer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('계정관리'),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // 화면에 맞지 않을 때 스크롤할 수 있게 해줍니다.
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://placekitten.com/200/200'), // 예시 이미지 URL
            ),
            SizedBox(height: 10),
            Text(UserMem().name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(UserMem().email, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStaticField('아이디(이메일 계정)', UserMem().email),
                  SizedBox(height: 16),
                  _buildStaticField('전화번호', UserMem().phone),
                  SizedBox(height: 16),
                  ListTile(
                    title: Text('비밀번호 변경'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Password()),
                      );
                      // 비밀번호 변경 로직 추가
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        int response =  MemberDeletionService().deleteMember(UserMem().email) as int;
                        if( response == 200){
                          //FIXME : 화면이동 안됨
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()));
                        }

                      },
                      child: Text('회원탈퇴'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(value, style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
