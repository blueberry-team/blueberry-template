import 'package:blueberry_flutter_template/feature/signup/provider/SignUpDataProviders.dart';
import 'package:blueberry_flutter_template/services/FirebaseAuthServiceProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:blueberry_flutter_template/utils/ForbiddenPatterns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NickNameInputWidget extends ConsumerWidget {
  final VoidCallback onNext;

  const NickNameInputWidget({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(nicknameProvider.notifier);
    final formKey = GlobalKey<FormState>();
    final RegExp nickNameRegExp = RegExp(r'^[가-힣a-zA-Z0-9]{2,}$');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) => nickname.state = value,
              decoration: const InputDecoration(labelText: '닉네임 입력'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.errorMessage_emptyNickName;
                } else if (!nickNameRegExp.hasMatch(value)) {
                  return AppStrings.errorMessage_wrongNickName;
                }
                for (var patterns in forbiddenPatterns) {
                  if (patterns.hasMatch(value)) {
                    return AppStrings.errorMessage_forbiddenNickName;
                  }
                }
                return null;
              },
              // 특문 막는 정규식, 일부 금칙어 설정 해야함
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  if (formKey.currentState!.validate()) {
                    final user =
                        ref.watch(firebaseAuthServiceProvider).getCurrentUser();
                    user?.sendEmailVerification();
                    onNext();
                    print('okay');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
