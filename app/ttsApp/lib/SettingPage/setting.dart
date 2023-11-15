

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AccountPage/account.dart';

import '../LoginPage/login.dart';
import '../TTSsettingPage/tts_setting.dart';
import '../oauth/kakao_login.dart';
import '../oauth/naver_login.dart';




class Setting extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    // 알림창을 표시합니다
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
                Navigator.of(context).pop(false); // false를 반환하며 대화상자를 닫습니다.
              },
            ),
            TextButton(
              child: Text('예'),
              onPressed: () {
                Navigator.of(context).pop(true); // true를 반환하며 대화상자를 닫습니다.
              },
            ),
          ],
        );
      },
    ) ?? false; // 사용자가 대화상자를 닫을 경우 false를 반환합니다.

    // 사용자가 '예'를 선택한 경우 로그아웃 처리를 진행합니다
    if (confirm) {
      await KakaoLogin().logout();
      await NaverLogin().logout();
      print('User logged out.');


      // 로그인 페이지 또는 다른 화면으로 이동
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          Text('김재영', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('kbh2705@naver.com', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildListTile(context, '계정관리', AnotherPage()),
                _buildListTile(context, 'TTS 관리', AnotherPage()),
                _buildListTile(context, '업데이트 내역', AnotherPage()),
                _buildListTile(context, '약관 및 정책', AnotherPage()),
                _buildListTile(context, '앱 사용 가이드', AnotherPage()),
                _buildListTileWithVersion(context, '앱 정보', '최신 버전 1.0.0', AnotherPage()),
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
                  // 로그아웃 로직을 여기에 구현합니다.
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
        if (title == 'TTS 관리') {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TtsSetting()));
        }
        else if(title == '계정관리'){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Account()));
        }
        else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
        }
      },
    );
  }

  Widget _buildListTileWithVersion(BuildContext context, String title, String version, Widget page) {
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
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Text('Welcome to another page!'),
      ),
    );
  }
}
