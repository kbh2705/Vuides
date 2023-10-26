import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../LoginPage/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future:Firebase.initializeApp(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            print('Firebase 초기화 오류: ${snapshot.error}');
            return const Center(child: Text("Firebase 초기화 실패"),
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
            return Login();
          }
          return const CircularProgressIndicator();
        },
    );
  }
}
