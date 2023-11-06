import 'package:firstflutterapp/oauth/kakao_login.dart';
import 'package:firstflutterapp/oauth/naver_login.dart';
import 'package:flutter/material.dart';

import '../LoginPage/login.dart';
class LogoutScreen extends StatelessWidget {
  // 실제 로그아웃 처리를 담당하는 함수
  Future<void> _handleLogout(BuildContext context) async {
    await KakaoLogin().logout();
    await NaverLogin().logout();

    // TODO: 로그아웃 처리 로직 구현
    // 예를 들어, 로그인 상태를 관리하는 상태 관리 라이브러리에 로그아웃을 알리거나,
    // 저장된 사용자 정보를 삭제하는 등의 작업을 할 수 있습니다.
    print('User logged out.');

    // 로그인 페이지 또는 다른 화면으로 이동
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()),
      );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _handleLogout(context),
          child: Text('Logout'),
        ),
      ),
    );
  }
}

// 로그아웃 후 이동할 로그인 화면의 예시입니다.
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}