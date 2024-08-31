import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 친구목록 이미지 URL을 제공하는 Provider
final friendsListImageProvider =
FutureProvider.family<String, String>((ref, imageName) async {
  final storageRef = FirebaseStorage.instance.ref('profileimage/$imageName');
  final downloadUrl = await storageRef.getDownloadURL();
  return downloadUrl;
});