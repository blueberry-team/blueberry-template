import 'package:blueberry_flutter_template/feature/match/provider/MatchScreenProvider.dart';
import 'package:flutter/material.dart';
import '../../model/DogProfileModel.dart';
import '../../utils/AppTextStyle.dart';

class ProfileScreen extends StatelessWidget {
  final DogProfileModel dogProfile;

  const ProfileScreen({super.key, required this.dogProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 프로필 이미지
          Positioned.fill(
            child: Image.network(
              dogProfile.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // 프로필 사진 블러 효과
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        dogProfile.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
                  const SizedBox(height: 8),
                  Text(
                    '성별: ${dogProfile.gender}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    '종: ${dogProfile.breed}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    '지역: ${dogProfile.location}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '소개',
                    style: black16BoldTextStyle,
                  ),
                  Text(
                    dogProfile.bio,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // 뒤로 가기 버튼
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // 추천 안함 버튼
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.white),
              onPressed: () {
                _handleIgnoreProfile(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleIgnoreProfile(BuildContext context) async {
    const userId = "eztqDqrvEXDc8nqnnrB8"; // userId 임시로 하드 코딩
    await addPetToIgnored(userId, dogProfile.petID);
    if (context.mounted) {
      Navigator.of(context).pop(); // 화면을 닫음
    }
  }
}