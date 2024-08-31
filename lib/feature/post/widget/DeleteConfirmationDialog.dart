import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/CommentProvider.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String commentID;
  final String postID;
  final WidgetRef ref;

  const DeleteConfirmationDialog({
    super.key,
    required this.commentID,
    required this.postID,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('댓글 삭제'),
      content: const Text('이 댓글을 삭제하시겠습니까?'),
      actions: <Widget>[
        TextButton(
          child: const Text('취소'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('삭제'),
          onPressed: () async {
            await ref.read(commentNotifierProvider(postID)).deleteComment(commentID);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
