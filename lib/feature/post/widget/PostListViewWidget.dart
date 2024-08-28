import 'package:blueberry_flutter_template/feature/post/provider/PostProvider.dart';
import 'package:blueberry_flutter_template/feature/post/widget/PostListViewItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListViewWidget extends ConsumerWidget {
  const PostListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(postListInfoProvider);

    return SafeArea(
      child: postList.when(
        data: (posts) => ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return PostListViewItemWidget(
              createdAt: post.createdAt,
              content: post.content,
              imageUrl: post.imageUrl,
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}