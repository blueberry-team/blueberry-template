import 'package:blueberry_flutter_template/feature/chat/widget/ChatRoomWidget.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';

import '../../services/FirebaseService.dart';

class ChatRoomScreen extends StatelessWidget {
  static const String name = 'ChatRoomScreen';
  const ChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.chatRoomScreenTitle)),
      body: const Center(
        child: ChatRoomWidget(),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}

FloatingActionButton _buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      FirebaseService().createChatRoom("test room");
    },
    backgroundColor: Colors.blue,
    child: const Icon(Icons.add),
  );
}
