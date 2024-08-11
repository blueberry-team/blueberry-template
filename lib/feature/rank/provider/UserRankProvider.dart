import 'dart:convert';

import 'package:blueberry_flutter_template/model/UserModel.dart';
import 'package:blueberry_flutter_template/services/cache/CacheService.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = FutureProvider<List<UserModel>>((ref) async {
  final cacheService = CacheService.instance;

  // 한국 시간으로 매일 오전 9시 설정
  final now = DateTime.now().toUtc().add(const Duration(hours: 9));
  final tomorrowMorning = DateTime(now.year, now.month, now.day + 1, 9).toUtc();

  // 캐시 정책 설정
  final cacheConfig = CacheConfig(
    cacheKey: AppStrings.userCacheKey,
    expiryTime: tomorrowMorning, // 다음 날 오전 9시까지 유효
  );

  try {
    // 캐시된 데이터 가져오기
    final cachedUsers = await _getCachedUsers(cacheService, cacheConfig);
    if (cachedUsers != null) return cachedUsers;

    // Firestore에서 데이터 가져오기
    final users = await _fetchUsersFromFirestore();

    // 캐시에 저장
    await _cacheUsers(cacheService, cacheConfig, users);

    return users;
  } catch (e) {
    throw Exception('Failed to load users');
  }
});

Future<List<UserModel>?> _getCachedUsers(
    CacheService cacheService, CacheConfig cacheConfig) async {
  try {
    final cachedData = await cacheService.getCachedData(cacheConfig);
    if (cachedData != null) {
      final cachedUsers = (json.decode(cachedData) as List<dynamic>)
          .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return cachedUsers;
    }
  } catch (e) {
    throw Exception('Failed to fetch user cached data');
  }
  return null;
}

Future<List<UserModel>> _fetchUsersFromFirestore() async {
  try {
    final fireStore = FirebaseFirestore.instance;

    final likesSnapshot = await fireStore
        .collection('likes')
        .orderBy('likedUsers', descending: true)
        .get();

    final likedUserIds = likesSnapshot.docs
        .expand((doc) => List<String>.from(doc['likedUsers']))
        .toList();

    final userDocs = await Future.wait(
      likedUserIds
          .map((userId) => fireStore.collection('users').doc(userId).get())
          .toList(),
    );

    final users = userDocs.map((doc) {
      if (doc.exists) {
        final data = doc.data()!;
        return UserModel(
          userClass: data['userClass'] as String,
          userId: doc.id,
          name: data['name'] as String,
          email: data['email'] as String,
          age: data['age'] as int,
          isMemberShip: data['isMemberShip'] as bool,
          profileImageUrl: data['profilePicture'] as String?,
          createdAt: DateTime.parse(data['createdAt'] as String),
          fcmToken: data['fcmToken'] as String?,
          likeGivens: data["likeGivens"] as List<String>,
        );
      } else {
        throw Exception('User not found');
      }
    }).toList();

    return users;
  } catch (e) {
    throw Exception('Failed to fetch users from Firestore');
  }
}

Future<void> _cacheUsers(CacheService cacheService, CacheConfig cacheConfig,
    List<UserModel> users) async {
  try {
    final encodedData =
        json.encode(users.map((user) => user.toJson()).toList());
    await cacheService.cacheData(cacheConfig, encodedData);
  } catch (e) {
    throw Exception('Failed to save userinfo cache');
  }
}
