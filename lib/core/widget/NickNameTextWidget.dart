import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../feature/mypage/provider/MyPageNameProvider.dart';
import '../../utils/AppStrings.dart';

class NickNameTextWidget extends ConsumerWidget {
  const NickNameTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(myPageNicknameProvider);
    return nickname.when(
      data: (name) => Text(
        name,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      loading: () => const Text(''),
      error: (e, s) => const Text(AppStrings.nickNameTextWidgetError),
    );
  }
}