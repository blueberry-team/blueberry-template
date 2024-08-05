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
        return ListView.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final friend = friends[index];
            final imageUrl = ref.watch(imageProvider(friend.imageName));
            return imageUrl.when(
              data: (imageUrl) {
                print('프렌즈리스트위젯 ${friend.name}: $imageUrl'); // 로깅 추가
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
                print('Error loading image: $error');
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
