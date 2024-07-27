import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileDetailProvider = StateNotifierProvider<ProfileDetailNotifier, int>((ref) {
  return ProfileDetailNotifier(0);
});

class ProfileDetailNotifier extends StateNotifier<int> {
  ProfileDetailNotifier(super.state);
}

Future<List<String>> fetchProfileImageUrls() async {
  List<String> imageUrls = [];

  final FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference profileImageCollection = db.collection('profileImages');

  QuerySnapshot snapshot = await profileImageCollection.get();
  for (QueryDocumentSnapshot doc in snapshot.docs) {
    var data = doc.data() as Map<String, dynamic>?; // Nullable 검사 및 타입 캐스팅
    if (data != null && data.containsKey('imageUrl')) {
      imageUrls.add(data['imageUrl']);
    }
  }
  return imageUrls;
}

final profileImageUrlsProvider = FutureProvider<List<String>>((ref) async {
  return await fetchProfileImageUrls();
});



