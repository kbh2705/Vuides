import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   // 프레임 콜백을 추가하여 빌드 프로세스가 완료된 후 내비게이션 로직 실행
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _navigateWithKakaoNavi();
  //   });
  // }

  // Future<void> _navigateWithKakaoNavi() async {
  //   bool isInstalled = await NaviApi.instance.isKakaoNaviInstalled();
  //   if (isInstalled) {
  //     // 카카오내비 앱으로 길 안내 시작, WGS84 좌표계 사용
  //     await NaviApi.instance.navigate(
  //       destination: Location(name: '카카오 판교오피스', x: '127.108640', y: '37.402111'),
  //       // 경유지 추가
  //       viaList: [
  //         Location(name: '판교역 1번출구', x: '127.111492', y: '37.395225'),
  //       ],
  //     );
  //   }
  //   if (await canLaunchUrl(Uri.parse(NaviApi.webNaviInstall))) {
  //     await launchUrl(Uri.parse(NaviApi.webNaviInstall));
  //   } else {
  //     // 카카오내비 설치 페이지로 이동
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('카카오 내비 설치 페이지를 열 수 없습니다.')),
  //       );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('카카오 맵')),
      // 로더를 표시하여 처리 중임을 표시합니다. 필요에 따라 위젯을 커스텀할 수 있습니다.
      body: KakaoMap()
    );
  }
}
