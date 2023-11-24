import 'dart:isolate';
import 'dart:ui';

import 'package:firstflutterapp/HomePage/ttsSpeak.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';

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

  ReceivePort port = ReceivePort();

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

  void onData(NotificationEvent event) {
    // setState(() {
    // _log.add(event);
    // });
    _log.add(event);
    print(event.toString());
    print('debugOption title ${event.title}');
    print('debugOption text  ${event.text}');

    if(event.packageName?.contains("instagram") ?? false){
      tts.ttsSpeakAction((event.text).toString());
    }



  }

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
  void initState() {
    initPlatformState();
    super.initState();
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
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xff473E7C),
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Color(0xff473E7C)),
                minimumSize: const Size(double.infinity, 50) // full width
            ),
            child: const Text('내 연락처에서 개별 설정하기'),
          ),
        ],
      ),
    );
  }
}
