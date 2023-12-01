import 'package:flutter/material.dart';

class Operational extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('약관 및 정책'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '운전만해 앱 운영정책',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '''
1. 개인 정보 보호:
사용자 개인 정보를 보호하기 위해 GDPR 및 관련 법률 및 규정을 준수합니다.
사용자의 동의 없이 개인 정보를 수집 또는 공유하지 않습니다.

2. 안전 및 규정 준수:

"운전만해" 앱을 사용하면서 교통 법규 및 규정을 준수하는 것을 촉진합니다.
운전 중에 스마트폰 사용을 제한하여 교통 안전에 기여합니다.

3. 콘텐츠 관리:
앱 내에서 유해하거나 불법적인 콘텐츠를 게시하거나 공유하는 행위를 금지합니다.
신고 시스템을 통해 부적절한 콘텐츠를 식별하고 제거합니다.

4. 사용자 지원 및 피드백:
사용자 지원 팀을 운영하여 사용자의 문의나 불만을 신속하게 처리하고 지원합니다.
사용자 피드백을 수집하고 앱의 개선에 반영합니다.

5. 광고 및 스폰서십:
광고는 사용자 경험을 저해하지 않도록 적절하게 관리하며, 광고 콘텐츠의 품질을 검토합니다.
스폰서십이 있는 경우 투명하게 표시하고 관련 법률 및 규정을 준수합니다.

6. 보안 및 앱 안정성:
사용자 데이터의 보안을 위해 적절한 보안 조치를 시행하며, 주기적인 보안 검토를 진행합니다.
앱의 안정성을 유지하기 위해 버그 및 이슈에 대한 빠른 조치를 취합니다.

7. 투명성과 통신:
사용자와의 투명한 소통을 유지하며, 서비스 변경 또는 정책 업데이트에 대한 공지를 제공합니다.
사용자에게 운전만해 앱의 목적, 기능, 수익 모델 등에 대한 정보를 제공합니다.

8. 합법적인 사용:
앱을 합법적인 목적으로 사용하도록 촉진하며, 불법적인 용도로 사용하는 것을 금지합니다.
              ''',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
