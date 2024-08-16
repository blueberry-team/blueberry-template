import 'package:flutter/material.dart';

class VoiceOutputRow extends StatelessWidget {
  final String text;

  const VoiceOutputRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              text,
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