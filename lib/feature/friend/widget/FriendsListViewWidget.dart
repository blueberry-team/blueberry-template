import 'package:blueberry_flutter_template/feature/friend/widget/FriendBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/FriendsListProvider.dart';
import 'FriendListItemWidget.dart';

class FriendsListViewWidget extends ConsumerWidget {
  const FriendsListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendList = ref.watch(friendsListProvider);

    return friendList.when(
      data: (friends) {
        // 친구 목록이 로드되었을 때 로그 출력
        print('친구 목록이 로드되었습니다: ${friends.length}명의 친구가 있습니다.');
        for (var friend in friends) {
          print('친구 이름: ${friend.name}, ID: ${friend.friendId}, 이미지 이름: ${friend.imageName}');
        }

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
                  // 이미지 URL이 로드되었을 때 로그 출력
                  print('이미지 URL 로드됨: $imageUrl');
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
                        builder: (context) => FriendBottomSheetWidget(
                          friend: friend,
                          imageUrl: imageUrl,
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) {
                  // 이미지 로드 중 에러가 발생했을 때 로그 출력
                  print('이미지 로드 오류: $error');
                  return const Center(child: Text('Error loading image'));
                },
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        // 친구 목록 로드 중 에러가 발생했을 때 로그 출력
        print('친구 목록 로드 오류: $error');
        return Center(child: Text('Error: $error'));
      },
    );
  }
}
