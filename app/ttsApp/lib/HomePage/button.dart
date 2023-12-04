import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:firstflutterapp/HomePage/ttsSpeak.dart';
import 'package:firstflutterapp/server/apiserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:geolocator/geolocator.dart';
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
  String _weatherDescription = '';
  @override
  void initState() {
    super.initState();
    initPlatformState();
    _speech = stt.SpeechToText();
    requestPermissions();
    initializeSTT();
  }
  void requestPermissions() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // 권한이 거부되었을 때 처리
      print("Microphone permission denied");
    }
  }


  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('위치 서비스가 비활성화되어 있습니다.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('위치 권한이 거부되었습니다.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('위치 권한이 영구적으로 거부되었습니다.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await getCurrentLocation();
      fetchWeather(position.latitude, position.longitude);
    } catch (e) {
      // 에러 처리
      print('위치 정보를 가져오는데 실패했습니다: $e');
    }
  }
  String translateStatusToKorean(String status) {
    // 날씨 상태에 대한 한글 번역
    Map<String, String> translationDict = {
      "Clear": "푸른 하늘과 함께하는 맑은 날씨입니다. 소풍을 가보는건 어떠실까요?",
      "Clouds": "구름이 많고 우중충한 날씨입니다. 비가 올지도 모르겠네요.",
      "Rain": "하늘에서 비가 내립니다. 외출시 우산을 꼭 챙기세요.",
      "Snow": "소복소복 눈이 옵니다. 길이 미끄러울 수 있으니 주의하세요!",
      "Thunderstorm": "우르릉 쾅쾅! 천둥 번개가 치니 집에 있는게 좋겠어요.",
      "Drizzle": "이슬비가 내립니다. 송글송글 맺히는 물방울이 예쁘네요.",
      "Mist": "안개가 끼는 날씨이니 주위를 잘 살피세요.",
      "Fog": "안개가 자욱하게 끼는 날씨입니다. 이동시 시야를 확실하게 확보하세요.",
      "Haze": "아지랑이가 생기는 날씨입니다.",
      "Smoke": "연기가 나는데요, 주변에 불이 났다면 119로 신고하세요!",
      "Dust": "먼지가 많은 날씨입니다. 외출시 마스크는 필수!",
      "Sand": "중국발 황사가 발발하였습니다. 집에 있는게 좋을지도 모르겠네요.",
      "Ash": "화산이 분화하고 화산재가 내립니다.",
      "Squall": "세찬 바람이 불어오는 날씨네요. 돌풍에 휩쓸리지 않게 주의하세요.",
      "Tornado": "토네이도가 옵니다. 예상경로에서 대피하세요!",
    };

    return translationDict[status] ?? status;
  }

  // 현재 위치를 기반으로 날씨 정보를 가져오는 함수
  Future<void> fetchWeather(double latitude, double longitude) async {
    final requestUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=d2750586c4ebe763aac192ed3c2e4578';

    try {
      final response = await http.get(Uri.parse(requestUrl));
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          // 'main' 객체 내의 'description' 값을 저장합니다.
          _weatherDescription =translateStatusToKorean(data['weather'][0]['main']);
        });
      } else {
        print('Failed to load weather data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void initializeSTT() async {
    bool available = await _speech.initialize(
      onError: (error) => print('STT Error: $error'),
      onStatus: (status) {
        print('STT Status: $status');
        if (status == "done") {
          Future.delayed(Duration(seconds: 2), (){
            _startListening(); // STT가 중지되면 다시 시작
          });
        }
      },
    );
    if (!available) {
      // STT 사용 불가능 상태 처리
      print("The user has denied the use of speech recognition.");
    }
  }


  void _startListening() {
    if (!_speech.isListening) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) async { // async 추가
          setState(() {
            _text = val.recognizedWords;
          });
          print('Recognized Words: $_text');
          if (_text.toLowerCase().contains("브이즈")) {
            await handleVoiceActivation(_text); // await 추가
          } else if (_text.toLowerCase().contains("날씨")) {
            await handleVoiceActivation(_text);
          } else if (_text.toLowerCase().contains("시간")) {
            await handleVoiceActivation(_text);
          } else if (_text.toLowerCase().contains("주차장")) {
            await handleVoiceActivation(_text);
          }
          else if (_text.toLowerCase().contains("카카오톡")) {
            await handleVoiceActivation(_text);
          }
          else if (_text.toLowerCase().contains("운전")) {
            await handleVoiceActivation(_text);
          }
        },// 나머지 조건문 생략...
        listenFor: Duration(seconds: 30),
      );
    }
  }



  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  Future<void> handleVoiceActivation(String text) async {
    print('브이즈가 호출되었습니다!');
    try {
      // getResponse 함수가 비동기 함수이므로 await를 사용하여 결과를 기다립니다.
      String response = await getResponse(text);
      tts.ttsSpeakAction(response, () {
        // TTS가 말하기를 완료한 후 실행될 코드
        _startListening();
      });
    } catch (e) {
      print('handleVoiceActivation에서 오류 발생: $e');
    }
  }

  Future<String> findClosestParking() async {
    Position position = await getCurrentLocation(); // 현재 위치 가져오기
    try {
      final response = await http.get(
        Uri.parse(apiserver + '/find_closest_parking?current_lat=${position.latitude}&current_log=${position.longitude}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print("가까운 주차장 : ${responseData['closest_lat']} |  ${responseData['closest_log']}");
        print("내위치 : ${position.latitude} |  ${position.longitude}");
        return responseData['message'];
        // 새로운 마커 생성
      } else {
        throw Exception('Failed to load closest parking');
      }
    } catch (e) {
      return "가까운 주차장이 없습니다.";
    }
  }
  Future<String> getResponse(String inputText) async {
    if (inputText.toLowerCase().contains("브이즈")) {
      return "브이즈가 무엇을 도와드릴까요?";
    } else if (inputText.toLowerCase().contains("날씨")) {
      await fetchWeather(35.146485, 126.922357); // await를 사용해 결과를 기다립니다.

      return '현재 날씨는 ${_weatherDescription}'; // 날씨 설명을 반환합니다.
    } else if (inputText.toLowerCase().contains("시간")) {
      return "현재 시간은 ${DateTime.now().toString()}입니다."; // 현재 시간을 반환합니다.
    } else if (inputText.toLowerCase().contains("주차장")) {
      String parkingInfo = await findClosestParking(); // await를 사용해 결과를 기다립니다.
      return parkingInfo; // 가까운 주차장 정보를 반환합니다.
    }else if (inputText.toLowerCase().contains("카카오톡")) {
      return "보낼사람과 전송할 메시지 내용을 말씀해주세요."; // 현재 시간을 반환합니다.
    }else if (inputText.toLowerCase().contains("운전")) {
      return "날씨, 시간, 주차장, 카카오톡 전송 중 필요한 기능을 말씀해주세요."; // 현재 시간을 반환합니다.
    }
    return "죄송합니다. 질문을 듣지 못했어요. 다시 말씀해 주세요.";
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


    if(event.packageName!.contains("kakao")){
      // Ensure event.text is not null and has the required length00
      if(event.text != null && event.text!.length >= 100) {
        // Assuming event.title is not null, or providing a default value
        text = await contextSummary(
            event.title ?? "default", event.text ?? "default");
      }else{
        text = "카카오톡의 알림입니다. ${event.title}님에게 ${event.text}라고 메시지가 도착했습니다.";
      }
    }
    print("요약 문장 : ${text}");
    tts.ttsSpeakAction(text!, () {
      startListening();
    });
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