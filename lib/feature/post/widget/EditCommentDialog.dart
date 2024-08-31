import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/CommentProvider.dart';

class EditCommentDialog extends StatelessWidget {
  final String commentID;
  final String postID;
  final WidgetRef ref;
  final TextEditingController editController;

  const EditCommentDialog({
    super.key,
    required this.commentID,
    required this.postID,
    required this.ref,
    required this.editController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('댓글 수정'),
      content: TextField(
        controller: editController,
        decoration: const InputDecoration(
          hintText: '댓글 수정...',
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('취소'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('저장'),
          onPressed: () async {
            final newContent = editController.text.trim();
            if (newContent.isNotEmpty) {
              await ref.read(commentNotifierProvider(postID)).updateComment(commentID, newContent);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
