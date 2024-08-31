import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/CommentProvider.dart';
import 'CommentItemWidget.dart';

class CommentBottomSheetWidget extends ConsumerWidget {
  final String postID;

  const CommentBottomSheetWidget({super.key, required this.postID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentList = ref.watch(commentProvider(postID));
    final commentNotifier = ref.read(commentNotifierProvider(postID));
    final TextEditingController commentController = TextEditingController();
    const userID = 'eztqDqrvEXDc8nqnnrB8'; // 임시 사용자 ID

    return FractionallySizedBox(
      heightFactor: 0.75, // 모달의 높이를 75%로 설정
      child: Padding(
        padding: const EdgeInsets.all(16.0), // 패딩 추가
        child: Column(
          children: [
            // '댓글' 제목
            const Text(
              '댓글',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8), // 제목과 댓글 리스트 사이 간격
            // 댓글 리스트
            Expanded(
              child: commentList.when(
                data: (comments) {
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return CommentItemWidget(comment: comment);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text('Error: $error')),
              ),
            ),
            const SizedBox(height: 8), // 댓글 리스트와 입력 필드 사이 간격
            // 댓글 입력 필드
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // 입력 필드의 좌우 패딩
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
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
      return CommentBottomSheetWidget(postID: postID);
    },
  );
}
