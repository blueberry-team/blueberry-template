import 'dart:io';

import 'package:blueberry_flutter_template/feature/camera/provider/PageProvider.dart';
import 'package:blueberry_flutter_template/feature/camera/provider/fireStorageServiceProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/FirebaseStoreServiceProvider.dart';

class SharePostScreen extends ConsumerWidget {
  final File imageFile;

  const SharePostScreen(this.imageFile, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.read(fireStorageServiceProvider);
    final fireStorage = ref.read(firebaseStoreServiceProvider);
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final pageNotifier = ref.watch(pageProvider.notifier);

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
                  var imageUrl = '';

                  imageFile.readAsBytes().then((value) async {
                    imageUrl = await storage.uploadImageFromApp(
                        File(imageFile.path), ImageType.profileimage,
                        fixedFileName: userId);
                    fireStorage.createProfileIamge(userId, imageUrl);
                    pageNotifier.moveToPage(0);
                  });
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
