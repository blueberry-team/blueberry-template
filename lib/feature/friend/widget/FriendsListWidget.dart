import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/FriendsListProvider.dart';
import 'FriendBottomSheet.dart';
import 'FriendListItemWidget.dart';

class FriendsListWidget extends ConsumerWidget {
  const FriendsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendList = ref.watch(friendsListProvider);

    return friendList.when(
      data: (friends) {
        return RefreshIndicator(
          onRefresh: () async {
            ref.refresh(friendsListProvider);
          },
          child: ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              final friend = friends[index];
              // final imageUrl = ref.watch(imageProvider(friend.imageName));
              final friendListImageUrl = ref
                  .watch(imageProvider('friends-profile/${friend.imageName}'));

              return friendListImageUrl.when(
                data: (imageUrl) {
                  return FriendListItemWidget(
                    friend: friend,
                    imageUrl: imageUrl,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (context) => FriendBottomSheet(
                          friend: friend,
                          imageUrl: imageUrl,
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) {
                  return const ListTile(
                    title: Text('Error loading image'),
                  );
                },
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
