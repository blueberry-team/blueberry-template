import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../model/FriendModel.dart';

final friendsListProvider = StreamProvider<List<FriendModel>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('friends').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return FriendModel(
        userId: data['userId'] as String,
        friendId: data['friendId'] as String,
        name: data['name'] as String,
        imageUrl: data['imageUrl'] as String,
        status: data['status'] as String,
        likes: data['likes'] as int,
        lastConnect: (data['lastConnect'] as Timestamp).toDate(),
      );
    }).toList();
  });
});

Future<String> fetchFriendImageUrl(String imageName) async {
  final ref = FirebaseStorage.instance.ref('friends-mypage/$imageName.webp');
  return await ref.getDownloadURL();
}

final friendImageProvider =
  FutureProvider.family<String, String>((ref, imageName) async {
  return await fetchFriendImageUrl(imageName);
});

