import 'package:blueberry_flutter_template/providers/SignUpDataProviders.dart';
import 'package:blueberry_flutter_template/providers/user/FirebaseAuthServiceProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NickNameInputWidget extends ConsumerWidget {
  final VoidCallback onNext;

  const NickNameInputWidget({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(nicknameProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) => nickname.state = value,
            decoration: const InputDecoration(labelText: '닉네임 입력'),
            // 특문 막는 정규식, 일부 금칙어 설정 해야함
          ),
          ElevatedButton(
            onPressed: () {
              try {
                final user = ref.watch(firebaseAuthServiceProvider).getCurrentUser();
                user?.sendEmailVerification();
                onNext();
              } catch (e) {
                print(e);
              }
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}