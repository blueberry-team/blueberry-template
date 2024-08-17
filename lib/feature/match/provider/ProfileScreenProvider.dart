import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_flutter_template/model/PetProfileModel.dart';
import 'package:blueberry_flutter_template/feature/match/provider/MatchScreenProvider.dart';

class ProfileScreenNotifier extends StateNotifier<void> {
  ProfileScreenNotifier(this.ref) : super(null);

  final Ref ref;

  Future<void> handleIgnoreProfile({
    required BuildContext context,
    required PetProfileModel petProfile,
  }) async {
    await ref.read(matchScreenProvider.notifier).addPetToIgnored(MatchScreenNotifier.userId, petProfile.petID);
    if (context.mounted) {
      Navigator.of(context).pop(); // 프로필 화면 닫기
    }
  }
}

final profileScreenProvider = StateNotifierProvider<ProfileScreenNotifier, void>((ref) {
  return ProfileScreenNotifier(ref);
});