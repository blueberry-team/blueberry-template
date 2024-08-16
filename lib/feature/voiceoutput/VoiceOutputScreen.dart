/*
* 구현 중입니다.
* 샘플 voiceOutput들을 각각 플레이 버튼과 함께 한 줄에 보여줍니다.
* 8월 16일 미란
* */


import './widget/VoiceOutputListWidget.dart';
import 'package:flutter/material.dart';

class VoiceOutputScreen extends StatelessWidget {
  static const String name = 'VoiceOutput';

  const VoiceOutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: VoiceOutputListWidget(),
        ),
      );
  }
}
