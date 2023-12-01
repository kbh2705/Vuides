import 'package:firstflutterapp/InquiryPage/oneinquirycom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OneInquiry extends StatefulWidget {
  @override
  _OneInquiryState createState() => _OneInquiryState();
}

class _OneInquiryState extends State<OneInquiry> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    nameController.addListener(_updateButtonState);
    titleController.addListener(_updateButtonState);
    contentController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = emailController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          titleController.text.isNotEmpty &&
          contentController.text.isNotEmpty;
    });
  }

  void _sendInquiry() async {
    var url = Uri.parse('http://192.168.0.114:5000/submit_request'); // 실제 서버 URL로 변경하세요.
    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "mem_id": emailController.text,
          "req_title": titleController.text,
          "req_content": contentController.text,
          // 파일 데이터 추가 필요
        }),
      );

      if (response.statusCode == 200) {
        print('Inquiry submitted successfully');
        // 성공 시 OneInquiryCom 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OneInquiryCom()),
        );
      } else {
        print('Failed to submit inquiry');
        // 실패 로직 추가
      }
    } catch (e) {
      print(e.toString());
      // 오류 처리 로직 추가
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('1:1 문의하기'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithTitle(controller: emailController, title: '이메일'),
            TextFieldWithTitle(controller: nameController, title: '이름'),
            TextFieldWithTitle(controller: titleController, title: '제목'),
            TextFieldWithTitle(
              controller: contentController,
              title: '내용',
              maxLines: 10,
            ),
            AttachFileSection(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isButtonEnabled ? _sendInquiry : null,
              child: Text('보내기'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonEnabled ? Color(0xff473E7C) : Colors.grey,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50), disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12), // Button color when onPressed is null
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 사용자 입력을 받는 텍스트 필드와 제목을 갖는 위젯
class TextFieldWithTitle extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final int maxLines;

  const TextFieldWithTitle({
    Key? key,
    required this.controller,
    required this.title,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: 'Enter $title',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

// 첨부 파일 섹션을 표시하는 위젯
class AttachFileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('첨부 파일', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        // 첨부 파일 로직 추가 필요
        SizedBox(height: 16),
      ],
    );
  }
}
