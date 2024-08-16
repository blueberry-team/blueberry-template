import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/FriendModel.dart';
import '../provider/FriendsListProvider.dart';
import 'FriendBottomSheet.dart';
import 'FriendListItemWidget.dart';

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
              final friendListImageUrl = ref.watch(friendsListImageProvider(friend.imageName));

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
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) {
                  return const Center(child: Text('Error loading image'));
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

class FriendBottomSheetLauncher {
  static void show({
    required BuildContext context,
    required FriendModel friend,
    required String imageUrl,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => FriendBottomSheetWidget(
        friend: friend,
        imageUrl: imageUrl,
      ),
    );
  }
}
