import 'package:blueberry_flutter_template/feature/mbti/provider/MBTIProvider.dart';
import 'package:blueberry_flutter_template/feature/mbti/widget/MBTIHomeWidget.dart';
import 'package:blueberry_flutter_template/utils/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/AppStrings.dart';
import '../../../utils/DialogHelpers.dart';

class MBTIResultWidget extends ConsumerWidget {
  final MBTIType mbtiResult;

  const MBTIResultWidget({super.key, required this.mbtiResult});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mbtiImage = ref.watch(mbtiImageProvider(mbtiResult.name));

    return mbtiImage.when(
        data: (imageUrl) {
          return _buildWidget(context, ref, mbtiResult, imageUrl);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')));
  }
}

Widget _buildWidget(
    BuildContext context, WidgetRef ref, MBTIType mbtiResult, String imageUrl) {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final userState = ref.read(mbtiTestProvider.notifier);

  return Center(
      child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: coolGray,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ],
              color: (MBTIType.toColor(mbtiResult)),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${AppStrings.petMBTI} ${mbtiResult.name}'),
              imageUrl.isNotEmpty
                  ? Image.network(imageUrl, height: 300)
                  : const Text(AppStrings.errorTitle),
              if (userId != null)
                TextButton(
                    onPressed: () => {
                          userState
                              .updateMBTI(
                                  userId: userId, mbtiResult: mbtiResult)
                              .whenComplete(() => showSuccessDialog(
                                  context, AppStrings.setCompleteMBTI))
                              .catchError((error) => showErrorDialog(
                                  context, AppStrings.setErrorMBTI)),
                        },
                    child: const Text(AppStrings.setMBTI))
              else
                const Text(AppStrings.pleaseLogin),
              TextButton(
                  onPressed: () => {context.pop()},
                  child: const Text(AppStrings.okButtonText)),
            ],
          )));
}
