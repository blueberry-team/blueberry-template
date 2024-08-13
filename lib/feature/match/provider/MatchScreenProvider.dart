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
        talker.info("DB 업데이트 필요 없음: 이미 존재하는 petId");
      }
    } else {
      // 사용자가 존재하지 않는 경우 새 문서를 생성
      await userDoc.set({
        'likedPets': [petId],
      });
      talker.info("새 사용자 문서 생성 및 likedPets 업데이트 성공");
    }
  } catch (e) {
    talker.error('DB 업데이트 중 오류 발생');
  }
}
