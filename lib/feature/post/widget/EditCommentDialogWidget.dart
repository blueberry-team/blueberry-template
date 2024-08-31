import 'package:flutter/material.dart';

import '../../../utils/AppStrings.dart';

class EditCommentDialogWidget extends StatelessWidget {
  final String commentID;
  final String postID;
  final TextEditingController editController;
  final void Function(String commentID, String newContent) onEdit;

  const EditCommentDialogWidget({
    super.key,
    required this.commentID,
    required this.postID,
    required this.editController,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.editCommentTitle),
      content: TextField(
        controller: editController,
        decoration: const InputDecoration(hintText: AppStrings.editCommentHint),
      ),
      actions: [
        TextButton(
          child: const Text(AppStrings.editCommentCancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(AppStrings.editCommentConfirm),
          onPressed: () {
            onEdit(commentID, editController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
