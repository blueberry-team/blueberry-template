import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:blueberry_flutter_template/widgets/chat/ChatRoomWidget.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.chatRoomScreenTitle)),
      body: Center(
        child: ChatRoomWidget(),
      ),
    );
  }
}
