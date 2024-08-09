import 'package:blueberry_flutter_template/feature/login/provider/UserInfoProvider.dart';
import 'package:blueberry_flutter_template/feature/mbti/MBTITestScreen.dart';
import 'package:blueberry_flutter_template/feature/mbti/provider/MBTIProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'MBTIShareDialogWidget.dart';

class MBTIHomeWidget extends ConsumerWidget {
  const MBTIHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(getUserDataProvider);

    return userData.when(
      data: (userData) {
        final userName = userData.name;
        final mbti = MBTIType.fromString(userData.mbti);
        final imageState = ref.watch(mbtiImageProvider(mbti.name));

        return imageState.when(
          data: (imageUrl) {
            return _buildMBTIWidgetView(context, ref, userName, mbti, imageUrl);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          _buildMBTIWidgetView(context, ref, '', MBTIType.NULL, ''),
    );
  }
}

Widget _buildMBTIWidgetView(BuildContext context, WidgetRef ref,
    String userName, MBTIType mbti, String imageUrl) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
            // mbti가 없으면 mbti 보여주기, 있으면 '검사해주세요'
            mbti != MBTIType.NULL
                ? '$userName${AppStrings.yourMBTI} ${mbti.name}'
                : AppStrings.pleaseCheckMBTI),
        imageUrl.isNotEmpty
            ? Image.network(imageUrl, height: 300) // imageUrl이 있으면 이미지를 표시
            : const Text(AppStrings.pleaseLogin),
        TextButton(
            onPressed: () => {
                  ref.read(mbtiProvider.notifier).initScore(),
                  context.goNamed(MBTITestScreen.name),
                },
            child: Text(
                style: const TextStyle(fontSize: 24),
                // mbti가 없으면 검사하기, 있으면 재검사하기
                mbti != MBTIType.NULL
                    ? AppStrings.reCheckMBTI
                    : AppStrings.checkMBTI)),
        if (mbti != MBTIType.NULL)
          TextButton(
              onPressed: () => {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const MBTIShareDialogWidget();
                        })
                  },
              child: const Text(
                  style: TextStyle(fontSize: 24), AppStrings.shareMBTI))
      ],
    ),
  );
}

enum MBTIType {
  INFP,
  INFJ,
  INTP,
  INTJ,
  ISFP,
  ISFJ,
  ISTP,
  ISTJ,
  ENFP,
  ENFJ,
  ENTP,
  ENTJ,
  ESFP,
  ESFJ,
  ESTP,
  ESTJ,
  NULL;

  static MBTIType fromString(String mbti) {
    return MBTIType.values.firstWhere(
      (type) => type.name.toUpperCase() == mbti.toUpperCase(),
      orElse: () => MBTIType.NULL,
    );
  }
}

enum Extroversion { E, I }

enum Sensing { S, N }

enum Thinking { T, F }

enum Judging { J, P }
