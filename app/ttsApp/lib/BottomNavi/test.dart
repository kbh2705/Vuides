import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'background_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBackgroundService.initialize(onStart);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Assistant',
      home: VoiceAssistantPage(),
    );
  }
}

class VoiceAssistantPage extends StatefulWidget {
  @override
  _VoiceAssistantPageState createState() => _VoiceAssistantPageState();
}

class _VoiceAssistantPageState extends State<VoiceAssistantPage> {
  final FlutterBackgroundService _service = FlutterBackgroundService();
  String _text = 'Press the button and start speaking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voice Assistant')),
      body: Center(child: Text(_text)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _service.sendData({"action": "startListening"});
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
