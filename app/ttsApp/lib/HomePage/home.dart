import 'package:firstflutterapp/BottomNavi/test.dart';
import 'package:firstflutterapp/ContactPage/contact.dart';
import 'package:firstflutterapp/MapPage/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/logo.png", scale: 3,),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          MenuButton(title: '운전해야 주요 업데이트', subtitle: '업데이트 바로가기'),
          MenuButton(title: '운전해야 올바른 사용법', subtitle: '가이드 바로가기'),
          _buildActionButtons(context),
          Expanded(
            child: _buildMapSection(),
          ),
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
            onPressed: () {},
            child: Text('카카오톡 음성서비스 연결'),
            style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                minimumSize: Size(double.infinity, 50) // full width
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('내 연락처에서 개별 설정하기'),
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.deepPurple,
                side: BorderSide(color: Colors.deepPurple),
                minimumSize: Size(double.infinity, 50) // full width
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    // Assuming you have a widget that creates the map view, you might call it here.
    // For example, GoogleMap() if you're using google_maps_flutter plugin.
    // Here, we'll just use a placeholder.
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),
      child: Center(
        child: Text('여기에 지도가 들어가면 됩니다요'),
      ),
    );
  }
}