import 'package:flutter_tts/flutter_tts.dart';
class TTSSpeak{

  late FlutterTts flutterTts;
  double _volume = 0.5, _pitch = 1.0, _rate = 0.5;
  String _currentLang = 'en-KR';
  void ttsSpeakAction(String text){
    flutterTts = FlutterTts();
    flutterTts.setLanguage(_currentLang);
    flutterTts.setVolume(_volume);
    flutterTts.setPitch(_pitch);
    flutterTts.setSpeechRate(_rate);
    flutterTts.speak(text);
  }
}


