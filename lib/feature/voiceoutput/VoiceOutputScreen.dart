import './widget/VoiceOutputListWidget.dart';
import 'package:flutter/material.dart';

class VoiceOutputScreen extends StatelessWidget {
  static const String name = 'VoiceOutput';

  const VoiceOutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: VoiceOutputListWidget()),
          ],
        ),
      ),
    );
  }
}
