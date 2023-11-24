import 'package:firstflutterapp/HomePage/ttsSpeak.dart';
import 'package:flutter/material.dart';

import '../BottomNavi/bottomnavi.dart';


class TtsSetting extends StatefulWidget {
  @override
  _TtsSettingState createState() => _TtsSettingState();
}

class _TtsSettingState extends State<TtsSetting> {
  late TTSSpeak ttsSpeak;
  double volume=5.0;
  double rate = 1.0;


  @override
  void initState() {
    super.initState();
    ttsSpeak = TTSSpeak();
    volume = ttsSpeak.getVolume();
    rate = ttsSpeak.getRate();
  }

  Future _speak() async {
    print("TTS: Speak function called");
    ttsSpeak.setRate(rate);
    ttsSpeak.setVolume(volume);
    ttsSpeak.ttsSpeakAction("안녕하세요. 운전만해입니다.");
    print("현재 속도 ${ttsSpeak.getRate()}");
    print("현재 음량 ${ttsSpeak.getVolume()}");
  }

  void _onVolumeChanged(double newVolume) {
    setState(() {
      volume = newVolume;


    });
  }

  void _onRateChanged(double newRate) {
    setState(() {
      rate = newRate;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('TTS 설정'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TTS 설정이란?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '음성을 읽어주는 기능으로 해당 설정에서 음성의 목소리 크기와 읽어주는 속도를 설정할 수 있습니다.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                '미리듣기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                '예시문장) 안녕하세요. 운전만해입니다.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              trailing: IconButton(
                icon: Icon(Icons.play_circle_fill, color: Color(0xff473E7C), size: 40),
                onPressed: _speak,
              ),
            ),
            SliderSettingSection(
              title: '음량 조절',
              description: '메시지를 읽어주는 소리 크기를 조절해요',
              minValue: 0.0,
              maxValue: 1.0,
              divisions: 10,
              activeColor: Color(0xff473E7C),
              inactiveColor: Colors.grey,
              belowSliderText: '- 기본 음량은 5입니다\n- 미리듣기로 음량을 조절해보세요',
              scaleType: 'volume',
              initialValue: ttsSpeak.getVolume(),
              onValueChanged: _onVolumeChanged,
            ),
            SliderSettingSection(
              title: '재생속도 조절',
              description: '메시지를 읽어주는 속도를 조절해요',
              minValue: 0.0,
              maxValue: 1.0,
              divisions: 10,
              activeColor: Color(0xff473E7C),
              inactiveColor: Colors.grey,
              belowSliderText: '- 기본 재생속도는 1배속입니다\n- 0.25와 가까울수록 속도가 느려집니다',
              scaleType: 'speed',
              initialValue: ttsSpeak.getRate(),
              onValueChanged: _onRateChanged,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement save settings functionality
                  ttsSpeak.setRate(rate);
                  ttsSpeak.setVolume(volume);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Bottomnavi(
                          initialIndex: 4,
                        )),
                  );
                },
                child: Text('확인'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff473E7C), // background (button) color
                  onPrimary: Colors.white, // foreground (text) color
                  minimumSize: Size(double.infinity, 36),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliderSettingSection extends StatefulWidget {
  final String title;
  final String description;
  final double minValue;
  final double maxValue;
  final int divisions;
  final Color activeColor;
  final Color inactiveColor;
  final String belowSliderText;
  final String scaleType;
  final Function(double) onValueChanged;

  final double initialValue;

  SliderSettingSection({
    required this.title,
    required this.description,
    required this.minValue,
    required this.maxValue,
    required this.divisions,
    required this.activeColor,
    required this.inactiveColor,
    required this.belowSliderText,
    required this.scaleType,
    required this.onValueChanged,
    required this.initialValue,
  });

  @override
  _SliderSettingSectionState createState() => _SliderSettingSectionState();
}

class _SliderSettingSectionState extends State<SliderSettingSection> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Slider(
          value: _currentValue,
          min: widget.minValue,
          max: widget.maxValue,
          divisions: widget.divisions,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          label: '${( _currentValue * 10).toStringAsFixed(0)}',
          onChanged: (value) {
            setState(() {
              _currentValue = value;
              widget.onValueChanged(value);
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildSliderScale(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.belowSliderText,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliderScale() {
    List<Widget> scaleWidgets = [];

    if (widget.scaleType == 'volume') {
      for (int i = 0; i <= widget.divisions; i++) {
        scaleWidgets.add(Text((widget.minValue + (widget.maxValue - widget.minValue) / widget.divisions * i * 10).toStringAsFixed(0)));
      }
    } else if (widget.scaleType == 'speed') {
      scaleWidgets = [0.25, 1, 2].map((value) => Text(value.toStringAsFixed(2))).toList();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: scaleWidgets,
    );
  }
}