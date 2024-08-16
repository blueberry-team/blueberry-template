import 'package:flutter/material.dart';

class VoiceOutputRowWidget extends StatelessWidget {
  final String voiceOutput;

  const VoiceOutputRowWidget({super.key, required this.voiceOutput});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              voiceOutput,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text("button"),
          ),
        ],
      ),
    );
  }
}