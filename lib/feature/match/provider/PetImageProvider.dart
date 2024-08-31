import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Pet 이미지 URL을 제공하는 Provider
final petImageProvider = FutureProvider.family<String, String>((ref, imageName) async {
  final storageRef = FirebaseStorage.instance.ref('pet/$imageName');
  return await storageRef.getDownloadURL();
});

