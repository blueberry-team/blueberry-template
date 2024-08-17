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
      final pets = snapshot.docs.map((doc) {
        final data = doc.data();

        // 필드가 누락되었을 가능성을 검사하고 로깅
        if (data['petID'] == null || data['name'] == null || data['location'] == null) {
          talker.error("Missing required fields in pet data: $data");
        }

        return PetProfileModel.fromJson(data);
      }).toList();

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
    talker.info("match provider petId: $petId");
    await _updatePetList(userId, petId, 'likedPets');
    await _checkForMatch(userId, petId);
  }

  Future<void> addPetToSuperLikes(String userId, String petId) async {
    await _updatePetList(userId, petId, 'superLikedPets');
    await _checkForMatch(userId, petId);
  }

  Future<void> addPetToIgnored(String userId, String petId) async {
    await _updatePetList(userId, petId, 'ignoredPets');
    loadPets(); // 무시한 후에는 다시 데이터를 로드
  }

  Future<void> _checkForMatch(String userId, String petId) async {
    talker.info("checkFroMatch fonc : $userId, $petId");
    final firestore = FirebaseFirestore.instance;
    // 상대방의 petOwnerId를 가져옴
    final petDoc = await firestore.collection('pet').doc(petId).get();
    final petOwnerId = petDoc.data()!['ownerUserID'];
    talker.info("petOwnerId: $petOwnerId");

    // 상대방이 좋아요한 펫 목록을 가져옴
    final userDoc = await firestore.collection('users_test').doc(petOwnerId).get();
    List<dynamic> likedPetsByOwner = userDoc.data()!['likedPets'] ?? [];
    talker.info("likedPetsByOwner: $likedPetsByOwner");

    // 내 펫 가져오기 (로그인 가능해진 후에는 내 펫 정보를 가져오는 방법을 변경해야 함)
    final myUserDoc = await firestore.collection('users_test').doc(userId).get();
    List<dynamic> myPets = myUserDoc.data()!['pets'] ?? [];
    talker.info("myPets: $myPets");

    // likedPetsByOwner 에 내 petID가 있을 경우 서로 좋아요한 것으로 간주 (코드 정리 필요)
    if (likedPetsByOwner.contains(myPets[0])) {
      talker.info("Match found between $likedPetsByOwner and $myPets[0]");
      await _addFriend(userId, petOwnerId);
      await _addFriend(petOwnerId, userId);
    } else {
      talker.info("No match found between $likedPetsByOwner and $myPets[0]");
    }
  }

  Future<void> _addFriend(String userId, String friendId) async {
    talker.info("addFriend fonc : $userId, $friendId");
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users_test').doc(userId);

    try {
      await userDoc.collection('friends').doc(friendId).set({
        'userId': friendId,
        'addedDate': Timestamp.now(),
      });
      talker.info("Friend added between $userId and $friendId");
    } catch (e) {
      talker.error("Error adding friend: $e");
    }
  }
}

final matchScreenProvider =
StateNotifierProvider<MatchScreenNotifier, List<PetProfileModel>>(
      (ref) => MatchScreenNotifier(),
);
