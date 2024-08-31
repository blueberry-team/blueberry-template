import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_flutter_template/model/CommentModel.dart';

final commentProvider = StreamProvider.family<List<CommentModel>, String>((ref, postID) {
  final firestore = FirebaseFirestore.instance;

  return firestore.collection('posts')
      .doc(postID)
      .collection('comments')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return CommentModel.fromJson(doc.data());
    }).toList();
  });
});

final commentNotifierProvider = Provider.family<CommentNotifier, String>((ref, postID) {
  return CommentNotifier(ref, postID);
});

class CommentNotifier {
  final ProviderRef ref;
  final String postID;

  CommentNotifier(this.ref, this.postID);

  Future<void> addComment(String content, String userID) async {
    final firestore = FirebaseFirestore.instance;

    final newComment = CommentModel(
      commentID: firestore.collection('comments').doc().id,
      postID: postID,
      userID: userID,
      content: content,
      createdAt: DateTime.now(),
    );

    await firestore.collection('posts').doc(postID)
        .collection('comments')
        .doc(newComment.commentID)
        .set(newComment.toJson());

    // commentsCount 필드 증가
    await firestore.collection('posts').doc(postID).update({
      'commentsCount': FieldValue.increment(1),
    });
  }
}
