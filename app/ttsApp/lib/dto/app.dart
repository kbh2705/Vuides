// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// //
// // import '../LoginPage/login.dart';
// //
// // class App extends StatelessWidget {
// //   const App({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     return FutureBuilder(
// //       future:Firebase.initializeApp(),
// //         builder: (context,snapshot){
// //           if(snapshot.hasError){
// //             print('Firebase 초기화 오류: ${snapshot.error}');
// //             return const Center(child: Text("Firebase 초기화 실패"),
// //             );
// //           }
// //           if(snapshot.connectionState == ConnectionState.done){
// //             return Login();
// //           }
// //           return const CircularProgressIndicator();
// //         },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:kakao_flutter_sdk/all.dart';
// import 'package:mysql1/mysql1.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SignInDemo(),
//     );
//   }
// }
//
// class SignInDemo extends StatefulWidget {
//   @override
//   _SignInDemoState createState() => _SignInDemoState();
// }
//
// class _SignInDemoState extends State<SignInDemo> {
//
//   void _signInWithKakao() async {
//     final authCode = await AuthCodeClient.instance.request();
//     final token = await AuthApi.instance.issueAccessToken(authCode);
//     AccessTokenStore.instance.toStore(token);
//
//     final User user = await UserApi.instance.me();
//
//     final connection = await MySqlConnection.connect(ConnectionSettings(
//       host: 'your-database-host',
//       port: 3306,
//       user: 'your-database-username',
//       db: 'your-database-name',
//       password: 'your-database-password',
//     ));
//
//     final result = await connection.query(
//       'INSERT INTO users (name, email) VALUES (?, ?)',
//       [user.nickname, user.kakaoAccount.email],
//     );
//
//     // Don't forget to close the connection
//     await connection.close();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign in with Kakao'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _signInWithKakao,
//           child: Text('Sign In with Kakao'),
//         ),
//       ),
//     );
//   }
// }
//
