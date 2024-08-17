import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../model/FriendModel.dart';

// 친구 목록을 제공하는 Provider
final friendsListProvider = StreamProvider<List<FriendModel>>((ref) {
  final firestore = FirebaseFirestore.instance;

  const userId = 'eztqDqrvEXDc8nqnnrB8'; // 로그인을 가정한 임시 유저 ID

  return firestore
      .collection('users_test')
      .doc(userId)
      .collection('friends')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return FriendModel.fromJson({
        ...data,
        'lastConnect':
            (data['lastConnect'] as Timestamp).toDate().toIso8601String(),
      });
    }).toList();
  });
});

// 친구목록 이미지 URL을 제공하는 Provider
final friendsListImageProvider = FutureProvider.family<String, String>((ref, imageName) async {
  final ref = FirebaseStorage.instance.ref('friends-profile/$imageName');
  return await ref.getDownloadURL();
});

// /// 이미지 URL을 제공하는 공용 Provider
// final imageProvider = FutureProvider.family<String, String>((ref, imagePath) async {
//   final ref = FirebaseStorage.instance.ref(imagePath);
//   return await ref.getDownloadURL();
// });
