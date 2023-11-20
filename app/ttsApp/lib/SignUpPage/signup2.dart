import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hello",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SignuptwoScreen(),
    );
  }
}


class SignuptwoScreen extends StatelessWidget {
  SignuptwoScreen({Key? key}) : super(key: key);

  TextEditingController termsController = TextEditingController();
  TextEditingController privacyController = TextEditingController();
  bool termsAgreed = false;
  bool privacyAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('이용약관', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: SingleChildScrollView(
                child: TextField(
                  controller: termsController,
                  maxLines: null, // 스크롤 가능하게
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '이용약관 내용',
                  ),
                ),
              ),
            ),
            CheckboxListTile(
              title: Text('이용약관에 동의합니다.'),
              value: termsAgreed,
              onChanged: (bool? value) {
                // 체크박스 상태 업데이트 로직
              },
            ),
            SizedBox(height: 16),
            Text('개인정보취급방침', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: SingleChildScrollView(
                child: TextField(
                  controller: privacyController,
                  maxLines: null, // 스크롤 가능하게
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '개인정보취급방침 내용',
                  ),
                ),
              ),
            ),
            CheckboxListTile(
              title: Text('개인정보취급방침에 동의합니다.'),
              value: privacyAgreed,
              onChanged: (bool? value) {
                // 체크박스 상태 업데이트 로직
              },
            ),
            ElevatedButton(
              child: Text('다음'),
              onPressed: () {
                // 버튼 클릭 이벤트 로직
              },
            ),
          ],
        ),
      ),
    );
  }
}
