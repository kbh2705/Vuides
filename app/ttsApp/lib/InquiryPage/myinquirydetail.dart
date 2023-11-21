import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../AccountPage/memberDeletionService.dart';
import '../user/userModel.dart';

// 이 클래스는 문의 상세 정보를 표시하는 페이지입니다.
class MyInquiryDetail extends StatelessWidget {
  final int inquiryId; // 문의 ID를 저장하는 변수
  String userEmail = UserMem().email;

  MyInquiryDetail({required this.inquiryId});

  // 문의 상세 정보를 불러오는 함수
  Future<Map<String, dynamic>> fetchInquiryDetail() async {
    final response = await http.get(
         Uri.parse('${MemberDeletionService.apiserver}/user_request_detail?mem_email=$userEmail&inquiry_id=$inquiryId')
      // Uri.parse('${MemberDeletionService.apiserver}/user_request_detail?inquiry_id=$inquiryId'), // 실제 API 엔드포인트로 교체해야 합니다.
      // Uri.parse('${MemberDeletionService.apiserver}/user_requests?mem_email=$userEmail && ?req_idx=$inquiryId'), // 실제 API 엔드포인트로 교체해야 합니다.
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load inquiry detail, Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('내 문의 내역'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchInquiryDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No inquiry details available'));
          }

          var data = snapshot.data!;
          // 아래는 예시 데이터 키입니다. 실제 응답 데이터 구조에 맞게 수정해야 합니다.
          var title = data['req_title'] ?? '제목 없음';
          var dateTime = data['req_received_at'] ?? '날짜 없음';
          var content = data['req_content'] ?? '내용 없음';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  dateTime,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                Divider(thickness: 1,),
                SizedBox(height: 16,),
                Text('문의 내용'),
                SizedBox(height: 16,),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                // 여기에 추가적인 상세 정보를 표시할 수 있습니다.
              ],
            ),
          );
        },
      ),
    );
  }
}
