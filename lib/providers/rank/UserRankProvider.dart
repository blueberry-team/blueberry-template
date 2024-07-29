import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_flutter_template/model/UserModel.dart';

final userProvider = FutureProvider<List<UserModel>>((ref) async {
  final fireStore = FirebaseFirestore.instance;

  // 좋아요수로 내림차순 정렬된 likes 컬렉션 문서 가져오기
  final likesSnapshot = await fireStore
      .collection('likes')
      .orderBy('likedUsers', descending: true)
      .get();

  // likes에 있는 유저 아이디 리스트 가져오기
  final likedUserIds = likesSnapshot.docs
      .expand((doc) => List<String>.from(doc['likedUsers']))
      .toList();

  // 유저 아이디 리스트를 기반으로 유저 정보 가져오기
  final userDocs = await Future.wait(
    likedUserIds
        .map((userId) => fireStore.collection('users').doc(userId).get())
        .toList(),
  );

  // UserModel로 변환
  final users = userDocs.map((doc) {
    if (doc.exists) {
      final data = doc.data()!;
      return UserModel(
        userId: doc.id,
        name: data['name'] as String,
        email: data['email'] as String,
        age: data['age'] as int,
        profileImageUrl: data['profilePicture'] as String,
        createdAt: DateTime.parse(data['createdAt'] as String),
      );
    } else {
      throw Exception('User not found');
    }
  }).toList();

  return users;
});
