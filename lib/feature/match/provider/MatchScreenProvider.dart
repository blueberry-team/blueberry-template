import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/PetProfileModel.dart';
import '../../../utils/AppStrings.dart';
import '../../../utils/Talker.dart';

class MatchScreenNotifier extends StateNotifier<List<PetProfileModel>> {
  MatchScreenNotifier() : super([]) {
    loadPets();
  }

  bool isLoading = false;
  String? errorMessage;
  static const userId = "eztqDqrvEXDc8nqnnrB8"; // 로그인 상황을 가정한 userId

  Future<void> loadPets({String? location, String? gender}) async {
    // 상태 초기화
    state = [];
    isLoading = true;

    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users_test').doc(userId).get();

    List<dynamic> ignoredPets = [];
    if (userDoc.exists) {
      ignoredPets = userDoc.data()?['ignoredPets'] ?? [];
    }

    try {
      final snapshot = await firestore.collection('pet').get();
      final pets = snapshot.docs
          .map((doc) => PetProfileModel.fromJson(doc.data()))
          .toList();

      // 매칭 조건 필터 적용
      List<PetProfileModel> filteredPets = pets.where((pet) {
        final matchesLocation = location == null || pet.location == location;
        final matchesGender = gender == null || pet.gender == gender;
        final notIgnored = !ignoredPets.contains(pet.petID);
        return matchesLocation && matchesGender && notIgnored;
      }).toList();

      // 필터링된 결과가 있을 경우 상태를 업데이트
      if (filteredPets.isNotEmpty) {
        state = filteredPets;
      } else {
        talker.info(AppStrings.noFilteredResult);
      }
    } catch (e) {
      talker.error('${AppStrings.dbLoadError}$e');
    } finally {
      isLoading = false;
    }
  }

  // Firebase DB field 명을 받아서 해당 필드에 petId를 추가하는 함수
  Future<void> _updatePetList(
      String userId, String petId, String fieldName) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users_test').doc(userId);

    try {
      final snapshot = await userDoc.get();
      List<dynamic> petList = snapshot.data()![fieldName];

      if (!petList.contains(petId)) {
        petList.add(petId);
        await userDoc.update({
          fieldName: petList,
        });
        talker.info("${AppStrings.dbUpdateSuccess}: $petList");
      } else {
        talker.info(AppStrings.dbUpdateFail);
      }
    } catch (e) {
      talker.error('${AppStrings.dbUpdateError}$e');
    }
  }

  Future<void> addPetToLikes(String userId, String petId) async {
    await _updatePetList(userId, petId, 'likedPets');
  }

  Future<void> addPetToSuperLikes(String userId, String petId) async {
    await _updatePetList(userId, petId, 'superLikedPets');
  }

  Future<void> addPetToIgnored(String userId, String petId) async {
    await _updatePetList(userId, petId, 'ignoredPets');
    loadPets(); // 무시한 후에는 다시 데이터를 로드
  }
}

final matchScreenProvider =
    StateNotifierProvider<MatchScreenNotifier, List<PetProfileModel>>(
  (ref) => MatchScreenNotifier(),
);
