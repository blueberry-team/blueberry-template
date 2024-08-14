import 'package:blueberry_flutter_template/feature/match/widget/OptionMenuWidget.dart';
import 'package:blueberry_flutter_template/feature/match/widget/ProfileInfoRowWidget.dart';
import 'package:flutter/material.dart';
import 'package:blueberry_flutter_template/feature/match/provider/MatchScreenProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/PetProfileModel.dart';
import '../../utils/AppStrings.dart';

class ProfileScreen extends ConsumerWidget {
  final PetProfileModel petProfile;

  const ProfileScreen({super.key, required this.petProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 펫 이미지
          Hero(
            tag: 'pet_image_${petProfile.petID}',
            child: Image.network(
              petProfile.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // 펫 이미지 블러 처리
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // 프로필 정보
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단 바
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      // 더보기 버튼(현재는 '다시 추천 안함' 기능만 있음)
                      OptionMenuWidget(
                        onOptionSelected: (String result) {
                          if (result == 'ignore') {
                            _handleIgnoreProfile(context, ref);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // 프로필 정보 카드
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            petProfile.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ],
                      ),
                      // 펫 정보
                      const SizedBox(height: 8),
                      ProfileInfoRowWidget(
                        icon: Icons.pets,
                        label: AppStrings.profileBreed,
                        value: petProfile.breed,
                      ),
                      ProfileInfoRowWidget(
                        icon: Icons.location_on,
                        label: AppStrings.profileLocation,
                        value: petProfile.location,
                      ),
                      ProfileInfoRowWidget(
                        icon: Icons.cake,
                        label: AppStrings.profileBio,
                        value: petProfile.bio,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        AppStrings.profileBio,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        petProfile.bio,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleIgnoreProfile(BuildContext context, WidgetRef ref) async {
    const userId = "eztqDqrvEXDc8nqnnrB8"; // 유저 ID 임시 데이터
    await ref
        .read(matchScreenProvider.notifier)
        .addPetToIgnored(userId, petProfile.petID);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
