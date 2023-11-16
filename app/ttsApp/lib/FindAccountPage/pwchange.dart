import 'package:firstflutterapp/FindAccountPage/findpwcom.dart';
import 'package:flutter/material.dart';

class Pwchange extends StatefulWidget {
  @override
  _PwchangeState createState() => _PwchangeState();
}

class _PwchangeState extends State<Pwchange> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
        backgroundColor: Colors.white,
        title: Text("아이디/비밀번호 찾기"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('비밀번호 재설정하기', style: Theme.of(context).textTheme.titleLarge),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Findpwcom()));
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
