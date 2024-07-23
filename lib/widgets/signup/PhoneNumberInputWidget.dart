import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/signup/PhoneNumberProvider.dart';
import '../../providers/signup/PhoneVerificationProvider.dart';
import '../../utils/AppStrings.dart';

class PhoneNumberInputWidget extends ConsumerWidget {
  final VoidCallback onNext;
  final TextEditingController _controller = TextEditingController(text: '');

  PhoneNumberInputWidget({super.key, required this.onNext});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(phoneNumberProvider.notifier);
    final phoneVerification = ref.watch(phoneVerificationProvider.notifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: '휴대폰 번호',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          maxLength: 11,
          buildCounter: (context,
              {required currentLength,
                required isFocused,
                required maxLength}) =>
          null,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          onChanged: (value) => phoneNumber.state = value,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            if (phoneNumber.state.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content:
                    const Text(AppStrings.errorMessage_emptyPhoneNumber),
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

            final result = await phoneVerification
                .sendVerificationRequest(phoneNumber.state);

            // 전화번호 입력 성공/실패 처리
            if (result) {
              onNext();
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content:
                    const Text(AppStrings.errorMessage_invalidPhoneNumber),
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
          },
          child: const Text('다음'),
        ),
      ],
    );
  }
}