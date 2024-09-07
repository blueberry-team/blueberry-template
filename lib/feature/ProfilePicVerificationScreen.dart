import 'dart:io';
import 'package:blueberry_flutter_template/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ImageImporter.dart';
import 'ImageGalleryScreen.dart';

class ProfilePicVerificationScreen extends ConsumerStatefulWidget {
  const ProfilePicVerificationScreen({super.key});
  static const name = 'ProfilePicVerificationScreen';

  @override
  ConsumerState<ProfilePicVerificationScreen> createState() => _ProfilePicVerificationScreenState();
}

class _ProfilePicVerificationScreenState extends ConsumerState<ProfilePicVerificationScreen> {
  bool isAuthorized = false;  // 승인 여부 데이터

  @override
  Widget build(BuildContext context) {
    final imageFile = ref.watch(imageFileProvider);  // 선택된 사진 파일 watch

    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: const Text('프로필 사진 페이지'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProfileImage(imageFile),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 10),
              onPressed: () {
                _showImageSourceActionSheet(context);
              },
              child: const Text(
                '댕댕이 사진 고르기',
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(File? imageFile) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.brown.shade400,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.brown.shade200, width: 4.0),
      ),
      child: imageFile != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: [
            Image.file(
              imageFile,
              fit: BoxFit.cover,
              width: 400,
              height: 400,
              color: isAuthorized ? null : Colors.black.withOpacity(0.5),  // 미승인 사진에 대해 블러 처리
              colorBlendMode: isAuthorized ? null : BlendMode.darken,
            ),
            if (!isAuthorized)
              Center(
                child: Text(
                  '승인 대기 중입니다\n잠시만 기다려주세요',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      )
          : Center(
        child: Icon(
          Icons.pets,
          size: 200,
          color: Colors.brown.shade100,
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                tileColor: Colors.grey[250],
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 선택'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showImageGallery(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showImageGallery(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageGalleryScreen(ref: ref),
      ),
    );
  }
}