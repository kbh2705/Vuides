import 'package:flutter_tts/flutter_tts.dart';
class TTSSpeak{
  late FlutterTts flutterTts= FlutterTts();
  static final TTSSpeak _instance = TTSSpeak._internal();

  factory TTSSpeak() {

    return _instance;
  }

  TTSSpeak._internal();
  double volume = 0.5, _pitch = 1.0, rate = 0.5;
  String _currentLang = 'ko-KR';
  void ttsSpeakAction(String text,Function onCompleted){
    flutterTts.setLanguage(_currentLang);
    flutterTts.setVolume(getVolume());
    flutterTts.setPitch(_pitch);
    flutterTts.setSpeechRate(getRate());
    flutterTts.speak(text);
    print(getVolume());
    print(getRate());
  }
  void setVolume(double volume){
    this.volume = volume;
  }
  void setRate(double rate){
    this.rate = rate;
  }
  double getVolume(){
    return volume;
  }
  double getRate(){
    return rate;
  }
}