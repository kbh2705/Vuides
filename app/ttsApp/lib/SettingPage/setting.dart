import 'package:flutter/material.dart';
import '../AccountPage/account.dart';
import '../LoginPage/login.dart';
import '../TTSsettingPage/tts_setting.dart';
import '../UpdatelistPage/updatelist.dart';
import '../UsageguidePage/usageguide.dart';
import '../TermsPage/terms.dart';
import '../oauth/kakao_login.dart';
import '../oauth/naver_login.dart';
import '../user/userModel.dart';

class Setting extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃 확인'),
          content: Text('정말로 로그아웃을 하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('아니오'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('예'),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        );
      },
    ) ?? false;

    if (confirm) {
      await KakaoLogin().logout();
      await NaverLogin().logout();
      print('User logged out.');

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('환경설정'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://placekitten.com/200/200'),
          ),
          SizedBox(height: 10),
          Text(UserMem().name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(UserMem().email, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildListTile(context, '계정관리', Account()),
                Divider(),
                _buildListTile(context, 'TTS 관리', TtsSetting()),
                Divider(),
                _buildListTile(context, '업데이트 내역', UpdateList()),
                Divider(),
                _buildListTile(context, '약관 및 정책', Terms()),
                Divider(),
                _buildListTile(context, '앱 사용 가이드', UsageGuide()),
                _buildListTileWithVersion(context, '앱 정보', '최신 버전 1.2.0'),
              ],
            ),
          ),
          Divider(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16.0, bottom: 10.0),
              child: InkWell(
                child: Text(
                  '로그아웃',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                onTap: () {
                  _logout(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, Widget page) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.navigate_next),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => page));
      },
    );
  }

  Widget _buildListTileWithVersion(BuildContext context, String title,
      String version) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            version,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Icon(Icons.navigate_next),
        ],
      ),
      onTap: title != '앱 정보' ? () {
        // 여기에 타일이 클릭되었을 때 수행할 로직을 추가하세요.
      } : null, // '앱 정보' 타일을 클릭했을 때 아무 동작도 하지 않음
    );
  }
}