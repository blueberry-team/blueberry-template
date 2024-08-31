import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/CommentProvider.dart';
import 'CommentItemWidget.dart';

class CommentBottomSheet extends ConsumerWidget {
  final String postID;

  const CommentBottomSheet({super.key, required this.postID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentList = ref.watch(commentProvider(postID));
    final commentNotifier = ref.read(commentNotifierProvider(postID));
    final TextEditingController commentController = TextEditingController();
    const userID = 'eztqDqrvEXDc8nqnnrB8'; // 임시 사용자 ID

    return FractionallySizedBox(
      heightFactor: 0.5, // 모달의 높이를 화면 절반으로 설정
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          children: [
            // 댓글 리스트
            Expanded(
              child: commentList.when(
                data: (comments) {
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return CommentItem(comment: comment);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text('Error: $error')),
              ),
            ),
            // 댓글 입력 필드
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: '댓글 추가...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      final content = commentController.text.trim();
                      if (content.isNotEmpty) {
                        await commentNotifier.addComment(content, userID);
                        commentController.clear();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCommentBottomSheet(BuildContext context, String postID) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return CommentBottomSheet(postID: postID);
    },
  );
}
