import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:firstflutterapp/HomePage/ttsSpeak.dart';
import 'package:firstflutterapp/server/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../BottomNavi/bottomnavi.dart';


Widget buildActionButtons() {
  return const ButtonWidget();
}

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  TTSSpeak tts = TTSSpeak();
  final List<NotificationEvent> _log = [];
  bool started = false;
  bool _loading = false;
  bool _isListening = false;
  bool sttStarted = false;
  late stt.SpeechToText _speech;
  String _text = '운전만해를 이용해주셔서 감사합니다.';
  ReceivePort port = ReceivePort();

  @override
  void initState() {
    _speech = stt.SpeechToText();
  }
  void _startListening() {
    setState(() => _isListening = true);
    _speech.listen(
      onResult: (val) {
        setState(() {
          _text = val.recognizedWords;
        });
        if (_text.toLowerCase().contains("브이즈")) {
          handleVoiceActivation(_text);
        }
      },
    );
  }


  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  Future<void> handleVoiceActivation(String text) async {
    print('브이즈가 호출되었습니다!');
    _stopListening(); // 음성 인식 중지
    String response = getResponse(text); // 사용자의 요청에 따른 응답을 가져옵니다.
    tts.ttsSpeakAction(response, () {
      _startListening(); // 음성 인식 다시 시작
    });
  }
  String getResponse(String inputText) {
    if (inputText.toLowerCase().contains("브이즈")) {
      if (inputText.toLowerCase().contains("날씨")) {
        // 날씨 정보를 가져오는 로직
        return "현재 날씨는 맑음입니다."; // 예시 응답
      } else if (inputText.toLowerCase().contains("뉴스")) {
        // 최신 뉴스를 가져오는 로직
        return "오늘의 뉴스를 알려드립니다."; // 예시 응답
      } else {
        return "브이즈에게 무엇을 도와드릴까요?";
      }
    }
    return "죄송합니다. 질문을 듣지 못했어요.";
  }



  Future<void> sendTextToServer(String text) async {
    try {
      var url = Uri.parse(apiserver + '/process_text'); // 서버 엔드포인트 URL
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'text': text}), // 'text'는 서버가 기대하는 필드 이름
      );

      if (response.statusCode == 200) {
        print('텍스트가 성공적으로 전송되었습니다.');
        if(!text.isEmpty){
          tts.ttsSpeakAction(getResponse(text) ,() {
            _startListening();
          });
        }

      } else {
        print('서버 오류: ${response.statusCode}');
      }
    } catch (e) {
      print('텍스트 전송 중 오류 발생: $e');
    }
  }



  final String apiserver = ApiServer().getApiServer();

  // we must use static method, to handle in background
  @pragma(
      'vm:entry-point') // prevent dart from stripping out this function on release build in Flutter 3.x
  static void _callback(NotificationEvent evt) {
    print("send evt to ui: $evt");
    final SendPort? send = IsolateNameServer.lookupPortByName("_listener_");
    if (send == null) print("can't find the sender");
    send?.send(evt);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    NotificationsListener.initialize(callbackHandle: _callback);

    // this can fix restart<debug> can't handle error
    IsolateNameServer.removePortNameMapping("_listener_");
    IsolateNameServer.registerPortWithName(port.sendPort, "_listener_");
    port.listen((message) => onData(message));

    // don't use the default receivePort
    // NotificationsListener.receivePort.listen((evt) => onData(evt));

    var isRunning = (await NotificationsListener.isRunning) ?? false;
    print("""Service is ${!isRunning ? "not " : ""}already running""");

    setState(() {
      started = isRunning;
    });
  }
  Future contextSummary(String username, String text) async {
    // 서버 엔드포인트 URL을 설정합니다.
    String tts = "/tts";
    String ttsUrl = apiserver + tts;

    // 로그인 데이터를 준비합니다.
    Map<String, String> data = {
      'userName': username,
      'kko_msg': text,
    };

    // 서버에 POST 요청을 보냅니다.
    final response = await http.post(
      Uri.parse(ttsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData['message'];
    } else {
      // 오류 처리
      return "Error: ${response.statusCode}";
    }
  }

  Future<void> onData(NotificationEvent event) async {
    // setState(() {
    // _log.add(event);
    // });
    _log.add(event);
    print(event.toString());
    print('debugOption title ${event.title}');
    print('debugOption text  ${event.text}');
    String? text = event.text;
    print("요약 문장 : ${text}");

    if(event.packageName?.contains("instagram") ?? false){
      // Ensure event.text is not null and has the required length
      if(event.text != null && event.text!.length >= 100) {
        // Assuming event.title is not null, or providing a default value
        text = await contextSummary(
            event.title ?? "default", event.text ?? "default");
      }
    }
    tts.ttsSpeakAction(text!, () {
      _startListening();
    });
    //   }
    // }
  }
  
  //TODO : TTS
  void startListening() async {
    print("start listening");
    setState(() {
      _loading = true;
    });
    var hasPermission = (await NotificationsListener.hasPermission) ?? false;
    if (!hasPermission) {
      print("no permission, so open settings");
      NotificationsListener.openPermissionSettings();
      return;
    }

    var isRunning = (await NotificationsListener.isRunning) ?? false;

    if (!isRunning) {
      await NotificationsListener.startService(
          foreground: false,
          title: "Listener Running",
          description: "Welcome to having me");
    }

    setState(() {
      started = true;
      _loading = false;
    });
  }

  void stopListening() async {
    print("stop listening");

    setState(() {
      _loading = true;
    });

    await NotificationsListener.stopService();

    setState(() {
      started = false;
      _loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed:
            // TODO: 여기에 '카카오톡 음성서비스 연결' 버튼이 눌렸을 때 실행할 코드를 추가하세요.
            started ? stopListening : startListening,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50) // full width
            ),
            child: _loading
                ? const Text('알림 리스너 시작 중')
                : (started ? const Text('알림 리스너 중지') : const Text('알림 리스너 시작')),
          ),
          const SizedBox(height: 8), // 버튼 사이의 간격을 주기 위해 사용
          ElevatedButton(
            onPressed: () {
              // TODO: 여기에 '내 연락처에서 개별 설정하기' 버튼이 눌렸을 때 실행할 코드를 추가하세요.
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Bottomnavi(
                        initialIndex: 0,
                      )));
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xff473E7C),
                side: const BorderSide(color: Color(0xff473E7C)),
                minimumSize: const Size(double.infinity, 50) // full width
            ),
            child: const Text('내 연락처에서 개별 설정하기'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _isListening ? _stopListening : _startListening,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50) // full width
            ),
            child: Text(_isListening ? '브이즈 중지' : '브이즈 시작'),
          )

        ],
      ),
    );
  }
}
