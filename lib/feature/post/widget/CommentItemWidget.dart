import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../model/CommentModel.dart';
import '../provider/UserInfoProvider.dart';

class CommentItem extends ConsumerWidget {
  final CommentModel comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postUserInfo = ref.watch(postUserInfoProvider(comment.userID));

    return postUserInfo.when(
      data: (userInfo) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(userInfo.profileImageUrl),
          ),
          title: Text(userInfo.name),
          subtitle: Text(comment.content),
          trailing: Text(DateFormat.yMMMd().format(comment.createdAt)),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Icon(Icons.error),
    );
  }
}