import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
// 카카오톡 API 관련 패키지 임포트 필요 (예: kakao_flutter_sdk)

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Friend> friendsList = []; // 친구 목록을 저장할 리스트

  @override
  void initState() {
    super.initState();
    loadFriends(); // 친구 목록 로딩
  }

  void loadFriends() async {
    // 친구 목록 로딩 로직 구현
    // 예: PickerApi.instance.selectFriends() 사용
    Friends friends = await TalkApi.instance.friends();
    friendsList.add(friends as Friend);
    // 결과를 friendsList에 저장
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('친구 목록'),
      ),
      body: ListView.builder(
        itemCount: friendsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(friendsList[index].id as String),
            ),
            title: Text(friendsList[index].uuid),
            subtitle: Text('추가 정보'),
            onTap: () {
              // 탭 이벤트 처리 (예: 상세 정보 표시)
            },
          );
        },
      ),
    );
  }
}
