import 'package:flutter/material.dart';
import 'package:project/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          Setting(),
        ]),
      ),
    );
  }
}

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 725,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 36,
                top: 205,
                child: SizedBox(
                  width: 42,
                  height: 23,
                  child: Text(
                    '아이디',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w100,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 402,
                child: Text(
                  '비밀번호 변경',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 337,
                child: Text(
                  '전화번호',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 273,
                child: Text(
                  '이메일',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 463,
                child: Text(
                  '회원탈퇴',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 384,
                child: Container(
                  width: 300,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 325,
                child: Container(
                  width: 300,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 261,
                child: Container(
                  width: 300,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 442,
                child: Container(
                  width: 300,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 300,
                child: Text(
                  'XXXXXXXX @naver.com',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 310,
                top: 402,
                child: Opacity(
                  opacity: 0.30,
                  child: Container(
                    width: 11.61,
                    height: 22.61,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://via.placeholder.com/12x23"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 231,
                child: Text(
                  'XXXX1234',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 305,
                top: 457,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 25.43,
                    height: 30.27,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://via.placeholder.com/25x30"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 362,
                child: Text(
                  '010 - XXXX - XXXX',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 143,
                top: 83,
                child: Container(
                  width: 64,
                  height: 61,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 60,
                          height: 60,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFFDBDADA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 18,
                                top: 10,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF8C9AE4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -15,
                                top: 40,
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF8C9AE4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(90),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 44,
                        top: 41,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 47,
                        top: 46,
                        child: Container(
                          width: 14,
                          height: 9.80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/14x10"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 150,
                top: 155,
                child: Text(
                  '김재영',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 180,
                top: 733,
                child: Text(
                  '설정',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 732,
                child: Text(
                  '문의',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 175,
                top: 733,
                child: Text(
                  '설정',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 309,
                top: 772,
                child: Text(
                  '설정',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 215,
                top: 771,
                child: Text(
                  '문의',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 205,
                top: 739,
                child: Container(
                  width: 46,
                  height: 30.96,
                  child: Stack(children: [
                  ]),
                ),
              ),
              Positioned(
                left: 0,
                top: 722,
                child: Container(
                  width: 360,
                  height: 78,
                  decoration: ShapeDecoration(
                    color: Color(0xFF8C9AE4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 124,
                top: 772,
                child: Text(
                  '주차',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 128,
                top: 733,
                child: Container(
                  width: 25,
                  height: 33,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/25x33"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 292,
                top: 772,
                child: Text(
                  '설정',
                  style: TextStyle(
                    color: Color(0xFF6B53FF),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 210,
                top: 772,
                child: Text(
                  '문의',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 51,
                top: 772,
                child: Text(
                  '홈',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w100,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 42,
                top: 737,
                child: Container(
                  width: 31,
                  height: 29,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 12.43,
                        child: Container(
                          width: 11.62,
                          height: 16.57,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(3),
                                bottomRight: Radius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 19.38,
                        top: 12.43,
                        child: Container(
                          width: 11.62,
                          height: 16.57,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(3),
                                bottomRight: Radius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5.81,
                        top: 21.75,
                        child: Transform(
                          transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-1.57),
                          child: Container(
                            width: 9.32,
                            height: 20.67,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 195,
                top: 735,
                child: Container(
                  width: 46,
                  height: 30.96,
                  child: Stack(children: [
                  ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}