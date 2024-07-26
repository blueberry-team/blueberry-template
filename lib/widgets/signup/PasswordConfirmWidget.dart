import 'package:blueberry_flutter_template/providers/SignUpDataProviders.dart';
import 'package:blueberry_flutter_template/providers/user/FirebaseAuthServiceProvider.dart';
import 'package:blueberry_flutter_template/screens/mypage/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/AppStrings.dart';

class PasswordConfirmWidget extends ConsumerWidget {
  final VoidCallback onNext;

  const PasswordConfirmWidget({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);
    final passwordConfirm = ref.watch(passwordConfirmProvider.notifier);
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) => passwordConfirm.state = value,
              obscureText: true,
              decoration: const InputDecoration(labelText: '비밀번호 확인'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.errorMessage_emptyPassword;
                } else if (password != value) {
                  return AppStrings.errorMessage_duplicatedPassword;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.watch(firebaseAuthServiceProvider).signUpWithEmailPassword(email, passwordConfirm.state);
                  // 오류 뱉어내는거 하나 만들어야함 ex ) ID or Password 형식에 문제가 있다라고 쏴야할듯 ?
                  onNext();
                } catch(e) {
                  print('failed signUp $e');
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