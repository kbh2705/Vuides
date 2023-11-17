import 'package:flutter/material.dart';

import '../user/userModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Password(),
    );
  }
}

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isCurrentPasswordHidden = true;
  bool isNewPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(_validatePasswords);
    confirmPasswordController.addListener(_validatePasswords);
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    bool passwordsMatch = newPasswordController.text == confirmPasswordController.text;
    bool passwordsNotEmpty = newPasswordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty;
    setState(() {
      isButtonEnabled = passwordsMatch && passwordsNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('비밀번호 변경'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://placekitten.com/200/200'),
              ),
              SizedBox(height: 16),
              Text(UserMem().name, style: Theme.of(context).textTheme.headline6),
              SizedBox(height: 8),
              Text(UserMem().email, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 24),
              _buildPasswordTextField('현재 비밀번호', currentPasswordController, isCurrentPasswordHidden, () {
                setState(() {
                  isCurrentPasswordHidden = !isCurrentPasswordHidden;
                });
              }),
              SizedBox(height: 16),
              _buildPasswordTextField('새 비밀번호', newPasswordController, isNewPasswordHidden, () {
                setState(() {
                  isNewPasswordHidden = !isNewPasswordHidden;
                });
              }),
              SizedBox(height: 16),
              _buildPasswordTextField('새 비밀번호 확인', confirmPasswordController, isConfirmPasswordHidden, () {
                setState(() {
                  isConfirmPasswordHidden = !isConfirmPasswordHidden;
                });
              }),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: isButtonEnabled ? () {
                  // TODO: Implement password change logic
                } : null,
                child: Text('변경하기'),
                style: ElevatedButton.styleFrom(
                  primary: isButtonEnabled ? Theme.of(context).primaryColor : Colors.grey,
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 36), // Match the button's width to the text fields
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(String label, TextEditingController controller, bool isObscured, VoidCallback togglePasswordVisibility) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
          onPressed: togglePasswordVisibility,
        ),
      ),
      obscureText: isObscured,
    );
  }
}
