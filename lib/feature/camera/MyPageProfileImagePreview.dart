import 'dart:io';

import 'package:blueberry_flutter_template/feature/camera/provider/PageProvider.dart';
import 'package:blueberry_flutter_template/feature/camera/provider/fireStorageServiceProvider.dart';
import 'package:blueberry_flutter_template/feature/mypage/MyPageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../services/FirebaseStoreServiceProvider.dart';

class SharePostScreen extends ConsumerWidget {
  final File imageFile;

  const SharePostScreen(this.imageFile, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.read(fireStorageServiceProvider);
    final fireStorage = ref.read(firebaseStoreServiceProvider);
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 이미지 편집'),
      ),
      body: Center(
        child: Column(
          children: [
            ClipOval(
              child: Image.file(
                imageFile,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final imageUrl = await storage.uploadImageFromApp(
                      imageFile,
                      ImageType.profileimage,
                      fixedFileName: userId
                  );

                  // 프로필 이미지 생성
                  fireStorage.createProfileIamge(userId, imageUrl);

                  // 페이지 이동
                  context.goNamed(MyPageScreen.name);
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('이미지 저장 하기'),
            ),
          ],
        ),
      ),
    );
  }
}
