import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../../providers/signup/PhoneVerificationProvider.dart';
import '../../providers/signup/VerificationCodeProvider.dart';
import '../../utils/AppStrings.dart';

class VerificationCodeInputWidget extends ConsumerWidget {
  final FocusNode focusNode;
  final VoidCallback onNext;
  final int length;

  const VerificationCodeInputWidget({
    super.key,
    required this.focusNode,
    required this.onNext,
    this.length = 6,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationCode = ref.watch(verificationCodeProvider.notifier);
    final phoneVerification = ref.watch(phoneVerificationProvider.notifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Pinput(
          focusNode: focusNode,
          autofocus: true,
          showCursor: true,
          length: length,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) => verificationCode.state = value,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            // 인증번호 미입력
            if (verificationCode.state.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text(
                        AppStrings.errorMessage_emptyVerificationCode),
                    actions: [
                      TextButton(
                        child: const Text('확인'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              return;
            }

            final result =
                await phoneVerification.checkVerificationCode(verificationCode.state);

            //인증 성공/실패 처리
            if (result) {
              onNext();
            } else {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text(
                        AppStrings.errorMessage_invalidVerificationCode),
                    actions: [
                      TextButton(
                        child: const Text('확인'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              FocusScope.of(context).requestFocus(focusNode);
            }
          },
          child: const Text('확인'),
        ),
      ],
    );
  }
}
