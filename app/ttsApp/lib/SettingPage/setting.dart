import 'package:flutter/material.dart';

import '../BottomNavi/test.dart';
import '../LoginPage/login.dart';
import '../oauth/kakao_login.dart';
import '../oauth/naver_login.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 27, // 'h' or 'v' suffixes were removed since they are not standard
            vertical: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50), // Placeholder for CustomImageView
              SizedBox(height: 2),
              SizedBox(height: 25), // Placeholder for another CustomImageView
              SizedBox(height: 87),
              _buildWidget(context, userName: "User Name"), // 'tr' method removed
              SizedBox(height: 34),
              _buildWidget(context, userName: "Settings Option 1"),
              SizedBox(height: 34),
              _buildWidget(context, userName: "Settings Option 2"),
              SizedBox(height: 34),
              _buildRecentOrders(context),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentOrders(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(onPressed: () { _handleLogout(context); }, child: Text(
    '로그아웃', style: TextStyle(color: Colors.white, fontSize: 18)),
    )


      ],
    );
  }

  Widget _buildWidget(BuildContext context, {required String userName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          userName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black, // 'appTheme.black900' was a custom color
          ),
        ),
        Icon(Icons.arrow_forward_ios), // Placeholder for Opacity wrapped CustomImageView
      ],
    );
  }
}
