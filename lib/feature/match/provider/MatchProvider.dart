import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      // 모든 펫 정보를 가져오기
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

  Future<void> _updatePetList(
      BuildContext context, String userId, String petId, String fieldName, String snackbarMessage) async {
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
        _showSnackbar(context, snackbarMessage);
      } else {
        talker.info(AppStrings.dbUpdateFail);
      }
    } catch (e) {
      talker.error('${AppStrings.dbUpdateError}$e');
    }
  }

  Future<void> addPetToLikes(BuildContext context, String userId, String petId) async {
    await _updatePetList(context, userId, petId, 'likedPets', AppStrings.dbUpdateSuccessMessage);
  }

  Future<void> addPetToSuperLikes(BuildContext context, String userId, String petId) async {
    await _updatePetList(context, userId, petId, 'superLikedPets', AppStrings.dbUpdateSuperLikesMessage);
  }

  Future<void> addPetToIgnored(BuildContext context, String userId, String petId) async {
    await _updatePetList(context, userId, petId, 'ignoredPets',  AppStrings.dbUpdateIgnoredMessage);
    loadPets();
  }

  Future<void> _checkForMatch(String userId, String petId) async {
    // 하트를 누른 펫의 petOwnerId 가져오기
    final firestore = FirebaseFirestore.instance;
    final petDoc = await firestore.collection('pet').doc(petId).get();
    final petOwnerId = petDoc.data()!['ownerUserID'];

    // 상대방의 likedPets 목록 가져오기
    final userDoc = await firestore.collection('users_test').doc(petOwnerId).get();
    List<dynamic> likedPetsByOwner = userDoc.data()!['likedPets'] ?? [];

    // 내 Pets 목록 가져오기 (로그인 가능해진 후에는 내 펫 정보를 가져오는 방법을 변경해야 함)
    final myUserDoc = await firestore.collection('users_test').doc(userId).get();
    List<dynamic> myPets = myUserDoc.data()!['pets'] ?? [];

    // likedPetsByOwner 에 내 petID 가 있을 경우 서로 좋아요한 것으로 간주하여 friends 서브 컬렉션 서로의 정보를 등록
    if (likedPetsByOwner.contains(myPets[0])) {
      talker.info("Match found between $likedPetsByOwner and $myPets");
      await _addFriend(userId, petOwnerId); // 내 친구 목록에 상대방을 친구로 추가
      await _addFriend(petOwnerId, userId); // 상대방 친구 목록에 나를 친구로 추가
    } else {
      talker.info("No match found between $likedPetsByOwner and $myPets");
    }
  }

  Future<void> _addFriend(String userId, String friendId) async {
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

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // 해당 유저를 추천 안함 기능 (ProfileScreen 에서 호출)
  Future<void> handleIgnoreProfile({
    required BuildContext context,
    required PetProfileModel petProfile,
  }) async {
    await addPetToIgnored(context, userId, petProfile.petID);
    if (context.mounted) {
      Navigator.of(context).pop(); // 프로필 화면 닫기
    }
  }
}

final matchScreenProvider =
    StateNotifierProvider<MatchScreenNotifier, List<PetProfileModel>>(
  (ref) => MatchScreenNotifier(),
);
