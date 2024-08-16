import 'package:blueberry_flutter_template/feature/user/provider/GetUserEmailProviderProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class EmailTextWidget extends ConsumerWidget {
  const EmailTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(getUserEmailProvider);
    return userEmail.when(
      data: (email) => Text( 
        email,
      ),
      loading: () => const Text(''),
      error: (e, s) => const Text(AppStrings.emailTextWidgetError),
    );
  }
}
