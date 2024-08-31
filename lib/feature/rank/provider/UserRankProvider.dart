import 'dart:convert';

import 'package:blueberry_flutter_template/model/UserModel.dart';
import 'package:blueberry_flutter_template/services/cache/CacheService.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// User provider - Firestore에서 사용자 데이터를 가져오고 캐싱 처리
final userProvider = FutureProvider<List<UserModel>>((ref) async {
  final cacheService = CacheService.instance;

  final cacheConfig = _createCacheConfig();

  try {
    // 1. 캐시된 데이터 가져오기 시도
    final cachedUsers = await _getCachedUsers(cacheService, cacheConfig);
    if (cachedUsers != null) return cachedUsers;

    // 2. Firestore에서 데이터 가져오기
    final users = await _fetchUsersFromFirestore();

    // 3. 캐시에 사용자 데이터 저장
    await _cacheUsers(cacheService, cacheConfig, users);

    return users;
  } catch (e) {
    throw Exception('Failed to load users');
  }
});

/// 캐시 구성 생성 함수
CacheConfig _createCacheConfig() {
  // 한국 시간으로 매일 오전 9시 설정
  final now = DateTime.now().toUtc().add(const Duration(hours: 9));
  final tomorrowMorning = DateTime(now.year, now.month, now.day + 1, 9).toUtc();

  return CacheConfig(
    cacheKey: AppStrings.userCacheKey,
    expiryTime: tomorrowMorning, // 다음 날 오전 9시까지 유효
  );
}

/// 캐시된 사용자 데이터를 가져오는 함수
Future<List<UserModel>?> _getCachedUsers(
  CacheService cacheService,
  CacheConfig cacheConfig,
) async {
  try {
    final cachedData = await cacheService.getCachedData(cacheConfig);
    if (cachedData != null) {
      // 캐시 만료 시간 확인
      final now = DateTime.now().toUtc();
      if (cacheConfig.expiryTime != null &&
          now.isBefore(cacheConfig.expiryTime!)) {
        return _decodeCachedUsers(cachedData);
      } else {
        // 만료되었으면 캐시 삭제
        await cacheService.deleteCachedData(cacheConfig.cacheKey);
      }
    }
  } catch (e) {
    throw Exception('Failed to fetch user cached data');
  }
  return null;
}

/// 캐시된 사용자 데이터를 디코딩하는 함수
List<UserModel> _decodeCachedUsers(String cachedData) {
  final List<dynamic> jsonData = json.decode(cachedData);
  return jsonData
      .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
      .toList();
}

/// Firestore에서 사용자 데이터를 가져오는 함수
Future<List<UserModel>> _fetchUsersFromFirestore() async {
  try {
    final fireStore = FirebaseFirestore.instance;

    // 'likes' 컬렉션에서 좋아요 순으로 사용자 아이디 가져오기
    final likedUserIds = await _fetchLikedUserIds(fireStore);

    // 'users' 컬렉션에서 해당 사용자 문서들 가져오기
    final userDocs = await _fetchUserDocs(fireStore, likedUserIds);

    return _mapDocsToUsers(userDocs);
  } catch (e) {
    throw Exception('Failed to fetch users from Firestore');
  }
}

/// Firestore에서 'likes' 컬렉션으로부터 사용자 아이디 목록을 가져오는 함수
Future<List<String>> _fetchLikedUserIds(FirebaseFirestore fireStore) async {
  final likesSnapshot = await fireStore
      .collection('likes')
      .orderBy('likedUsers', descending: true)
      .get();

  return likesSnapshot.docs
      .expand((doc) => List<String>.from(doc['likedUsers']))
      .toList();
}

/// Firestore에서 사용자 문서들을 가져오는 함수
Future<List<DocumentSnapshot>> _fetchUserDocs(
  FirebaseFirestore fireStore,
  List<String> likedUserIds,
) async {
  return await Future.wait(
    likedUserIds
        .map((userId) => fireStore.collection('users').doc(userId).get())
        .toList(),
  );
}

/// Firestore 문서 목록을 UserModel 객체로 매핑하는 함수
List<UserModel> _mapDocsToUsers(List<DocumentSnapshot> userDocs) {
  return userDocs.where((doc) => doc.exists).map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }).toList();
}

/// 사용자 데이터를 캐시에 저장하는 함수
Future<void> _cacheUsers(
  CacheService cacheService,
  CacheConfig cacheConfig,
  List<UserModel> users,
) async {
  try {
    final encodedData =
        json.encode(users.map((user) => user.toJson()).toList());
    await cacheService.cacheData(cacheConfig, encodedData);
  } catch (e) {
    throw Exception('Failed to save userinfo cache');
  }
}
