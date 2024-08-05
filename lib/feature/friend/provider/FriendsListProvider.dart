import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../model/FriendModel.dart';


// 친구 목록을 제공하는 Provider
final friendsListProvider = StreamProvider<List<FriendModel>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('friends').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => FriendModel.fromDocument(doc)).toList();
  });
});

// friendImageURL을 가져오는 함수
Future<String> fetchFriendImageUrl(String imageName) async {
  try {
    final ref = FirebaseStorage.instance.ref('friends-profile/$imageName.jpeg');
    final imageUrl = await ref.getDownloadURL();
    print('프로바이더 패치 함수: $imageUrl'); // 로깅 추가
    return imageUrl;
  } catch (e) {
    print('Error fetching image URL: $e');
    return '';
  }
}

// 이미지 URL을 제공하는 Provider
final imageProvider = FutureProvider.family<String, String>((ref, imageName) async {
  return await fetchFriendImageUrl(imageName);
});

//마지막 접속 시간을 일,시,분 별로 포멧팅해서 제공 해주는 함수
String timeAgo(DateTime dateTime) {
  final duration = DateTime.now().difference(dateTime);
  if (duration.inDays > 1) {
    return '${duration.inDays} days ago';
  } else if (duration.inHours > 1) {
    return '${duration.inHours} hours ago';
  } else if (duration.inMinutes > 1) {
    return '${duration.inMinutes} minutes ago';
  } else {
    return 'Just now';
  }
}