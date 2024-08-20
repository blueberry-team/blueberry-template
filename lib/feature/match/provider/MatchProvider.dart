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

  // 펫 데이터를 Firestore에서 로드하고 필터링하는 함수
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
      // 모든 펫 정보를 Firestore에서 가져오기
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

  // 펫 좋아요 기능
  Future<void> addPetToLikes(BuildContext context, String userId, String petId) async {
    await _updatePetList(context, userId, petId, 'likedPets');
    _checkForMatchAndAddFriend(context, userId, petId, 'like');
  }

  // 펫 즐겨찾기 기능
  Future<void> addPetToSuperLikes(BuildContext context, String userId, String petId) async {
    await _updatePetList(context, userId, petId, 'superLikedPets');
    _checkForMatchAndAddFriend(context, userId, petId, 'superlike');
  }

  // 펫 추천 안함 기능
  Future<void> addPetToIgnored(BuildContext context, String userId, String petId) async {
    await _updatePetList(context, userId, petId, 'ignoredPets');
    loadPets();
    _showSnackbar(context, AppStrings.ignoreSuccessMessage);
  }

  // 특정 필드에 펫 ID 추가 기능
  Future<void> _updatePetList(BuildContext context, String userId, String petId, String fieldName) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users_test').doc(userId);
    final snapshot = await userDoc.get();
    List<dynamic> petList = snapshot.data()![fieldName];

    if (!petList.contains(petId)) {
      petList.add(petId);
      await userDoc.update({fieldName: petList});
    }
  }

  // 펫 좋아요 후 매칭 여부 확인
  Future<bool> _isMatchFound(String userId, String petId) async {
    final firestore = FirebaseFirestore.instance;

    // 하트를 누른 펫의 주인 ID 가져오기
    final petDoc = await firestore.collection('pet').doc(petId).get();
    final petOwnerId = petDoc.data()!['ownerUserID'];

    // 상대방의 좋아요 목록 가져오기
    final userDoc = await firestore.collection('users_test').doc(petOwnerId).get();
    List<dynamic> likedPetsByOwner = userDoc.data()!['likedPets'] ?? [];

    // 내 펫 목록 가져오기
    final myUserDoc = await firestore.collection('users_test').doc(userId).get();
    List<dynamic> myPets = myUserDoc.data()!['pets'] ?? [];

    // 매칭된 경우 반환
    return likedPetsByOwner.contains(myPets[0]);
  }

  // 매칭 여부 확인 후 친구 추가 및 메세지 출력
  Future<void> _checkForMatchAndAddFriend(BuildContext context, String userId, String petId, String matchType) async {
    if (await _isMatchFound(userId, petId)) {
      final firestore = FirebaseFirestore.instance;
      final petDoc = await firestore.collection('pet').doc(petId).get();
      final petOwnerId = petDoc.data()!['ownerUserID'];

      await _addFriend(userId, petOwnerId); // 내 친구 목록에 상대방을 추가
      await _addFriend(petOwnerId, userId); // 상대방 친구 목록에 나를 추가

      // 매칭 성공 메세지 전달
      if (context.mounted) {
        if (matchType == 'like') {
          _showSnackbar(context, AppStrings.matchSuccessMessageLike);
        } else if (matchType == 'superlike') {
          _showSnackbar(context, AppStrings.matchSuccessMessageSuperLike);
        }
      }
    } else {
      // 매칭 실패 메세지 전달
      if (context.mounted) {
        if (matchType == 'like') {
          _showSnackbar(context, AppStrings.matchFailMessageLike);
        } else if (matchType == 'superlike') {
          _showSnackbar(context, AppStrings.matchFailMessageSuperLike);
        }
      }
    }
  }

  // 친구 추가 기능
  Future<void> _addFriend(String userId, String friendId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users_test').doc(userId);
    await userDoc.collection('friends').doc(friendId).set({
      'userId': friendId,
      'addedDate': Timestamp.now(),
    });
  }

  // 안내메세지 출력
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ProfileScreen 에서 호출하는 함수
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

final matchScreenProvider = StateNotifierProvider<MatchScreenNotifier, List<PetProfileModel>>(
      (ref) => MatchScreenNotifier(),
);
