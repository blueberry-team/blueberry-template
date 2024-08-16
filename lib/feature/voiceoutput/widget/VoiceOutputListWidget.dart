import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/VoiceOutputProvider.dart';

class VoiceOutputListWidget extends ConsumerWidget {
  const VoiceOutputListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(voiceOutputProvider);
    return list.when(
      data: (data) {
        return _buildListView(data);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
    );
  }

  Widget _buildListView(List<String> data) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: data
            .map((text) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: VoiceOutputRow(text: text),
        ))
            .toList(),
      ),
    );
  }
}

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


