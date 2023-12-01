import 'package:flutter/material.dart';

class HowToUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('앱 사용 가이드'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '사용방법',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.black, thickness: 1,),
            SizedBox(height: 10),
            Text(
              '''
운전만해" 앱 TTS 사용 가이드

TTS(Tex-to-Speech)란?
"운전만해" 앱의 TTS 기능을 활용하면 카카오톡 메시지를 음성으로 변환하여 들을 수 있습니다. 이를 통해 운전 중에도 안전하게 메시지를 확인할 수 있습니다.

1. 알림 리스너 시작하기:
"운전만해" 앱을 시작한 후, 홈페이지에 알림 리스너를 시작해야 합니다.
홈페이지에서 "알림 리스너 시작" 버튼을 눌러주세요.

2. 카카오톡 알림 설정:
TTS 기능을 사용하려면 카카오톡 알림을 켜놔야 합니다.
스마트폰 설정에서 카카오톡 알림을 활성화하고, 앱에 알림 권한을 부여해 주세요.

3. 음성 명령을 통한 기능 활용:
알림 리스너가 시작되면, "운전만해" 앱은 카카오톡 메시지를 감지하고 음성으로 읽어줍니다.
음성 명령을 사용하여 메시지에 대한 답장을 작성하거나 기타 기능을 활용하세요.

4. 음성 명령 예시:
"호출" - 브이즈를 불러옵니다.
"날씨" - 현재 날씨를 알려줍니다.
"시간" - 현재 시간을 알려줍니다.
"주차장" - 내 근처 가장 가까운 주차장을 알려줍니다.

5. 안전한 운전 환경 조성:
TTS를 사용하더라도 운전 중에는 안전을 우선으로 하세요.
운전 중 스마트폰을 조작하지 말고 음성 명령을 통해 손을 자유롭게 유지하세요.

6. 문제 발생 시 지원 요청:
사용 중에 문제가 발생하면 앱 내에서 지원을 요청할 수 있습니다.
사용자 지원 팀이 도움을 드릴 것입니다.
안전한 운전과 메시지 송수신을 위해 "운전만해" 앱의 TTS 기능을 활용하세요. 알림 리스너를 시작하고 카카오톡 알림을 활성화하여 TTS를 원활하게 사용할 수 있습니다.
              ''',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
