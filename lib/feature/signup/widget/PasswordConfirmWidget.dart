import 'package:blueberry_flutter_template/feature/signup/provider/SignUpDataProviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/AppStrings.dart';

class PasswordConfirmWidget extends ConsumerWidget {
  final VoidCallback onNext;

  const PasswordConfirmWidget({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = ref.watch(passwordProvider);
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
              decoration: const InputDecoration(labelText: AppStrings.passwordInputLabel),
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
                  onNext();
                } catch (e) {
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
