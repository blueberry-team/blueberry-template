import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/VoiceOutputProvider.dart';
import './VoiceOutputItemWidget.dart';

class VoiceOutputListWidget extends ConsumerWidget {
  const VoiceOutputListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceOutputList = ref.watch(voiceOutputProvider);

    return voiceOutputList.when(
      data: (voiceOutputs) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: voiceOutputs.length,
                itemBuilder: (context, index) {
                  return VoiceOutputItemWidget(voiceOutput: voiceOutputs[index]);
                }),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
    );
  }
}
