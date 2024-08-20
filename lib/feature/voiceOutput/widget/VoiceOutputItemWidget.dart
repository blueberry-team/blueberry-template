import 'package:flutter/material.dart';

class VoiceOutputItemWidget extends StatelessWidget {
  final String voiceOutput;

  const VoiceOutputItemWidget({super.key, required this.voiceOutput});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
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
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Icon(Icons.play_arrow_rounded),
          ),
        ],
      ),
    );
  }
}
