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
  static const userId = "eztqDqrvEXDc8nqnnrB8"; // 로그인 상황을 가정

  // 펫 데이터를 Firestore에서 로드하고 필터링하는 함수
  Future<void> loadPets({String? location, String? gender}) async {
    _setLoading(true);

    try {
      final ignoredPets = await _getIgnoredPets();
      final pets = await _getPetsFromFirestore();

      // 매칭 조건 필터 적용
      final filteredPets = pets.where((pet) {
        return _matchesFilter(pet, ignoredPets, location, gender);
      }).toList();

      state = filteredPets.isNotEmpty ? filteredPets : [];
      if (filteredPets.isEmpty) {
        talker.info(AppStrings.noFilteredResult);
      }
    } catch (e) {
      talker.error('${AppStrings.dbLoadError}$e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
  }

  // firestore에서 사용자가 ignore한 펫 데이터 가져오기
  Future<List<dynamic>> _getIgnoredPets() async {
    final userDoc = await FirebaseFirestore.instance.collection('users_test').doc(userId).get();
    final data = userDoc.data();

    if (data != null && data.containsKey('ignoredPets')) {
      return data['ignoredPets'] ?? [];
    } else {
      return [];
    }
  }

  // firestore에서 모든 pet 데이터 가져오기
  Future<List<PetProfileModel>> _getPetsFromFirestore() async {
    final snapshot = await FirebaseFirestore.instance.collection('pet').get();
    return snapshot.docs.map((doc) => PetProfileModel.fromJson(doc.data())).toList();
  }

  // 조건에 따라 펫 데이터 필터링
  bool _matchesFilter(PetProfileModel pet, List<dynamic> ignoredPets, String? location, String? gender) {
    final matchesLocation = location == null || pet.location == location;
    final matchesGender = gender == null || pet.gender == gender;
    final notIgnored = !ignoredPets.contains(pet.petID);
    final notMyPet = pet.ownerUserID != userId;
    return matchesLocation && matchesGender && notIgnored && notMyPet;
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
    final petOwnerId = await _getPetOwnerId(petId);
    final likedPetsByOwner = await _getLikedPets(petOwnerId);
    final myPets = await _getMyPets(userId);

    // 매칭된 경우 반환
    return likedPetsByOwner.contains(myPets[0]);
  }

// 펫 소유자의 ID 가져오기
  Future<String> _getPetOwnerId(String petId) async {
    final firestore = FirebaseFirestore.instance;
    final petDoc = await firestore.collection('pet').doc(petId).get();
    return petDoc.data()!['ownerUserID'];
  }

// 특정 사용자의 좋아요 목록 가져오기
  Future<List<dynamic>> _getLikedPets(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users_test').doc(userId).get();
    return userDoc.data()!['likedPets'] ?? [];
  }

// 특정 사용자의 펫 목록 가져오기
  Future<List<dynamic>> _getMyPets(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users_test').doc(userId).get();
    return userDoc.data()!['pets'] ?? [];
  }

// 매칭 여부 확인 후 친구 추가 및 메세지 출력
  Future<void> _checkForMatchAndAddFriend(BuildContext context, String userId, String petId, String matchType) async {
    if (await _isMatchFound(userId, petId)) {
      await _handleSuccessfulMatch(context, userId, petId, matchType);
    } else {
      _handleFailedMatch(context, matchType);
    }
  }

// 매칭 성공 시 처리
  Future<void> _handleSuccessfulMatch(BuildContext context, String userId, String petId, String matchType) async {
    final petOwnerId = await _getPetOwnerId(petId);

    await _addFriend(userId, petOwnerId); // 내 친구 목록에 상대방을 추가
    await _addFriend(petOwnerId, userId); // 상대방 친구 목록에 나를 추가

    // 매칭 성공 메세지 전달
    if (context.mounted) {
      final message = (matchType == 'like')
          ? AppStrings.matchSuccessMessageLike
          : AppStrings.matchSuccessMessageSuperLike;
      _showSnackbar(context, message);
    }
  }

// 매칭 실패 시 처리
  void _handleFailedMatch(BuildContext context, String matchType) {
    if (context.mounted) {
      final message = (matchType == 'like')
          ? AppStrings.matchFailMessageLike
          : AppStrings.matchFailMessageSuperLike;
      _showSnackbar(context, message);
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

// 안내 메세지 출력
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
