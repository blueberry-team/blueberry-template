import 'package:flutter/material.dart';

import '../../utils/AppStrings.dart';
import 'widget/ChatListWidget.dart';
import 'widget/ChatSendWidget.dart';

class ChatScreen extends StatelessWidget {
  static const String name = 'ChatScreen';
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.lessonChatScreenTitle)),
      body: Center(
        child: Column(
          children: [
            const Expanded(child: ChatListWidget()),
            ChatSendWidget(),
          ],
        ),
      ),
    );
  }
}
