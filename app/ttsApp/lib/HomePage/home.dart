import 'package:firstflutterapp/SettingPage/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import '../BottomNavi/bottomnavi.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Row(
          mainAxisSize: MainAxisSize.min, // Row의 크기를 자식들의 크기에 맞춥니다.
          children: <Widget>[
            Image.asset("assets/logo.png", scale: 12),
            SizedBox(width: 8), // 로고와 텍스트 사이의 간격
            Text("운전만해", style: TextStyle(color: Color(0xff473E7C),fontFamily: 'MyCustomFont',fontWeight: FontWeight.bold,)),
          ],
        ),
=======

        title: Image.asset("assets/logo.png", scale: 9,),
>>>>>>> afeb29cd0bd13c431ff04a69df046630d7809415
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          MenuButton(
            title: '운전해야 주요 업데이트',
            subtitle: '업데이트 바로가기',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
          ),
          MenuButton(title: '운전해야 올바른 사용법',
            subtitle: '가이드 바로가기',
            onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Home()),
            // );
          },
          ),
          _buildActionButtons(context),
          _buildMapLabel(),
          _buildMapButton(context),
          _buildBottomButtons(context),
        ],
      ),
    );
  }

  Widget MenuButton({required String title, required String subtitle, required Null Function() onPressed}) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onPressed,
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
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('위치 서비스가 비활성화되어 있습니다.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('위치 권한이 거부되었습니다.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('위치 권한이 영구적으로 거부되었습니다.');
    }

    return await Geolocator.getCurrentPosition();
  }
  Widget _buildMapButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Bottomnavi(initialIndex: 1,)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff473E7C)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: 200, // 지도 컨테이너 높이 설정
        child: FutureBuilder<Position>(
          future: getCurrentLocation(), // 현재 위치를 얻는 함수
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasData) {
              // 데이터가 있을 때 지도를 표시
              return KakaoMap(
                onMapCreated: (KakaoMapController controller) {
                  controller.setCenter(
                    LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  );
                },
                // 여기에 지도 설정을 추가
              );
            } else {
              // 데이터를 기다리는 동안 로딩 인디케이터를 표시
              return Center(child: CircularProgressIndicator());
            }
          },
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