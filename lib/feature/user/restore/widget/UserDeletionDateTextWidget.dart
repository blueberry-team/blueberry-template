import 'package:blueberry_flutter_template/feature/user/provider/GetUserDeletionDateProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class UserDeletionDateTextWidget extends ConsumerWidget {
  const UserDeletionDateTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDeletionDate = ref.watch(getUserDeletionDateProvider);
    return userDeletionDate.when(
      data: (date) => Text(
        date,
      ),
      loading: () => const Text(''),
      error: (e, s) => const Text(AppStrings.dateTextWidgetError),
    );
  }
}