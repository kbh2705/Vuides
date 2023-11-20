// test 폴더
// test하는 폴더, dart언어 test하는데 사용
// 실행시 run, logcat 부분에 print문이 출력

//dart 언어 실행하기 위한 main메소드가 필요
import 'dart:js';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main(){
  print("hello");
  // 변수
  // 논리형 타입
  bool b = true; // 소문자
  bool b2 = false;

  //숫자 타입
  int i = 10;

  //실수형
  double d = 3.14;

  //정수, 실수 상관없는 타입
  num n = 10;
  n = 3.14;

  print(i);
  print(d);
  print(n);

  String s = '''hello
  world
  my name is
  Flutter ''';
  print(s);

  //var타입, dynamic타입
  var v = 10;
  // var 타입은 한번 결정된 타입을 변동 할 수 없습니다.
  // v = "hello"; -> 오류남!
  v = 12;
  // 같은 타입으로는 바꾸는 것이 가능

  //dynamic 타입은 타입의 변동이 가능!
  dynamic dy = 10;
  dy = "hello";

  //포매팅 --$로 표시
  String name = 'flutter';
  int version = 3;
  print("$name의 버전은 $version입니다.");

  // -------------연산자 -----------
  // % 나머지 , ~/ 몫 연산자
}
