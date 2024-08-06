import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/FriendsListProvider.dart';
import 'FriendListItemWidget.dart';

class FriendsListWidget extends ConsumerWidget {
  const FriendsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendList = ref.watch(friendsListProvider);

    return friendList.when(
      data: (friends) {
        return ListView.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            return FriendListItemWidget(friend: friends[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
