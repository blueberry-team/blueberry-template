import 'package:blueberry_flutter_template/feature/signup/provider/SignUpDataProviders.dart';
import 'package:blueberry_flutter_template/services/verifications/EmailVerificationService.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerifyWidget extends ConsumerWidget {
  final VoidCallback onNext;
  EmailVerifyWidget({super.key, required this.onNext});

  final TextEditingController _codeController = TextEditingController();
  final EmailVerificationService emailVerificationService =
      EmailVerificationService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RegExp codeRegExp = RegExp(r'^[0-9]{5}$');
    final formKey = GlobalKey<FormState>();
    final email = ref.watch(emailProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$email 이메일로 전송된 인증번호를 입력해주세요.'),
          const SizedBox(height: 10),
          Form(
            key: formKey,
            child: TextFormField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: AppStrings.verifyCode),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.errorMessage_emptyVerifyCode;
                } else if (!codeRegExp.hasMatch(value)) {
                  return AppStrings.errorMessage_wrongVerifyCode;
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                await emailVerificationService.verifyCode(
                    email, _codeController.text, onNext);
              },
              child: const Text(AppStrings.checkVerifyCode)),
        ],
      ),
    );
  }
}
