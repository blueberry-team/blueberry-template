import './widget/VoiceOutputWidget.dart';
import 'package:flutter/material.dart';

class VoiceOutputScreen extends StatelessWidget {
  static const String name = 'VoiceOutput';

  const VoiceOutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: VoiceOutputWidget()),
          ],
        ),
      ),
    );
  }
}
