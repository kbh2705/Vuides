import 'package:flutter/material.dart';

class UsageGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('앱 사용 가이드'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Image.asset("assets/logo.png", width: 300, height: 150,),
          Text(
            '운전만해',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 26,),
          ListTile(
            title: Text('운전만해란?'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to the "운전만해란?" content
            },
          ),
          Divider(),
          ListTile(
            title: Text('사용 방법'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to the "사용 방법" content
            },
          ),
          Divider(),
          ListTile(
            title: Text('사용시 주의할 점'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to the "사용시 주의할 점" content
            },
          ),
        ],
      ),
    );
  }
}

