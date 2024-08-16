import 'package:blueberry_flutter_template/feature/user/provider/GetUserSignUpDataProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class UserSignUpTextWidget extends ConsumerWidget {
  const UserSignUpTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSignUpDate = ref.watch(getUserSignUpProvider);
    return userSignUpDate.when(
      data: (date) => Text(
        date,
      ),
      loading: () => const Text(''),
      error: (e, s) => const Text(AppStrings.dateTextWidgetError),
    );
  }
}
