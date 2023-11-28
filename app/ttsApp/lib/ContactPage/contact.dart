import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// 카카오톡 API 관련 패키지 임포트 필요 (예: kakao_flutter_sdk)



import '../server/apiserver.dart';
import '../user/userModel.dart';class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final String apiserver = ApiServer().getApiServer();
  final TextEditingController _searchController = TextEditingController();
  List<String> friendsList = []; // 친구 목록을 저장할 리스트
  List<String> filteredFriendsList = []; // 필터링된 친구 목록 데이터
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
          this.filteredFriendsList = friendsNames;
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
  void filterFriends(String query) {
    if (query.isNotEmpty) {
      List<String> _filteredFriends = friendsList.where((friend) {
        return friend.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredFriendsList = _filteredFriends;
      });
    } else {
      // 검색 쿼리가 비어있으면 모든 친구를 표시합니다.
      setState(() {
        filteredFriendsList = friendsList;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFriends(UserMem().name);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('내 연락처'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: filterFriends,
              decoration: InputDecoration(
                hintText: '검색',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredFriendsList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1.0,
            margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
            child: ListTile(
              leading: CircleAvatar(
                // TODO: 실제 프로필 이미지 URL을 설정하세요.
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              ),
              title: Text(filteredFriendsList[index]),
              subtitle: Text('친구'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // TODO: 탭 이벤트 처리를 구현하세요.
              },
            ),
          );
        },
      ),
    );
  }
}
