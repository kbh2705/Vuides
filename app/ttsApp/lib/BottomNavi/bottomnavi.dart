import 'package:firstflutterapp/HomePage/home.dart';
import 'package:firstflutterapp/MapPage/map.dart';
import 'package:firstflutterapp/SettingPage/setting.dart';
import 'package:flutter/material.dart';

import '../InquiryPage/inquiry.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Bottomnavi(),
    );
  }
}

class Bottomnavi extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottomnavi> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Home(), // 여기에 홈 페이지 위젯을 넣으세요.
    MapPage(), // 여기에 주차장 페이지 위젯을 넣으세요.
    Inquiry(), // 여기에 문의 페이지 위젯을 넣으세요.
    Setting(), // 여기에 설정 페이지 위젯을 넣으세요.
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // 페이지 이동 로직을 여기에 추가하세요. 예를 들어 Navigator를 사용하거나, PageView 컨트롤러를 조작하세요.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // 현재 선택된 탭에 해당하는 페이지를 표시합니다.
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xff473E7C),),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car, color: Color(0xff473E7C),),
            label: '주차장',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sms, color: Color(0xff473E7C),),
            label: '문의',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Color(0xff473E7C),),
            label: '설정',
          ),
        ],
        currentIndex: _selectedIndex, // 현재 선택된 탭 인덱스
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}