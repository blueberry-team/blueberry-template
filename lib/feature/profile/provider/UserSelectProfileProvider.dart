import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userSelectProfileProvider = StateNotifierProvider<UserSelectProfileNotifier, AsyncValue<List<Image>>>((ref) {
  return UserSelectProfileNotifier();
});

class UserSelectProfileNotifier extends StateNotifier<AsyncValue<List<Image>>> {
  UserSelectProfileNotifier() : super(const AsyncValue.loading()) {
    fetchUserSelectProfiles();
  }

  Future<void> fetchUserSelectProfiles() async {
    try {
      List<String> userSelectProfileUrls = [];
      List<Image> userSelectProfiles = [];
      final FirebaseFirestore db = FirebaseFirestore.instance;
      CollectionReference profileImageCollection = db.collection('profileImages');
      QuerySnapshot snapshot = await profileImageCollection.get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('imageUrl')) {
          userSelectProfileUrls.add(data['imageUrl']);
        }
      }
      userSelectProfiles = userSelectProfileUrls.map((url) => Image.network(url)).toList();
      state = AsyncValue.data(userSelectProfiles);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final userSelectProfileIndexProvider = StateNotifierProvider<UserSelectProfileIndexNotifier, int>((ref) {
  return UserSelectProfileIndexNotifier();
});

class UserSelectProfileIndexNotifier extends StateNotifier<int> {
  UserSelectProfileIndexNotifier() : super(0);

  void updateUserSelectProfile(int profileImagesLength) {
    if(profileImagesLength==0){
      state = -1;
    }else{
      state = (state + 1) % profileImagesLength;
    }
  }
}
