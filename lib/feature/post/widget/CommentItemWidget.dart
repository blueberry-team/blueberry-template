import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../model/CommentModel.dart';
import '../provider/UserInfoProvider.dart';

class CommentItemWidget extends ConsumerWidget {
  final CommentModel comment;

  const CommentItemWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postUserInfo = ref.watch(postUserInfoProvider(comment.userID));

    return postUserInfo.when(
      data: (userInfo) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userInfo.profileImageUrl),
                radius: 20, // 아바타 크기 설정
              ),
              const SizedBox(width: 12), // 아바타와 텍스트 사이의 간격
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          userInfo.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8), // 이름과 시간 사이의 간격
                        Text(
                          DateFormat.yMMMd().format(comment.createdAt),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(comment.content),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.thumb_up_alt_outlined, size: 20),
                          onPressed: () {
                            // 좋아요 버튼 기능
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.thumb_down_alt_outlined, size: 20),
                          onPressed: () {
                            // 싫어요 버튼 기능
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.comment_outlined, size: 20),
                          onPressed: () {
                            // 댓글 버튼 기능
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Icon(Icons.error),
    );
  }
}
