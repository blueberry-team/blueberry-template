import 'package:blueberry_flutter_template/feature/mbti/MBTITestScreen.dart';
import 'package:blueberry_flutter_template/feature/mbti/provider/MBTIProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/AppColors.dart';
import '../../../utils/AppTextStyle.dart';
import 'MBTIShareDialogWidget.dart';

class MBTIHomeWidget extends ConsumerWidget {
  const MBTIHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(mbtiProvider);

    return userData.when(
      data: (userData) {
        final userName = userData.name;
        final mbti = MBTIType.fromString(userData.mbti);
        final imageState = ref.watch(mbtiImageProvider(mbti.name));

        return imageState.when(
          data: (imageUrl) {
            return _buildMBTIHomeWidgetView(
                context, ref, userName, mbti, imageUrl);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              Center(child: Text(style: black16TextStyle, 'Error: $error')),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          _buildMBTIHomeWidgetView(context, ref, '', MBTIType.NULL, ''),
    );
  }
}

Widget _buildMBTIHomeWidgetView(BuildContext context, WidgetRef ref,
    String userName, MBTIType mbti, String imageUrl) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    // MBTI 가 있으면 카드 모양 Decoration 제공 / 디자인 확정시 분리
    decoration: mbti != MBTIType.NULL
        ? (BoxDecoration(
            boxShadow: const [
                BoxShadow(
                    color: coolGray,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ],
            color: (MBTIType.toColor(mbti)),
            borderRadius: BorderRadius.circular(20)))
        // MBTI 없으면 null
        : null,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            textAlign: TextAlign.center,
            style: black24TextStyle,
            // mbti가 있으면 mbti 보여주기, 없으면 '검사해주세요'
            mbti != MBTIType.NULL
                ? '$userName${AppStrings.yourMBTI} ${mbti.name}'
                : AppStrings.pleaseCheckMBTI),
        imageUrl.isNotEmpty
            // imageUrl이 있으면 이미지를 표시
            ? Image.network(imageUrl, height: 300)
            // 네트워크 에러를 위한 로컬 이미지 사용 (mbti 디자인 완료시 변경)
            : Image.asset('assets/logo/mbti_logo.webp', height: 300),
        TextButton(
            onPressed: () => {
                  ref.read(mbtiTestProvider.notifier).initScore(),
                  context.goNamed(MBTITestScreen.name),
                },
            child: Text(
                style: black24TextStyle,
                // mbti가 없으면 검사하기, 있으면 재검사하기
                mbti != MBTIType.NULL
                    ? AppStrings.reCheckMBTI
                    : AppStrings.checkMBTI)),
        if (mbti != MBTIType.NULL)
          TextButton(
              onPressed: () => {
                    // 공유 Dialog 호출
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const MBTIShareDialogWidget();
                        })
                  },
              child: const Text(style: black24TextStyle, AppStrings.shareMBTI))
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

  static Color toColor(MBTIType mbti) {
    final mbtiColorList = [
      midnightGreen,
      softBlue,
      strongCyan,
      deepPurple,
      brightGreen,
      amber,
      midnightBlue,
      coolGray,
      pastelPurple,
      neonGreen,
      fireRed,
      blue,
      warmOrange,
      palePink,
      pastelPink,
      pastelGreen,
      richBlack
    ];
    return mbtiColorList[MBTIType.values.indexOf(mbti)];
  }
}

enum Extroversion { E, I }

enum Sensing { S, N }

enum Thinking { T, F }

enum Judging { J, P }
