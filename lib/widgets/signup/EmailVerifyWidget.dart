import 'package:blueberry_flutter_template/providers/user/FirebaseAuthServiceProvider.dart';
import 'package:blueberry_flutter_template/screens/mypage/MyPageScreen.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerifyWidget extends ConsumerWidget {
  final VoidCallback onNext;
  const EmailVerifyWidget({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(AppStrings.send_emailVerification),
          const Text(AppStrings.check_emailVerification),
          ElevatedButton(
              onPressed: () async {
                try{
                  final verifierUser = ref.watch(firebaseAuthServiceProvider).getCurrentUser();
                  if (verifierUser != null) {
                    await verifierUser.reload();
                    final reloadedUser = ref.watch(firebaseAuthServiceProvider).getCurrentUser();
                    if (reloadedUser?.emailVerified == true) {
                      onNext();
                    } else {
                      await reloadedUser?.sendEmailVerification();
                    }
                  }
                } catch(e) {
                  print(e);
                }
              },
              child: const Text(AppStrings.click_emailVerification)
          )
        ],
      ),
    );
  }
}
