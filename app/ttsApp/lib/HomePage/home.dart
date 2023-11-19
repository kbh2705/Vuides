import 'package:firstflutterapp/BottomNavi/test.dart';
import 'package:firstflutterapp/ContactPage/contact.dart';
import 'package:firstflutterapp/MapPage/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firstflutterapp/MapPage/map.dart';
import 'package:flutter/material.dart';

import '../BottomNavi/bottomnavi.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Image.asset("assets/logo.png", scale: 9,),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          MenuButton(title: '운전해야 주요 업데이트', subtitle: '업데이트 바로가기'),
          MenuButton(title: '운전해야 올바른 사용법', subtitle: '가이드 바로가기'),
          _buildActionButtons(context),
          _buildMapLabel(),
          _buildMapButton(context),
          _buildBottomButtons(context),
        ],
      ),
    );
  }

  Widget MenuButton({required String title, required String subtitle}) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // TODO: 여기에 '카카오톡 음성서비스 연결' 버튼이 눌렸을 때 실행할 코드를 추가하세요.
            },
            child: Text('카카오톡 음성서비스 연결'),
            style: ElevatedButton.styleFrom(
                primary: Color(0xff473E7C),
                minimumSize: Size(double.infinity, 50) // full width
            ),
          ),
          SizedBox(height: 8), // 버튼 사이의 간격을 주기 위해 사용
          ElevatedButton(
            onPressed: () {
              // TODO: 여기에 '내 연락처에서 개별 설정하기' 버튼이 눌렸을 때 실행할 코드를 추가하세요.
            },
            child: Text('내 연락처에서 개별 설정하기'),
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Color(0xff473E7C),
                side: BorderSide(color: Color(0xff473E7C)),
                minimumSize: Size(double.infinity, 50) // full width
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildMapLabel() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('내 주변 주차장', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildMapButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Bottomnavi()), // map.dart 내의 MapPage 클래스로 이동 --> 바꿔야함 하단 네비바 안나옴
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff473E7C)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: 200, // 지도 컨테이너 높이 설정
        child: Center(
          child: Text('지도 영역을 터치하면 상세 페이지로 이동합니다.'),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼을 고르게 배치
      children: [
        _buildOutlinedButton('가장 가까운 주차장', context),
        _buildOutlinedButton('위치 재설정', context),
      ],
    );
  }

  Widget _buildOutlinedButton(String title, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: OutlinedButton(
          onPressed: () {
            // TODO: 여기에 버튼이 눌렸을 때 수행할 작업을 넣으세요.
          },
          child: Text(title),
          style: OutlinedButton.styleFrom(
            primary: Color(0xff473E7C), // 버튼의 텍스트 색상
            side: BorderSide(color: Color(0xff473E7C)), // 테두리 색상
          ),
        ),
      ),
    );
  }
}
