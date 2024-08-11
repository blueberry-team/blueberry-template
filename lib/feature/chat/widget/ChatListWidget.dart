import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/ChatMessageModel.dart';
import '../../../services/FirebaseAuthServiceProvider.dart';
import '../../../utils/AppColors.dart';
import '../../../utils/AppTextStyle.dart';
import '../provider/ChatListProvider.dart';

class ChatListWidget extends ConsumerWidget {
  const ChatListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomId = ref.watch(roomIdProvider);
    final list = ref.watch(chatMessageListProvider(roomId));
    User? loggedInUser = ref.read(firebaseAuthServiceProvider).getCurrentUser();

    return list.when(
        data: (messages) => _buildListView(messages, loggedInUser),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')));
  }
}

Widget _buildListView(List<ChatMessageModel> messages, User? loggedInUser) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: messages.length,
    itemBuilder: (context, index) {
      bool isMe = messages[index].senderId == loggedInUser!.uid;
      return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: isMe ? grey : limeGreen,
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
            ),
            child: Text(
              messages[index].message,
              style: black16TextStyle,
            ),
          ),
        ],
      );
    },
  );
}
