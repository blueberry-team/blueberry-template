import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ImageImporter.dart';

class ProfilePicVerificationScreen extends ConsumerWidget {
  const ProfilePicVerificationScreen({super.key});
  static const name = 'ProfilePicVerificationScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageFile = ref.watch(imageFileProvider);

    // 승인 여부
    const bool isAuthorized = false; // true면 승인, false면 미승인

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 사진 페이지'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double squareSize = constraints.maxWidth * 0.8;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  width: squareSize,
                  height: squareSize,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 4.0,
                    ),
                  ),
                  child: imageFile != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Stack(
                      children: [
                        Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                          width: squareSize,
                          height: squareSize,
                          color: isAuthorized
                              ? null
                              : Colors.black.withOpacity(0.6),
                          colorBlendMode:
                          isAuthorized ? null : BlendMode.darken,
                        ),
                        if (!isAuthorized)
                          Center(
                            child: Text(
                              '승인 대기 중입니다 \n조금만 기다려주세요',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                backgroundColor:
                                Colors.black.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  )
                      : const Center(
                    child: Icon(
                      Icons.pets,
                      size: 200,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _showImageSourceActionSheet(context, ref);
                  },
                  child: const Text(
                    '사진 수정',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 선택'),
                onTap: () async {
                  final file = await ref
                      .read(imageFileProvider.notifier)
                      .pickImageFromGallery(context);  // 선택된 파일 캡처
                  Navigator.of(context).pop();
                  if (file != null) {
                    _showImageConfirmationDialog(context, file, ref);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('카메라로 찍기'),
                onTap: () async {
                  final file = await ref
                      .read(imageFileProvider.notifier)
                      .pickImageFromCamera(context);  // 선택된 파일 캡처
                  Navigator.of(context).pop();
                  if (file != null) {
                    _showImageConfirmationDialog(context, file, ref);
                  }
                },
              ),
              if (ref.read(imageFileProvider) != null)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('사진 삭제'),
                  onTap: () {
                    ref.read(imageFileProvider.notifier).clearImage();
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _showImageConfirmationDialog(
      BuildContext context, File imageFile, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(
                imageFile,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '이 사진을 사용하시겠습니까?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ref.read(imageFileProvider.notifier).clearImage();
                    },
                    child: Text('다시 선택'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ref.read(imageFileProvider.notifier).state = imageFile;
                    },
                    child: Text('사용'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}