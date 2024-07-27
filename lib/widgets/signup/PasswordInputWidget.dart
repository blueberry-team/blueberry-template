import 'package:blueberry_flutter_template/providers/SignUpDataProviders.dart';
import 'package:blueberry_flutter_template/providers/user/FirebaseAuthServiceProvider.dart';
import 'package:blueberry_flutter_template/screens/mypage/SignUpScreen.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PasswordInputWidget extends ConsumerWidget {
  final VoidCallback onNext;

  const PasswordInputWidget({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = ref.watch(passwordProvider.notifier);
    final RegExp passwordRegExp = RegExp(r'^(?=.*[!@#\$&*~])(?=.*[!@#\$&*~]).{8,}$');
    final formKey = GlobalKey<FormState>();


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) => password.state = value,
              decoration: const InputDecoration(labelText: '비밀번호 입력'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.errorMessage_emptyPassword;
                } else if (!passwordRegExp.hasMatch(value)) {
                  return AppStrings.errorMessage_regexpPassword;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                if (formKey.currentState?.validate() ?? false) {
                  onNext();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(AppStrings.errorMessage_checkPassword)),
                  );
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