import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dislikeProvider =
    StateNotifierProvider<DislikeNotifier, Map<String, bool>>((ref) {
  return DislikeNotifier();
});

class DislikeNotifier extends StateNotifier<Map<String, bool>> {
  DislikeNotifier() : super({});

  // 싫어요 상태를 가져오기
  Future<void> fetchDislikeStatus(String postID, String userID) async {
    final dislikeDoc = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('dislikes')
        .doc(userID)
        .get();

    if (dislikeDoc.exists) {
      state = {
        ...state,
        postID: true,
      };
    } else {
      state = {
        ...state,
        postID: false,
      };
    }
  }

  // 싫어요 토글 기능
  Future<void> toggleDislike(String postID, String userID) async {
    final postRef = FirebaseFirestore.instance.collection('posts').doc(postID);
    final dislikeRef = postRef.collection('dislikes').doc(userID);

    final dislikeDoc = await dislikeRef.get();
    final isDisliked = dislikeDoc.exists;

    if (isDisliked) {
      // 이미 싫어요 상태라면 싫어요 취소
      await dislikeRef.delete();
      state = {
        ...state,
        postID: false,
      };
    } else {
      // 싫어요 추가
      await dislikeRef.set({
        'createdAt': Timestamp.now(),
        'postID': postID,
        'userID': userID,
      });
      state = {
        ...state,
        postID: true,
      };
    }

    // 싫어요 카운트 업데이트
    await _updateDislikesCount(postRef, isDisliked ? -1 : 1);
  }

  // 싫어요 카운트 업데이트 기능
  Future<void> _updateDislikesCount(
      DocumentReference postRef, int dislikeChange) async {
    await postRef.update({
      'dislikesCount': FieldValue.increment(dislikeChange),
    });
  }
}
