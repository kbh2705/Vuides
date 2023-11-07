import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firstflutterapp/BottomNavi/bottomnavi.dart';
import 'package:firstflutterapp/HomePage/home.dart';
import 'package:firstflutterapp/LoginPage/login.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  KakaoSdk.init(nativeAppKey: "b9a38eec8ae6c4e006a08a50b87c776f");
  AuthRepository.initialize(appKey: 'e03efe276acd3a02f61f08bc81a2526a');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hello",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
        crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
        children: [
          Image.asset("assets/logo2.png",width: 100,height: 100),
          Text(
            "운전만해",
            style: TextStyle(
              height: 0,
              fontSize: 30,
              fontFamily: 'MyCustomFont',
              color: Color(0xffffffff),
            ),
          ),
          const Text("오늘도 안전운전 하세요", style: TextStyle(fontSize: 18,
              fontFamily: 'MyCustomFont',
              height:4,fontWeight: FontWeight.normal, color: Colors.white))
        ],
      ),
      backgroundColor: Color(0xff473E7C),
      nextScreen: Home(),
      splashIconSize: 300,
      duration: 5000,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      animationDuration: const Duration(seconds: 1),
    );
  }
}