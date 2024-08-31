import 'package:flutter/material.dart';

import '../../../utils/AppStrings.dart';

class DeleteConfirmationDialogWidget extends StatelessWidget {
  final String commentID;
  final void Function(String commentID) onDelete;

  const DeleteConfirmationDialogWidget({
    super.key,
    required this.commentID,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.deleteCommentTitle),
      content: const Text(AppStrings.deleteCommentConfirmation),
      actions: [
        TextButton(
          child: const Text(AppStrings.deleteCommentCancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(AppStrings.deleteCommentConfirm),
          onPressed: () {
            onDelete(commentID);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
