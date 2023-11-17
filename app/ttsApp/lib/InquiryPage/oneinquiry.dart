import 'package:flutter/material.dart';

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
              onPressed: isButtonEnabled
                  ? () {
                // Send inquiry logic
              }
                  : null,
              child: Text('보내기'),
              style: ElevatedButton.styleFrom(
                primary: isButtonEnabled ? Color(0xff473E7C) : Colors.grey,
                minimumSize: Size(double.infinity, 50),
                onSurface: Colors.grey, // Button color when onPressed is null
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class AttachFileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('첨부 파일', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List<Widget>.generate(3, (index) {
            return Chip(
              label: Text('File ${index + 1}'),
              onDeleted: () {
                // Delete file logic
              },
            );
          }),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
