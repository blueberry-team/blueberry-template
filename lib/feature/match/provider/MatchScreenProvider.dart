import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../model/PetProfileModel.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import '../../../utils/AppStrings.dart';

class MatchScreenNotifier extends StateNotifier<List<PetProfileModel>> {
  MatchScreenNotifier() : super([]) {
    loadPets();
  }

  Future<void> loadPets({String? location, String? gender}) async {
    const userId = "eztqDqrvEXDc8nqnnrB8"; // 사용자의 userId (임시로 하드코딩)
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users_test').doc(userId).get();

    List<dynamic> ignoredPets = [];
    if (userDoc.exists) {
      ignoredPets = userDoc.data()?['ignoredPets'] ?? [];
    }

    try {
      final snapshot = await firestore.collection('pet').get();
      final pets = snapshot.docs.map((doc) => PetProfileModel.fromJson(doc.data())).toList();

      // Apply filters
      List<PetProfileModel> filteredPets = pets.where((pet) {
        final matchesLocation = location == null || pet.location == location;
        final matchesGender = gender == null || pet.gender == gender;
        final notIgnored = !ignoredPets.contains(pet.petID);
        return matchesLocation && matchesGender && notIgnored;
      }).toList();

      state = filteredPets;
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

        if (!ignoredPets.contains(petId)) {
          ignoredPets.add(petId);
          await userDoc.update({
            'ignoredPets': ignoredPets,
          });
          talker.info("${AppStrings.dbUpdateSuccess}: $ignoredPets");

          loadPets(); // Reload pets with the updated ignored list
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

final matchScreenProvider = StateNotifierProvider<MatchScreenNotifier, List<PetProfileModel>>(
      (ref) => MatchScreenNotifier(),
);
