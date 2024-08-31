import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/PetProfileModel.dart';
import '../../../utils/AppStrings.dart';
import '../provider/MatchProvider.dart';

class MatchFilterOptionWidget extends ConsumerWidget {
  final PetProfileModel petProfile;

  const MatchFilterOptionWidget({super.key, required this.petProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (String result) {
        if (result == 'ignore') {
          ref
              .read(matchScreenProvider.notifier)
              .handleIgnoreProfile(context: context, petProfile: petProfile);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'ignore',
          child: Row(
            children: [
              Icon(Icons.block, color: Colors.red[400], size: 16),
              const SizedBox(width: 8),
              const Text(
                AppStrings.ignoreThisPet,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14, // 글자 크기 줄이기
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
