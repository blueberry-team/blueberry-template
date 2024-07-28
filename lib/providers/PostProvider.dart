import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Post {
  final String title;
  final String content;
  final String imageUrl;
  final String uploadTime;

  Post({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.uploadTime,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      title: data['title'] as String,
      content: data['content'] as String,
      imageUrl: data['imageUrl'] as String,
      uploadTime: (data['uploadTime'] as String),
    );
  }
}

final postProvider = StreamProvider<List<Post>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('posts').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
  });
});
