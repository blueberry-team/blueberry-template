import 'package:blueberry_flutter_template/feature/post/provider/LikeProvider.dart';
import 'package:blueberry_flutter_template/feature/post/provider/DislikeProvider.dart';
import 'package:blueberry_flutter_template/feature/post/provider/PostProvider.dart';
import 'package:blueberry_flutter_template/feature/post/widget/PostListViewItemWidget.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/UserInfoProvider.dart';

class PostListViewWidget extends ConsumerWidget {
  const PostListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(postProvider);
    final likeState = ref.watch(likeProvider);
    final dislikeState = ref.watch(dislikeProvider);
    const userID = 'eztqDqrvEXDc8nqnnrB8'; // 임시로 사용자 ID를 지정

    return SafeArea(
      child: postList.when(
        data: (posts) {
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final isLiked = likeState[post.postID] ?? false;
              final isDisliked = dislikeState[post.postID] ?? false;

              final postUserInfo = ref.watch(postUserInfoProvider(post.userID));

              return postUserInfo.when(
                data: (userInfo) {
                  return PostListViewItemWidget(
                    post: post,
                    isLiked: isLiked,
                    isDisliked: isDisliked,
                    userInfo: userInfo,
                    onLikeToggle: () {
                      if (isDisliked) {
                        ref.read(dislikeProvider.notifier).toggleDislike(post.postID, userID); // Dislike 해제
                      }
                      ref.read(likeProvider.notifier).toggleLike(post.postID, userID); // Like 토글
                    },
                    onDislikeToggle: () {
                      if (isLiked) {
                        ref.read(likeProvider.notifier).toggleLike(post.postID, userID); // Like 해제
                      }
                      ref.read(dislikeProvider.notifier).toggleDislike(post.postID, userID); // Dislike 토글
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) {
                  talker.error('Error loading user info: $error');
                  return Center(child: Text('Error: $error'));
                },
              );
            },
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          talker.error('Error loading posts: $error');
          return Center(child: Text('Error: $error'));
        },
      ),
    );
  }
}
