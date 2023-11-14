import 'package:firstflutterapp/AccountPage/account.dart';
import 'package:flutter/material.dart';

<<<<<<< HEAD
import '../TTSsettingPage/tts_setting.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
=======
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
>>>>>>> 9a3cc58a02c9dea2348be98fd0957e40985c2157
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Setting(),
    );
  }
}

class Setting extends StatelessWidget {
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
