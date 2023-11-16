import 'package:firstflutterapp/TermsPage/termsofuse.dart';
import 'package:flutter/material.dart';
import 'package:firstflutterapp/TermsPage/information.dart';
import 'package:firstflutterapp/TermsPage/location.dart';
import 'package:firstflutterapp/TermsPage/operational.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('환경설정'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://placekitten.com/200/200'),
          ),
          SizedBox(height: 10),
          Text('김재영', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('kbh2705@naver.com', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildListTile(context, '이용 약관', AnotherPage()),
                _buildListTile(context, '개인정보취급방침', AnotherPage()),
                _buildListTile(context, '위치기반 서비스 이용약관', AnotherPage()),
                _buildListTile(context, '운영 정책', AnotherPage()),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, Widget page) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.navigate_next),
      onTap: () {
        if (title == '이용 약관') {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Termsofuse()));
        }
        else if(title == '개인정보취급방침'){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Information()));
        }
        else if(title == '위치기반 서비스 이용약관'){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Location()));
        }
        else if(title == '운영 정책'){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Operational()));
        }
        else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
        }
      },
    );
  }

  Widget _buildListTileWithVersion(BuildContext context, String title, String version, Widget page) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            version,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Icon(Icons.navigate_next),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Text('Welcome to another page!'),
      ),
    );
  }
}
