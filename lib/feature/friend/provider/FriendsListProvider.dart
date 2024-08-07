import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../model/FriendModel.dart';

// 친구 목록을 제공하는 Provider
final friendsListProvider = StreamProvider<List<FriendModel>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('friends').snapshots().map((snapshot) {
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

// friendImageURL을 가져오는 함수
Future<String> fetchFriendImageUrl(String imageName) async {
  final ref = FirebaseStorage.instance.ref('friends-profile/$imageName');
  final imageUrl = await ref.getDownloadURL();
  return imageUrl;
}

// 이미지 URL을 제공하는 Provider
final imageProvider =
    FutureProvider.family<String, String>((ref, imageName) async {
  return await fetchFriendImageUrl(imageName);
});
