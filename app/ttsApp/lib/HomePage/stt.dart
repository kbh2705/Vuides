// import 'package:flutter/material.dart';
//
// void startSTT() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Veez Guide',
//       home: VeezGuide(),
//     );
//   }
// }
// class VeezGuide extends StatefulWidget {
//   final String text;
//
//   VeezGuide({this.text = ''});
//
//   @override
//   _VeezGuideState createState() => _VeezGuideState();
//
// }
//
// class _VeezGuideState extends State<VeezGuide> {
//   final TextEditingController _controller = TextEditingController();
//   String _response = '';
//
//   void _answer(String inputText) {
//     setState(() {
//       _response = getResponse(inputText);
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('운전만해 가이드 브이즈'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(hintText: '말씀해 주세요'),
//             ),
//             SizedBox(height: 8.0),
//             ElevatedButton(
//               onPressed: () => _answer(_controller.text),
//               child: Text('응답'),
//             ),
//             SizedBox(height: 24.0),
//             Text(_response),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(home: VeezGuide()));
// }
