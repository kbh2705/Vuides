import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
// 카카오톡 API 관련 패키지 임포트 필요 (예: kakao_flutter_sdk)



import '../server/apiserver.dart';
import '../user/userModel.dart';class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final String apiserver = ApiServer().getApiServer();
  List<String> friendsList = []; // 친구 목록을 저장할 리스트
  Future<void> fetchFriends(String userName) async {
    try {
      final response = await http.get(
        Uri.parse(apiserver + '/api/get_friends?userName=' + Uri.encodeComponent(userName)),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<String> friendsNames = jsonResponse.keys.toList(); // 이름만 추출
        setState(() {
          this.friendsList = friendsNames;
        });
        for(int i = 0; i<friendsList.length; i++){
          print(friendsList[i]);
        }
      } else {
        throw Exception('Failed to load friends');
      }

    } catch (e) {
      // 오류 처리
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // loadFriends(); // 친구 목록 로딩
    fetchFriends(UserMem().name);
  }

  // void loadFriends() async {
  //   // 친구 목록 로딩 로직 구현
  //   // 예: PickerApi.instance.selectFriends() 사용
  //   Friends friends = await TalkApi.instance.friends();
  //   friendsList.add(friends as Friend);
  //   // 결과를 friendsList에 저장
  // }

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
              backgroundImage: NetworkImage(friendsList[index]),
            ),
            title: Text(friendsList[index]),
            subtitle: Text('친구'),
            onTap: () {
              // 탭 이벤트 처리 (예: 상세 정보 표시)
            },
          );
        },
      ),
    );
  }
}
