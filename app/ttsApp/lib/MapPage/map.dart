import 'package:flutter/material.dart';


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
        body: ListView(children: const [
          MapPage(),
        ]),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 725,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 360,
                  height: 806,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/360x806"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 322,
                top: 160,
                child: Container(
                  width: 29,
                  height: 35,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 29,
                          height: 35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/29x35"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 6,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFFFEFE),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 114,
                top: 424,
                child: Container(
                  width: 38.11,
                  height: 46,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 38.11,
                          height: 46,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/38x46"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 9.20,
                        top: 7.89,
                        child: Container(
                          width: 19.71,
                          height: 19.71,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFFFEFE),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 20,
                child: Container(
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 279,
                top: 41,
                child: Opacity(
                  opacity: 0.30,
                  child: Container(
                    width: 27.74,
                    height: 28.41,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://via.placeholder.com/28x28"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 80,
                top: 42,
                child: SizedBox(
                  width: 219,
                  height: 35,
                  child: Text(
                    '주변 주차 가능 구역 ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 108,
                top: 259,
                child: Container(
                  width: 29,
                  height: 35,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 29,
                          height: 35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/29x35"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 6,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFFFEFE),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 654,
                child: Container(
                  width: 29,
                  height: 35,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 29,
                          height: 35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/29x35"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 6,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFFFEFE),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 280,
                top: 100,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 290,
                top: 110,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: ShapeDecoration(
                    shape: OvalBorder(side: BorderSide(width: 1)),
                  ),
                ),
              ),
              Positioned(
                left: 295,
                top: 124,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
                  child: Container(
                    width: 10,
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
              ),
              Positioned(
                left: 305,
                top: 145,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-1.57),
                  child: Container(
                    width: 10,
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
              ),
              Positioned(
                left: 305,
                top: 115,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-1.57),
                  child: Container(
                    width: 10,
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
              ),
              Positioned(
                left: 325,
                top: 124,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
                  child: Container(
                    width: 10,
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
              ),
              Positioned(
                left: 168.15,
                top: 496,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(0.03),
                  child: Container(
                    width: 25,
                    height: 41,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Transform(
                            transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(0.03),
                            child: Container(
                              width: 25,
                              height: 41,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("https://via.placeholder.com/25x41"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 18.76,
                          top: 36.75,
                          child: Transform(
                            transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.09),
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.00, -1.00),
                                  end: Alignment(0, 1),
                                  colors: [Color(0xFF6B53FF), Color(0xFF8C9AE4)],
                                ),
                                shape: OvalBorder(),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 180,
                top: 734,
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
                top: 733,
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
                top: 734,
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
                top: 773,
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
                left: 205,
                top: 740,
                child: Container(
                  width: 46,
                  height: 30.96,
                  child: Stack(children: [

                  ]),
                ),
              ),
              Positioned(
                left: 0,
                top: 723,
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
                top: 773,
                child: Text(
                  '주차',
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
                left: 128,
                top: 734,
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
                top: 773,
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
                left: 210,
                top: 773,
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
                top: 773,
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
                top: 738,
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
                top: 736,
                child: Container(
                  width: 46,
                  height: 30.96,
                  child: Stack(children: [

                  ]),
                ),
              ),
              Positioned(
                left: 180,
                top: 734,
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
                top: 733,
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
                top: 734,
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
                top: 773,
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
                left: 205,
                top: 740,
                child: Container(
                  width: 46,
                  height: 30.96,
                  child: Stack(children: [

                  ]),
                ),
              ),
              Positioned(
                left: 0,
                top: 723,
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
                top: 773,
                child: Text(
                  '주차',
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
                left: 128,
                top: 734,
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
                top: 773,
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
                left: 210,
                top: 773,
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
                top: 773,
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
                top: 738,
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
                top: 736,
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