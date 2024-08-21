import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/FriendModel.dart';

// 친구 목록을 제공하는 Provider
final friendsListProvider = StreamProvider<List<FriendModel>>((ref) {
  final firestore = FirebaseFirestore.instance;
  const userId = 'eztqDqrvEXDc8nqnnrB8'; // 로그인을 가정한 임시 유저 ID

  return firestore
      .collection('users_test')
      .doc(userId)
      .collection('friends')
      .snapshots()
      .asyncMap((snapshot) => Future.wait(snapshot.docs.map((doc) async {
    final userID = doc['userID'] as String;
    talker.info('Fetching data for userID: $userID');

    final userDoc = await firestore.collection('users_test').doc(userID).get();

    if (userDoc.exists) {
      talker.info('User data found: ${userDoc.data()}');
      return FriendModel.fromJson(userDoc.data()!);
    } else {
      talker.warning('User data not found for userID: $userID');
      throw Exception('User data not found for userID: $userID');
    }
  }).toList()));
});

// 친구목록 이미지 URL을 제공하는 Provider
final friendsListImageProvider =
FutureProvider.family<String, String>((ref, imageName) async {
  try {
    final storageRef = FirebaseStorage.instance.ref('profileimage/$imageName');
    final downloadUrl = await storageRef.getDownloadURL();

    talker.info('Download URL for image $imageName: $downloadUrl');
    return downloadUrl;
  } catch (e, stacktrace) {
    talker.error('Failed to fetch download URL for image $imageName', e, stacktrace);
    rethrow;
  }
});
