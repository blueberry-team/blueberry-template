import 'package:blueberry_flutter_template/feature/user/provider/GetUserDeletionRequestDateProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class UserDeletionRequestDateTextWidget extends ConsumerWidget {
  const UserDeletionRequestDateTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDeletionRequestDate =
        ref.watch(getUserDeletionRequestDateProvider);
    return userDeletionRequestDate.when(
      data: (date) => Text(
        date,
      ),
      loading: () => const Text(''),
      error: (e, s) => const Text(AppStrings.dateTextWidgetError),
    );
  }
}
