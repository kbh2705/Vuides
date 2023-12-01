// background_service.dart
import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void onStart() {
  final service = FlutterBackgroundService();
  final speech = stt.SpeechToText();

  service.onDataReceived.listen((event) {
    if (event?["action"] == "startListening") {
      startListening(service, speech);
    }
  });

  service.setForegroundMode(true);
}

Future<void> startListening(FlutterBackgroundService service, stt.SpeechToText speech) async {
  bool available = await speech.initialize();
  print(available);
  if (available) {
    speech.listen(onResult: (result) {
      service.sendData({"response": result.recognizedWords});
    });
  }
}
