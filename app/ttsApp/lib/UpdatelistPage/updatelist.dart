import 'package:firstflutterapp/UpdatelistPage/updatedetail.dart';
import 'package:flutter/material.dart';

class UpdateList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('업데이트 내역'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('업데이트 내역 제목 A'),
              subtitle: Text('2023.11.09 13:33'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 항목 A를 탭했을 때의 동작 구현
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpDateDetail()));
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('업데이트 내역 제목 B'),
              subtitle: Text('2023.11.05 08:57'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 항목 B를 탭했을 때의 동작 구현
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('업데이트 내역 제목 C'),
              subtitle: Text('2023.11.01 16:06'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 항목 C를 탭했을 때의 동작 구현
              },
            ),
          ),
          // 추가적인 항목들...
        ],
      ),
    );
  }
}
