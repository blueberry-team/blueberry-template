import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/FriendModel.dart';
import '../../../utils/AppStrings.dart';
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
      .asyncMap((snapshot) async {
    final friendModels = await Future.wait(snapshot.docs.map((doc) async {
      final userID = doc['userID'] as String;
      final userDoc = await firestore.collection('users_test').doc(userID).get();

      if (userDoc.exists) {
        return FriendModel.fromJson(userDoc.data()!);
      } else {
        throw Exception(AppStrings.userNotFoundErrorMessage);
      }
    }).toList());

    return friendModels;
  });
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
        const SnackBar(content: Text(AppStrings.friendDeleteSuccessMessage)),
      );
    }
  };
});



// ui 팝업 메뉴 선택시 처리하는 함수
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
      Navigator.of(context).pop();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('차단 기능이 아직 구현되지 않았습니다.')),
        );
      }
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
