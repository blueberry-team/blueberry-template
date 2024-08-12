import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../../../utils/AppStrings.dart';
import '../../phoneauth/provider/PhoneVerificationProvider.dart';
import '../../phoneauth/provider/VerificationCodeProvider.dart';

class VerificationCodeInputWidget extends ConsumerWidget {
  final FocusNode focusNode;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final int length;

  const VerificationCodeInputWidget({
    super.key,
    required this.focusNode,
    required this.onNext,
    required this.onPrev,
    this.length = 6,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationCode = ref.watch(verificationCodeProvider.notifier);
    final phoneVerification = ref.watch(phoneVerificationProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppStrings.inputVerificationCode),
        const SizedBox(
          height: 20,
        ),
        Pinput(
          enabled: phoneVerification is TimeOut ? false : true,
          focusNode: focusNode,
          autofocus: true,
          showCursor: true,
          length: length,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) => verificationCode.state = value,
        ),
        phoneVerification is TimeOut
            ? const Text(
                AppStrings.errorMessage_timeOut,
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            : Container(),
        const SizedBox(
          height: 20,
        ),
        phoneVerification is TimeOut
            ? ElevatedButton(
                onPressed: () {
                  ref.read(phoneVerificationProvider.notifier).reset();
                  onPrev();
                },
                child: const Text('재시도'),
              )
            : ElevatedButton(
                onPressed: () async {
                  if (verificationCode.state.isEmpty) {
                    _showMessageDialog(
                        context, AppStrings.errorMessage_emptyVerificationCode);
                    return;
                  }

                  final completer = Completer<void>();

                  ref
                      .read(phoneVerificationProvider.notifier)
                      .verifyCode(verificationCode.state, completer);

                  try {
                    await completer.future;

                    final state = ref.read(phoneVerificationProvider);
                    if (state is Verified) {
                      onNext();
                    } else {
                      _showMessageDialog(
                          context, AppStrings.errorMessage_commonError);
                    }
                  } catch (e) {
                    _showMessageDialog(context,
                        AppStrings.errorMessage_invalidVerificationCode);
                    FocusScope.of(context).requestFocus(focusNode);
                  }
                },
                child: const Text('확인'),
              ),
      ],
    );
  }
}

void _showMessageDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(message),
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
}
