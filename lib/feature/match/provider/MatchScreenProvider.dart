import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/DogProfileModel.dart';

final matchScreenProvider = FutureProvider((ref) async {
  final firestore = FirebaseFirestore.instance;
  final snapshot = await firestore.collection('pet').get();
  return snapshot.docs
      .map((doc) => DogProfileModel.fromJson(doc.data()))
      .toList();
});

Future<void> addPetToFavorites(String userId, String petId) async {
  final firestore = FirebaseFirestore.instance;
  final userDoc = firestore.collection('users_test').doc(userId);

  try {
    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      // likedPets 필드가 있는지 확인
      List<dynamic> likedPets = snapshot.data()!['likedPets'] ?? [];

      // 이미 존재하지 않는 경우에만 petId를 추가
      if (!likedPets.contains(petId)) {
        likedPets.add(petId);
        await userDoc.update({
          'likedPets': likedPets,
        });
        talker.info("DB 업데이트 성공: $likedPets");
      } else {
        talker.info("DB 업데이트 실패: 이미 존재하는 petId");
      }
    } else {
      talker.info("DB 업데이트 실패: likedPets 필드가 없습니다.");
    }
  } catch (e) {
    talker.error('DB 업데이트 중 오류 발생');
  }
}

Future<void> addPetToIgnored(String userId, String petId) async {
  final firestore = FirebaseFirestore.instance;
  final userDoc = firestore.collection('users_test').doc(userId);

  try {
    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      // ignoredPets 필드가 있는지 확인
      List<dynamic> ignoredPets = snapshot.data()?['ignoredPets'] ?? [];

      // 이미 존재하지 않는 경우에만 petId를 추가
      if (!ignoredPets.contains(petId)) {
        ignoredPets.add(petId);
        await userDoc.update({
          'ignoredPets': ignoredPets,
        });
        talker.info("DB 업데이트 성공: $ignoredPets");
      } else {
        talker.info("DB 업데이트 실패: 이미 존재하는 petId");
      }
    } else {
      talker.info("DB 업데이트 실패: ignoredPets 필드가 없습니다.");
    }
  } catch (e) {
    talker.error('DB 업데이트 중 오류 발생: $e');
  }
}