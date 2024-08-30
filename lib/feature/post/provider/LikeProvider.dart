import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final likeProvider = StateNotifierProvider<LikeNotifier, Map<String, bool>>((ref) {
  return LikeNotifier();
});

class LikeNotifier extends StateNotifier<Map<String, bool>> {
  LikeNotifier() : super({});

  // 좋아요 상태를 가져오기
  Future<void> fetchLikeStatus(String postID, String userID) async {

    final likeDoc = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('likes')
        .doc(userID)
        .get();

    if (likeDoc.exists) {
      state = {
        ...state,
        'postID': true,
      };
    } else {
      state = {
        ...state,
        'postID': false,
      };
    }
  }

  // 좋아요 토글 기능
  Future<void> toggleLike(String postID, String userID) async {

    final postRef = FirebaseFirestore.instance.collection('posts').doc(postID);
    final likeRef = postRef.collection('likes').doc(userID);

    final likeDoc = await likeRef.get();
    final isLiked = likeDoc.exists;

    if (isLiked) {
      // 이미 좋아요 상태라면 좋아요 취소
      await likeRef.delete();
      state = {
        ...state,
        postID: false,
      };
    } else {
      // 좋아요 추가
      await likeRef.set({
        'createdAt': Timestamp.now(),
        'postID': postID,
        'userID': userID,
      });
      state = {
        ...state,
        postID: true,
      };
    }

    // 좋아요 카운트 업데이트
    await _updateLikesCount(postRef, isLiked ? -1 : 1);
  }

  // 좋아요 카운트 업데이트 기능
  Future<void> _updateLikesCount(DocumentReference postRef, int likeChange) async {
    await postRef.update({
      'likesCount': FieldValue.increment(likeChange),
    });
  }
}
