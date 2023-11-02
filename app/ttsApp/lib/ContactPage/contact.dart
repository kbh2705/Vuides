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
          Contact(),
        ]),
      ),
    );
  }
}

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 780,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 133,
                top: 102.05,
                child: Container(
                  width: 100,
                  height: 25,
                  child: Stack(children: [
                  ]),
                ),
              ),
              Positioned(
                left: 133,
                top: 50,
                child: Container(
                  width: 100,
                  height: 50.05,
                  child: Stack(children: [
                  ]),
                ),
              ),
              Positioned(
                left: 36,
                top: 161,
                child: Text(
                  '내 연락처',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 107,
                top: 241,
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
                left: 107,
                top: 345,
                child: Text(
                  '강병화',
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
                left: 107,
                top: 449,
                child: Text(
                  '이정연',
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
                left: 107,
                top: 553,
                child: Text(
                  '권준오',
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
                left: 107,
                top: 657,
                child: Text(
                  '이승준',
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
                left: 32,
                top: 220,
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
                left: 32,
                top: 324,
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
                left: 32,
                top: 428,
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
                left: 32,
                top: 532,
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
                left: 32,
                top: 636,
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
                left: 30,
                top: 200,
                child: Opacity(
                  opacity: 0.10,
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
              ),
              Positioned(
                left: 302,
                top: 170,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 19.99,
                    height: 20.47,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://via.placeholder.com/20x20"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 355,
                top: 200,
                child: Container(
                  width: 5,
                  height: 100,
                  decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}