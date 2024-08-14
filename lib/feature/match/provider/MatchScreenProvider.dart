import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/PetProfileModel.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';

import '../../../utils/AppStrings.dart';

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
    try {
      final snapshot = await firestore.collection('pet').get();
      final pets = snapshot.docs
          .map((doc) => PetProfileModel.fromJson(doc.data()))
          .toList();

      // ignoredPets에 포함되지 않은 펫만 state에 설정
      state = pets.where((pet) => !ignoredPets.contains(pet.petID)).toList();
    } catch (e) {
      talker.error('${AppStrings.dbLoadError}$e');
    }
  }

  Future<void> addPetToFavorites(String userId, String petId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users_test').doc(userId);

    try {
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        List<dynamic> likedPets = snapshot.data()!['likedPets'];

        //같은 petID가 존재하는지 확인하고 추가
        if (!likedPets.contains(petId)) {
          likedPets.add(petId);
          await userDoc.update({
            'likedPets': likedPets,
          });
          talker.info("${AppStrings.dbUpdateSuccess}: $likedPets");
        } else {
          talker.info(AppStrings.dbUpdateFail);
        }
      } else {
        talker.info(AppStrings.docNotExistError);
      }
    } catch (e) {
      talker.error('${AppStrings.dbUpdateError}$e');
    }
  }

  Future<void> addPetToIgnored(String userId, String petId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users_test').doc(userId);

    try {
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        List<dynamic> ignoredPets = snapshot.data()!['ignoredPets'];

        //같은 petID가 존재하는지 확인하고 추가
        if (!ignoredPets.contains(petId)) {
          ignoredPets.add(petId);
          await userDoc.update({
            'ignoredPets': ignoredPets,
          });
          talker.info("${AppStrings.dbUpdateSuccess}: $ignoredPets");

          _loadPets(); // 상태를 다시 로드하여 화면을 갱신
        } else {
          talker.info(AppStrings.dbUpdateFail);
        }
      } else {
        talker.info(AppStrings.docNotExistError);
      }
    } catch (e) {
      talker.error('${AppStrings.dbUpdateError}$e');
    }
  }
}

final matchScreenProvider =
    StateNotifierProvider<MatchScreenNotifier, List<PetProfileModel>>(
  (ref) => MatchScreenNotifier(),
);
