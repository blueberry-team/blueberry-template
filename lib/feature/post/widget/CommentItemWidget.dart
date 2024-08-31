import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../model/CommentModel.dart';
import '../provider/UserInfoProvider.dart';
import 'DeleteConfirmationDialog.dart';
import 'EditCommentDialog.dart';

class CommentItemWidget extends ConsumerWidget {
  final CommentModel comment;

  const CommentItemWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postUserInfo = ref.watch(postUserInfoProvider(comment.userID));
    final TextEditingController editController = TextEditingController(text: comment.content);

    return postUserInfo.when(
      data: (userInfo) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userInfo.profileImageUrl),
                radius: 20,
              ),
              const SizedBox(width: 12),
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
                        const SizedBox(width: 8),
                        Text(
                          DateFormat.yMMMd().format(comment.createdAt),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == 'edit') {
                              showDialog(
                                context: context,
                                builder: (context) => EditCommentDialog(
                                  commentID: comment.commentID,
                                  postID: comment.postID,
                                  ref: ref,
                                  editController: editController,
                                ),
                              );
                            } else if (value == 'delete') {
                              showDialog(
                                context: context,
                                builder: (context) => DeleteConfirmationDialog(
                                  commentID: comment.commentID,
                                  postID: comment.postID,
                                  ref: ref,
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('수정'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('삭제'),
                            ),
                          ],
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
