import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_flutter_template/model/PostUserInfoModel.dart';

final postUserInfoProvider =
    FutureProvider.family<PostUserInfoModel, String>((ref, userID) async {
  final firestore = FirebaseFirestore.instance;

  final userDoc = await firestore.collection('users_test').doc(userID).get();

  if (userDoc.exists) {
    final data = userDoc.data()!;
    final userName = data['name'] as String;
    final imageName = data['imageName'] as String;

    final storageRef =
        FirebaseStorage.instance.ref().child('profileimage/$imageName');
    final profileImageUrl = await storageRef.getDownloadURL();

    return PostUserInfoModel(
      name: userName,
      profileImageUrl: profileImageUrl,
    );
  } else {
    throw Exception('User data not found for userID: $userID');
  }
});
