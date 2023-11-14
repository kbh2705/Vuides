import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late KakaoMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          KakaoMap(

            onMapCreated: (KakaoMapController controller) {
              mapController = controller;
            },
          ),
          Positioned(
            top: 10.0, // 상단 간격 조정
            left: 8.0,
            right: 8.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '검색...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onSubmitted: (String value) async {
                  // 검색 로직 구현
                  moveToSearchLocation(value);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: moveToCurrentLocation,
        tooltip: '현재 위치로 이동',
        child: Icon(Icons.my_location, color: Color(0xff473E7C)),
        backgroundColor: Colors.white,
      ),
    );
  }
  Future<void> moveToSearchLocation(String searchQuery) async {
    try {
      // 위치 검색 로직: 'searchQuery'를 사용하여 위치를 검색하고, 결과로 나온 위도와 경도를 사용합니다.
      LatLng searchLocation = await getSearchLocation(searchQuery);

      if (searchLocation != null) {
        mapController.setCenter(searchLocation);
      }
    } catch (e) {
      print('검색 위치로 이동하는 데 실패: $e');
    }
  }
  Future<LatLng> getSearchLocation(String searchQuery) async {
    // Kakao API의 URL
    var url = Uri.parse('https://dapi.kakao.com/v2/local/search/keyword.json?query=$searchQuery');
    // var url = Uri.parse('https://apis-navi.kakaomobility.com/v1/destinations/directions');

    // HTTP GET 요청
    // var response = await http.get(
    //   url,
    //   headers: {
    //     'Authorization': 'KakaoAK 0ef4ca8e7280a8ac497655eee1d14cd1' // 여기에 REST API 키를 입력합니다.
    //   },
    // );
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'KakaoAK 0ef4ca8e7280a8ac497655eee1d14cd1' // 여기에 REST API 키를 입력합니다.
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // 첫 번째 검색 결과의 위도와 경도를 가져옵니다.
      var firstResult = data['documents'][0];
      double lat = double.parse(firstResult['y']);
      double lng = double.parse(firstResult['x']);

      return LatLng(lat, lng);
    } else {
      throw Exception('Failed to load location data');
    }
  }


  Future<void> moveToCurrentLocation() async {
    try {
      Position position = await getCurrentLocation();
      mapController.setCenter(LatLng(position.latitude, position.longitude));
    } catch (e) {
      print('위치 정보를 가져오는 데 실패: $e');
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
}