// import 'package:firstflutterapp/oauth/kakao_login.dart';
// import 'package:firstflutterapp/oauth/naver_login.dart';
// import 'package:flutter/material.dart';
// import '../ContactPage/contact.dart';
// import '../LoginPage/login.dart';
// import '../MapPage/map.dart';
// import '../SettingPage/setting.dart';
//
// class LogoutScreen extends StatelessWidget {
//   // 실제 로그아웃 처리를 담당하는 함수
//   Future<void> _handleLogout(BuildContext context) async {
//     await KakaoLogin().logout();
//     await NaverLogin().logout();
//
//     // TODO: 로그아웃 처리 로직 구현
//     // 예를 들어, 로그인 상태를 관리하는 상태 관리 라이브러리에 로그아웃을 알리거나,
//     // 저장된 사용자 정보를 삭제하는 등의 작업을 할 수 있습니다.
//     print('User logged out.');
//
//     // 로그인 페이지 또는 다른 화면으로 이동
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => Login()),
//       );
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Logout Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _handleLogout(context),
//           child: Text('Logout'),
//         ),
//       ),
//     );
//   }
// }
//
// // 로그아웃 후 이동할 로그인 화면의 예시입니다.
// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Center(
//         child: Text('Login Page'),
//       ),
//     );
//   }
// }
//
// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//   static const String _title = 'Flutter Code Sample';
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: MarketPage(),
//     );
//   }
// }
//
// class MarketPage extends StatefulWidget {
//   const MarketPage({Key? key}) : super(key: key);
//   @override
//   State<MarketPage> createState() => _MarketPageState();
// }
// class _MarketPageState extends State<MarketPage> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle = TextStyle(
//       fontSize: 30,
//       fontWeight: FontWeight.bold
//   );
//   final List<Widget> _widgetOptions = <Widget>[
//     Login(),
//     MapPage(),
//     Contact(),
//     Setting(),
//   ];
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//   // 메인 위젯
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.text_snippet),
//             label: '로그인',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: '주차장',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: '연락처',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.local_parking),
//             label: '설정',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.lightGreen,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
//   @override
//   void initState() {
//     //해당 클래스가 호출되었을떄
//     super.initState();
//   }
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }