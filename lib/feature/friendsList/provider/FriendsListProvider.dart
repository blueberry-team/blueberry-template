import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/FriendModel.dart';
import '../../../utils/Talker.dart';
import '../../userreport/provider/UserReportBottomSheetWidget.dart';

// 친구목록을 제공하는 Provider
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

            final userDoc =
                await firestore.collection('users_test').doc(userID).get();

            if (userDoc.exists) {
              return FriendModel.fromJson(userDoc.data()!);
            } else {
              talker.warning('User data not found for userID: $userID');
              throw Exception('User data not found for userID: $userID');
            }
          }).toList()));
});

final deleteFriendProvider =
    Provider<Future<void> Function(BuildContext, FriendModel)>((ref) {
  return (BuildContext context, FriendModel friend) async {
    final firestore = FirebaseFirestore.instance;
    const userId = 'eztqDqrvEXDc8nqnnrB8'; // 로그인을 가정한 임시 유저 ID

    await firestore
        .collection('users_test')
        .doc(userId)
        .collection('friends')
        .doc(friend.userID)
        .delete();

    ref.invalidate(friendsListProvider);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('친구가 삭제되었습니다.')),
      );
    }
  };
});

// 친구목록 이미지 URL을 제공하는 Provider
final friendsListImageProvider =
    FutureProvider.family<String, String>((ref, imageName) async {
  final storageRef = FirebaseStorage.instance.ref('profileimage/$imageName');
  final downloadUrl = await storageRef.getDownloadURL();
  return downloadUrl;
});

// ui 팝업 메뉴 선택시 처리하는 함수 (서비스 로직 분리 예정)
void handleMenuSelection(
    BuildContext context, WidgetRef ref, int value, FriendModel friend) async {
  switch (value) {
    case 1:
      // 삭제
      final deleteFriend = ref.read(deleteFriendProvider);
      Navigator.of(context).pop();
      await deleteFriend(context, friend);
      break;
    case 2:
      // 차단
      Navigator.of(context).pop();
      break;
    case 3:
      // 신고
      Navigator.of(context).pop();
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (context) => UserReportBottomSheetWidget(friend: friend),
      );
      break;
  }
}
