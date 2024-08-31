import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/CommentModel.dart';
import 'DeleteConfirmationDialogWidget.dart';
import 'EditCommentDialogWidget.dart';

class CommentItemWidget extends StatelessWidget {
  final CommentModel comment;
  final String userName;
  final String userProfileImageUrl;
  final String postID;
  final void Function(String commentID) onDelete;
  final void Function(String commentID, String newContent) onEdit;

  const CommentItemWidget({
    super.key,
    required this.comment,
    required this.userName,
    required this.userProfileImageUrl,
    required this.postID,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController editController = TextEditingController(text: comment.content);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userProfileImageUrl),
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
                      userName,
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
                            builder: (context) => EditCommentDialogWidget(
                              commentID: comment.commentID,
                              postID: postID,
                              editController: editController,
                              onEdit: onEdit, // onEdit 콜백 전달
                            ),
                          );
                        } else if (value == 'delete') {
                          showDialog(
                            context: context,
                            builder: (context) => DeleteConfirmationDialogWidget(
                              commentID: comment.commentID,
                              onDelete: onDelete, // onDelete 콜백 전달
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
                    )
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
  }
}
