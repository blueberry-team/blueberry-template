import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_flutter_template/model/PostModel.dart';

final postProvider = StreamProvider<List<PostModel>>((ref) {
  final firestore = FirebaseFirestore.instance;

  return firestore.collection('posts').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();

      // Firestore Timestamp 를 String으로 변환
      final createdAt =
          (data['createdAt'] as Timestamp).toDate().toIso8601String();

      // 변환된 String 형의 createdAt 를 PostModel에 전달(freezed로 생성된 fromJson은 String을 DateTime으로 변환)
      final post = PostModel.fromJson({
        ...data,
        'createdAt': createdAt,
      });

      return post;
    }).toList();
  });
});
