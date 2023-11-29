import 'dart:convert';
import 'package:firstflutterapp/HomePage/button.dart';
import 'package:firstflutterapp/HomePage/ttsSpeak.dart';
import 'package:firstflutterapp/UpdatelistPage/updatelist.dart';
import 'package:firstflutterapp/UsageguidePage/usageguide.dart';
import 'package:firstflutterapp/server/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import '../BottomNavi/bottomnavi.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apiserver = ApiServer().getApiServer();
// KakaoMapController 선언
  late KakaoMapController _mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min, // Row의 크기를 자식들의 크기에 맞춥니다.
          children: <Widget>[
            Image.asset("assets/logo.png", scale: 12),
            const SizedBox(width: 8), // 로고와 텍스트 사이의 간격
            const Text("운전만해",
                style: TextStyle(
                  color: Color(0xff473E7C),
                  fontFamily: 'MyCustomFont',
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
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
                MaterialPageRoute(builder: (context) => UpdateList()),
              );
            },
          ),
          MenuButton(
            title: '운전해야 올바른 사용법',
            subtitle: '가이드 바로가기',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UsageGuide()),
              );
            },
          ),
         buildActionButtons(),
          _buildMapLabel(context),
          _buildMapButton(context),
          _buildBottomButtons(context),
        ],
      ),
    );
  }

  Widget MenuButton(
      {required String title,
      required String subtitle,
      required Null Function() onPressed}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onPressed,
      ),
    );
  }

  Widget _buildMapLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Bottomnavi(initialIndex: 1)),
            );
          },
          child: Text(
            '내 주변 주차장',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  Set<Marker> _markers = {};

  Future<void> findClosestParking() async {
    Position position = await getCurrentLocation(); // 현재 위치 가져오기
    try {
      final response = await http.get(
        Uri.parse(apiserver + '/find_closest_parking?current_lat=${position.latitude}&current_log=${position.longitude}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print("가까운 주차장 : ${responseData['closest_lat']} |  ${responseData['closest_log']}");
        print("내위치 : ${position.latitude} |  ${position.longitude}");
        TTSSpeak tts = TTSSpeak();
        tts.ttsSpeakAction(responseData['message']);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // 3초 후에 대화 상자를 자동으로 닫습니다.
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: Text('가까운 주차장 알림'),
              content: Text(responseData['message']),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop(); // 대화 상자를 닫습니다.
                  },
                ),
              ],
            );
          },
        );
        // 새로운 마커 생성
        Marker newMarker = Marker(
          latLng: LatLng(responseData['closest_lat'], responseData['closest_log']),
          markerId: "currentParking", // 예: 주차장 이름

        );

        setState(() {
          _markers.add(newMarker); // 마커 세트에 추가
        });

        // 지도의 중심을 새 마커 위치로 이동
        _mapController.setCenter(
          LatLng(responseData['closest_lat'], responseData['closest_log']),
        );
      } else {
        throw Exception('Failed to load closest parking');
      }
    } catch (e) {
      print(e.toString());
    }
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
    List<Marker> markersList = _markers.toList();
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Bottomnavi(
                    initialIndex: 1,
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff473E7C)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 300, // 지도 컨테이너 높이 설정
        child: FutureBuilder<Position>(
          future: getCurrentLocation(), // 현재 위치를 얻는 함수
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasData) {
              // 데이터가 있을 때 지도를 표시
              return KakaoMap(
                onMapCreated: (KakaoMapController controller) {
                  this._mapController = controller; // 지도 컨트롤러 초기화
                  // 현재 위치로 지도 중심 설정
                  getCurrentLocation().then((position) {
                    controller.setCenter(
                      LatLng(position.latitude, position.longitude),
                    );
                  });
                },
                  markers: markersList,
                // 여기에 지도 설정을 추가
              );
            } else {
              // 데이터를 기다리는 동안 로딩 인디케이터를 표시
              return const Center(child: CircularProgressIndicator());
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
          onPressed: () async {

            if (title == '가장 가까운 주차장') {
              Position position = await getCurrentLocation(); // 현재 위치 가져오기
              try {
                final response = await http.post(
                  Uri.parse('https://your-server.com/api/nearest-parking'), // 서버의 주차장 정보 API 엔드포인트
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode({
                    'latitude': position.latitude,
                    'longitude': position.longitude,
                  }),
                );

                if (response.statusCode == 200) {
                  var parkingData = json.decode(response.body);
                  // TODO: 지도에 마커를 찍는 함수 호출
                  // _showNearestParking(parkingData);
                } else {
                  // 서버 응답 에러 처리
                  throw Exception('Failed to load nearest parking');
                }
              } catch (e) {
                // 네트워크 요청 에러 처리
                print(e.toString());
              }
              await findClosestParking();
            } else if (title == '위치 재설정') {
              Position position = await getCurrentLocation(); // 현재 위치 가져오기
              _mapController.setCenter(
                LatLng(position.latitude, position.longitude),
              ); // 지도 중심을 현재 위치로 이동
            }
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xff473E7C),
            side: const BorderSide(color: Color(0xff473E7C)),
          ),
          child: Text(title),
        ),
      ),
    );
  }

  void _showNearestParking(Map<String, dynamic> parkingData) {
    // TODO: 지도에 마커를 찍는 로직 구현
    // 예: _mapController.addMarker(...)
  }
}
