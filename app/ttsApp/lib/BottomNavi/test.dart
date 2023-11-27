import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterTts flutterTts;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _volume = 0.5, _pitch = 1.0, _rate = 0.5;
  String _currentLang = 'en-US';
  String? _selectedVoice;
  List<dynamic> _voices = [];

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _speech = stt.SpeechToText();
    requestPermission();
    _getVoices();
  }

  void requestPermission() async {
    await Permission.microphone.request();
  }

  Future _getVoices() async {
    var voices = await flutterTts.getVoices;
    setState(() {
      _voices = voices;
    });
  }

  Future _speak() async {
    await flutterTts.setLanguage(_currentLang);
    await flutterTts.setVolume(_volume);
    await flutterTts.setPitch(_pitch);
    await flutterTts.setSpeechRate(_rate);
    if (_selectedVoice != null) {
      await flutterTts.setVoice({"name": _selectedVoice!});
    }
    await flutterTts.speak(_text);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TTS and STT Demo'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Language Selector
              DropdownButton<String>(
                value: _currentLang,
                items: <String>['en-US', 'ko-KR'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _currentLang = newValue!;
                  });
                },
              ),
              // Voice Selector
              DropdownButton<String>(
                hint: Text('Select Voice'),
                value: _selectedVoice,
                items: _voices.map((voice) {
                  return DropdownMenuItem<String>(
                    value: voice["name"],
                    child: Text(voice["name"]),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedVoice = newValue!;
                  });
                },
              ),
              // Text-to-Speech Controls
              TextField(
                onChanged: (value) {
                  _text = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter text to speak',
                ),
              ),
              ElevatedButton(
                onPressed: _speak,
                child: Text('Speak'),
              ),
              Slider(
                value: _volume,
                onChanged: (newVolume) {
                  setState(() => _volume = newVolume);
                },
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: "Volume: ${(_volume * 100).toStringAsFixed(0)}%",
              ),
              Slider(
                value: _rate,
                onChanged: (newRate) {
                  setState(() => _rate = newRate);
                },
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: "Rate: ${(_rate * 100).toStringAsFixed(0)}%",
              ),
              // Speech-to-Text Controls
              ElevatedButton(
                onPressed: _listen,
                child: Text(_isListening ? 'Stop Listening' : 'Listen'),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  _text,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
