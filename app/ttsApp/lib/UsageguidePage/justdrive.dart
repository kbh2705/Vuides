import 'package:flutter/material.dart';

class JustDrive extends StatelessWidget {
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
              '운전만해란?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.black, thickness: 1,),
            SizedBox(height: 10),
            Text(
              '''"운전만해" 앱 사용 가이드

1. 회원 가입 및 로그인:

"운전만해" 앱을 설치한 후, 회원 가입을 진행하세요.
이미 가입한 경우 로그인을 통해 앱에 접속할 수 있습니다.
2. 앱 설정:

로그인 후, 앱 설정을 확인하고 필요한 정보를 입력하세요.
앱 설정에서는 음성 명령, 알림 설정, 프로필 설정 등을 변경할 수 있습니다.
3. 음성 명령 사용:

"운전만해" 앱은 음성 명령을 사용하여 메시지를 작성하고 전송할 수 있습니다.
음성 명령을 활용하여 "메시지 작성", "메시지 전송" 등을 시도하세요.
4. 메시지 수신 및 확인:

다른 사용자로부터 메시지를 받으면, 앱은 메시지를 음성으로 읽어줍니다.
메시지를 확인하려면 음성 명령 또는 화면을 탭하세요.
5. 교통 정보와 안내:

"운전만해" 앱은 교통 정보와 운전 안내도 제공합니다.
목적지 설정, 경로 안내, 교통 상황 업데이트를 활용하세요.
6. 음성 메모 및 주문:

앱을 사용하여 음성 메모를 작성하거나 주문을 할 수 있습니다.
메모 작성, 음식 주문, 주차료 결제 등을 음성 명령으로 시도하세요.
7. 음성 검색 및 인식 개선:

앱은 음성 검색과 인식을 개선하기 위해 학습합니다.
더 정확한 음성 명령을 위해 자주 사용하는 명령어를 사용해 보세요.
8. 광고 및 스폰서십:

앱 내에서 광고가 표시될 수 있으며, 스폰서십이 있는 경우 투명하게 표시됩니다.
광고는 사용자 경험을 저해하지 않도록 고려됩니다.
9. 문제 해결 및 지원:

앱 사용 중에 문제가 발생하거나 질문이 있으면, 앱 내에서 지원을 요청하세요.
사용자 지원 팀이 도움을 드릴 것입니다.
10. 안전 운전 유지:
- 앱을 사용하더라도 교통 법규와 안전 운전에 항상 주의를 기울이세요.
- 운전 중 스마트폰 사용을 최소화하도록 노력하세요.

11. 의견 제출:
- "운전만해" 앱을 개선하기 위한 의견이나 제안이 있으면 언제든지 피드백을 제출하세요.
- 사용자 의견을 바탕으로 앱을 개선합니다.

12. 로그아웃 및 계정 관리:
- 로그아웃 또는 계정 관리는 앱 설정에서 수행할 수 있습니다.
- 필요한 경우 계정 정보를 업데이트하세요.

이 사용 가이드를 참고하여 "운전만해" 앱을 효과적으로 활용하세요. 안전한 운전과 메시지 전달을 위해 음성 명령을 활용하여 스마트폰 조작을 최소화하세요. 언제든지 사용자 지원 팀에 문의하여 도움을 받을 수 있습니다. 감사합니다!
''',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
