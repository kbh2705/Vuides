
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

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
// import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
// import '../LoginPage/test.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const App());
// }


// class App extends StatelessWidget {
//   const App({super.key});
//
//   @override
//   Future<Widget> build(BuildContext context) async {
    // return MaterialApp( // 또는 WidgetsApp
    //   home: FutureBuilder(
    //     future: Firebase.initializeApp(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         print('Firebase 초기화 오류: ${snapshot.error}');
    //         return const Center(
    //           child: Text("Firebase 초기화 실패"),
    //         );
    //       }
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         print("연결 성공");
    //         return const Center(
    //           child: Text("연결 성공"),
    //         );
    //       }
    //       return const CircularProgressIndicator();
    //     },
    //   ),
    // );
//
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
// import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
// import 'kakao_login.dart';
// import 'main_view_model.dart';
//
// void main() async{
//   KakaoSdk.init(nativeAppKey: "b9a38eec8ae6c4e006a08a50b87c776f");
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: "Flutter Demo",
//       theme: ThemeData(
//         primarySwatch: Colors.lightBlue,
//       ),
//       home: MyHomePage(title: 'hi',),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//  const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
//
// class _MyHomePageState  extends State<MyHomePage> {
//   final viewModel = MainViewModel(KakaoLogin());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image.network(
//                 viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? ''
//             ),
//             Text(
//               '${viewModel.isLogined}',
//               style: Theme.of(context).textTheme.headlineLarge,
//             ),
//             ElevatedButton(onPressed: () async{
//               await viewModel.login();
//               setState(() { });
//             },
//                 child: const Text("로그인"),
//             ),
//             ElevatedButton(onPressed: () async{
//               await viewModel.logout();
//               setState(() { });
//             },
//               child: const Text("로그아웃"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:kakao_map_plugin/kakao_map_plugin.dart';
// import 'kakao_login.dart';
// import 'main_view_model.dart';
//
// void main() async{
//   AuthRepository.initialize(appKey: 'e03efe276acd3a02f61f08bc81a2526a');
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: "Flutter Demo",
//       theme: ThemeData(
//         primarySwatch: Colors.lightBlue,
//       ),
//       home: MyHomePage(title: 'hi',),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
//
// class _MyHomePageState  extends State<MyHomePage> {
//   final viewModel = MainViewModel(KakaoLogin());
//
//   @override
//   Widget build(BuildContext context) {
//     Set<Circle> circles = {};
//     Set<Polyline> polylines = {};
//     Set<Polygon> polygons = {};
//     Set<Rectangle> rectangles = {};
//     Set<Marker> markers = {}; // 마커 변수
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title ?? "gi"),
//       ),
//       body: KakaoMap(
//         onMapCreated: (
//
//
//         markers.add(Marker(
//           markerId: UniqueKey().toString(),
//           latLng: await mapController.getCenter(),
//         ));
//
//         setState(() { });
//       ),
//         markers: markers.toList(),
//         center: LatLng(37.3608681, 126.9306506),
//       ),
//     );
//
//   }
// }

