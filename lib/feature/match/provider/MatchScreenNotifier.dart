import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/PetProfileModel.dart';
import '../../../utils/Talker.dart';

class MatchScreenNotifier extends StateNotifier<List<PetProfileModel>> {
  MatchScreenNotifier() : super([]) {
    _loadPets();
  }

  Future<void> _loadPets() async {
    const userId = "eztqDqrvEXDc8nqnnrB8"; // 사용자의 userId (임시로 하드코딩)
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users_test').doc(userId).get();

    // 사용자의 ignoredPets 목록 가져오기
    List<dynamic> ignoredPets = [];
    if (userDoc.exists) {
      ignoredPets = userDoc.data()?['ignoredPets'] ?? [];
    }

    // 모든 펫 목록 가져오기
    final snapshot = await firestore.collection('pet').get();
    final pets = snapshot.docs
        .map((doc) => PetProfileModel.fromJson(doc.data()))
        .toList();

    // ignoredPets에 포함되지 않은 펫만 상태로 설정
    state = pets.where((pet) => !ignoredPets.contains(pet.petID)).toList();
  }

  Future<void> addPetToIgnored(String userId, String petId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users_test').doc(userId);

    try {
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        List<dynamic> ignoredPets = snapshot.data()?['ignoredPets'] ?? [];

        if (!ignoredPets.contains(petId)) {
          ignoredPets.add(petId);
          await userDoc.update({
            'ignoredPets': ignoredPets,
          });
          // 상태를 다시 로드하여 화면을 갱신
          _loadPets();
        }
      }
    } catch (e) {
      talker.error('DB 업데이트 중 오류 발생: $e');
    }
  }
}
