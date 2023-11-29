import 'package:flutter/material.dart';

class Precautions extends StatelessWidget {
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
              '사용시 주의사항',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.black, thickness: 1,),
            SizedBox(height: 10),
            Text(
              '''
TTS 기능 사용 주의사항

운전 중에 주의하세요: TTS 기능은 운전 중에 메시지를 읽어주는 데 도움을 주지만, 항상 운전 중에는 주의를 기울이세요. 운전 중에 스마트폰을 조작하지 마시고, 음성 명령을 사용해 손을 자유롭게 유지하세요.

긴급 상황에 집중하세요: 긴급 상황이나 급정거 등에 대비하여 항상 도로와 교통 환경에 집중하세요. TTS 기능을 통한 메시지 확인은 안전한 조건에서만 수행하세요.

알림 권한 설정: TTS를 사용하려면 카카오톡 알림이 켜져 있어야 합니다. 스마트폰 설정에서 알림 권한을 확인하고 활성화하세요.

프라이버시 유지: TTS 기능을 사용하면 메시지 내용이 음성으로 읽힐 수 있습니다. 다른 사람이 함께 있거나 민감한 정보를 다룰 때에는 주의하세요.

음성 명령 사용 시 조용한 환경: 음성 명령을 사용할 때 주변 환경이 조용한 곳에서 사용하세요. 시끄러운 환경에서는 명령이 제대로 인식되지 않을 수 있습니다.

필요한 명령어 학습: "운전만해" 앱의 TTS 기능은 명령어를 학습합니다. 자주 사용하는 명령어를 사용하여 정확한 명령어 인식을 도와주세요.

문제 발생 시 지원 요청: TTS 기능 사용 중 문제가 발생하면  지원 팀에문의하여 도움을 받으세요. 문제를 빠르게 해결할 수 있도록 도움을 줄 것입니다.

안전한 운전을 최우선으로: TTS 기능은 편리한 도우미이지만, 항상 안전한 운전을 최우선으로 여기세요. 운전 중 스마트폰 사용을 최소화하고 안전 운전을 지켜주세요.

이러한 주의사항을 염두에 두고 "운전만해" 앱의 TTS 기능을 사용하면, 안전하게 메시지를 확인하고 메시지를 전달할 수 있을 것입니다.
              ''',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
