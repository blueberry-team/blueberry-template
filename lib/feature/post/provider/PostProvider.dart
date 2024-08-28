import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_flutter_template/model/PostModel.dart';

final postListInfoProvider = StreamProvider<List<PostModel>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('posts').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();

      // 로깅 추가
      talker.info('Raw data: $data');

      // 변환된 데이터를 PostModel에 전달 (createdAt 변환 로직은 모델에 포함되어 있음)
      final post = PostModel.fromJson(data);

      // 로깅 추가
      talker.info('PostModel created: $post');

      return post;
    }).toList();
  });
});
