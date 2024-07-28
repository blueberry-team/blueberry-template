import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_flutter_template/widgets/post/PostItemWidget.dart';
import '../../providers/PostProvider.dart';

class Postwidget extends ConsumerWidget {
  const Postwidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(postProvider);

    return SafeArea(
      child: postsAsyncValue.when(
        data: (posts) => ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return PostItem(
              title: post.title,
              uploadTime: post.uploadTime,
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
