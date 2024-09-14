import 'package:blueberry_flutter_template/feature/mypage/provider/MyPageSocialLoginCompany.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/AppStrings.dart';

class SocialCompanyTextWidget extends ConsumerWidget {
  const SocialCompanyTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socialCompany = ref.watch(myPageSocialLoginCompanyProvider);
    return socialCompany.when(
      data: (name) => Text(
        name,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      loading: () => const Text(''),
      error: (e, s) => const Text(AppStrings.nickNameTextWidgetError),
    );
  }
}
