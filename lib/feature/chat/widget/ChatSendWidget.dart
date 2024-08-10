import 'package:blueberry_flutter_template/feature/chat/provider/ChatListProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/FirebaseService.dart';

class ChatSendWidget extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  ChatSendWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseService = FirebaseService();
    final roomId = ref.watch(roomIdProvider);

    void sendChatMessage(String value) async {
      await firebaseService.addChatMessage(roomId, value);
      _controller.clear();
    }

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    hintText: 'Enter message', border: OutlineInputBorder()),
                onSubmitted: (value) async {
                  // 엔터키가 눌러졌을때 하는 행동
                  value.isEmpty ? null : sendChatMessage(value);
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () async {
                // 눌러졌을때 행동
                _controller.text.isEmpty
                    ? null
                    : sendChatMessage(_controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
