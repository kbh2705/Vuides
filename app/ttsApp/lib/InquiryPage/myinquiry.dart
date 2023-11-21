import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../server/apiserver.dart';
import '../user/userModel.dart';
import 'myinquirydetail.dart';

class MyInquiry extends StatelessWidget {
  static final String apiserver = ApiServer().getApiServer();
  Future<List<dynamic>> fetchInquiries() async {
    String userEmail = UserMem().email;
    final response = await http.get(
        Uri.parse('${apiserver}/user_requests?mem_email=$userEmail')
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['user_requests'] != null && data['user_requests'].isNotEmpty) {
        return data['user_requests'];
      } else {
        throw Exception('No inquiries found');
      }
    } else {
      throw Exception('Failed to load inquiries, Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchInquiries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text('문의사항이 없습니다.'));
        }

        return ListView(
          children: snapshot.data!.map((inquiry) {
            return InquiryTile(
              category: '[답변완료]', // You might want to update this dynamically based on the inquiry status
              title: inquiry['req_title'],
              dateTime: inquiry['req_received_at'],
              inquiryId: inquiry['req_idx'],
            );
          }).toList(),
        );
      },
    );
  }
}

class InquiryTile extends StatelessWidget {
  final String category;
  final String title;
  final String dateTime;
  final int inquiryId;

  InquiryTile({
    required this.category,
    required this.title,
    required this.dateTime,
    required this.inquiryId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(dateTime),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyInquiryDetail(inquiryId: inquiryId),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
