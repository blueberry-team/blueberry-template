import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/PetProfileModel.dart';

//지금 유저가 ignoredPets에 추가한 펫을 제외한 모든 펫을 가져오는 Provider
final matchScreenProvider = FutureProvider<List<PetProfileModel>>((ref) async {
  const userId = "eztqDqrvEXDc8nqnnrB8"; // 사용자의 userId (임시로 하드코딩)
  final firestore = FirebaseFirestore.instance;
  final userDoc = await firestore.collection('users_test').doc(userId).get();

  // 사용자의 ignoredPets 목록 가져오기
  List<dynamic> ignoredPets = [];
  if (userDoc.exists) {
    ignoredPets = userDoc.data()?['ignoredPets'] ?? [];
  }
  talker.info("ignoredPets 목록: $ignoredPets");

  // 모든 펫 목록 가져오기
  final snapshot = await firestore.collection('pet').get();
  final pets = snapshot.docs.map((doc) => PetProfileModel.fromJson(doc.data())).toList();
  talker.info("모든 펫 목록: $pets");

  // ignoredPets에 포함되지 않은 펫만 반환
  final filteredPets = pets.where((pet) => !ignoredPets.contains(pet.petID)).toList();
  talker.info("ignoredPets에 포함되지 않은 펫 목록: $filteredPets");
  return filteredPets;
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
