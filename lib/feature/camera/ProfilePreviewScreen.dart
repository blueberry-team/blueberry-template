import 'dart:io';
import 'package:blueberry_flutter_template/feature/camera/provider/fireStorageServiceProvider.dart';
import 'package:blueberry_flutter_template/feature/camera/widget/CircularProfileImagePreviewWidget.dart';
import 'package:blueberry_flutter_template/feature/mypage/MyPageScreen.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../services/FirebaseStoreServiceProvider.dart';

class ProfilePreviewScreen extends ConsumerWidget {
  final File imageFile;

  const ProfilePreviewScreen(this.imageFile, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.read(fireStorageServiceProvider);
    final fireStorage = ref.read(firebaseStoreServiceProvider);
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.previewProfilePhoto),
      ),
      body: Center(
        child: Column(
          children: [
            CircularProfileImagePreviewWidget(imageFile: imageFile),
            makeProfileImageBtn(storage, userId, fireStorage, context),
          ],
        ),
      ),
    );
  }

  TextButton makeProfileImageBtn(FirebaseStorageService storage, String userId,
      FirestoreService fireStorage, BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          final imageUrl = await storage.uploadImageFromApp(
              imageFile, ImageType.profileimage,
              fixedFileName: userId);

          // 프로필 이미지 생성
          fireStorage.createProfileIamge(userId, imageUrl);

          // 페이지 이동
          context.goNamed(MyPageScreen.name);
        } catch (e) {
          talker.error('이미지 저장에 실패했습니다. 다시 시도해주세요.');
        }
      },
      child: const Text(AppStrings.savePhoto),
    );
  }
}
