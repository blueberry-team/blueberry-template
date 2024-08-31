import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/FriendsListImageProvider.dart';
import '../provider/FriendsListProvider.dart';
import 'FriendBottomSheetLauncher.dart';
import 'FriendListItemWidget.dart';
import 'ShimmerSkeletonLoader.dart';

class FriendsListViewWidget extends ConsumerWidget {
  const FriendsListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendList = ref.watch(friendsListProvider);

    return friendList.when(
      data: (friends) {
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(friendsListProvider);
          },
          child: ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              final friend = friends[index];
              final friendListImageUrl =
                  ref.watch(friendsListImageProvider(friend.imageName));

              return friendListImageUrl.when(
                data: (imageUrl) {
                  return FriendListItemWidget(
                    friend: friend,
                    imageUrl: imageUrl,
                    onTap: () {
                      FriendBottomSheetLauncher.show(
                        context: context,
                        friend: friend,
                        imageUrl: imageUrl,
                      );
                    },
                  );
                },
                loading: () => const ShimmerSkeletonLoader(),
                error: (error, stack) => const Icon(Icons.error),
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
