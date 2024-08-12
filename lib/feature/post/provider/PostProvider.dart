import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_flutter_template/model/PostModel.dart';

final postListInfoProvider = StreamProvider<List<PostModel>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('posts').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  });
});
