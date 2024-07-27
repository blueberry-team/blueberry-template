import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/FriendsModel.dart';

// Firestore에서 친구 목록 데이터를 가져오는 StreamProvider
final friendsListProvider = StreamProvider<List<FriendsModel>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('friends').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return FriendsModel(
        userId: data['userId'] as String,
        friendId: data['friendId'] as String,
        name: data['name'] as String,
        profilePicture: data['profilePicture'] as String,
        status: data['status'] as String,
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );
    }).toList();
  });
});

// Firebase Storage에서 이미지를 가져오는 함수
Future<String> fetchProfilePictureUrl(String imageName) async {
  final ref = FirebaseStorage.instance.ref('friends-profile/$imageName.png');
  return await ref.getDownloadURL();
}

// 이미지 URL을 제공하는 FutureProvider
final profilePictureProvider =
FutureProvider.family<String, String>((ref, imageName) async {
  return await fetchProfilePictureUrl(imageName);
});
