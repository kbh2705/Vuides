import 'package:firstflutterapp/server/apiserver.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MemberDeletionService {
  static final String apiserver = ApiServer().getApiServer();
  final String deleteUrl;

  MemberDeletionService() : deleteUrl = apiserver + "/delete_member";

  Future<int> deleteMember(String userEmail) async {
    Map<String, String> data = {'mem_email': userEmail};

    try {
      final response = await http.post(
        Uri.parse(deleteUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // 처리 성공
        return response.statusCode;
      } else {
        // 서버 오류 처리
        throw Exception('Failed to delete member');
      }
    } catch (e) {
      // 네트워크 오류 처리
      throw Exception('Network error: $e');
    }
  }
}
