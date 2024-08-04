import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/signup/PhoneNumberProvider.dart';
import '../../providers/signup/PhoneVerificationProvider.dart';
import '../../utils/AppStrings.dart';

class PhoneNumberInputWidget extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onDone;

  PhoneNumberInputWidget({
    super.key,
    required this.onNext,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _controller = TextEditingController();
    final phoneNumber = ref.watch(phoneNumberProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.text = ref.read(phoneNumberProvider);
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppStrings.inputPhoneNumber),
        const SizedBox(height: 20),
        TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: '전화번호',
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
              _showMessageDialog(
                  context, AppStrings.errorMessage_emptyPhoneNumber);
              return;
            }

            final completer = Completer<void>();

            ref
                .read(phoneVerificationProvider.notifier)
                .sendPhoneNumber(phoneNumber.state, completer);

            try {
              await completer.future;

              final state = ref.read(phoneVerificationProvider);
              if (state is CodeSent) {
                onNext();
              } else if (state is Verified) {
                onDone();
              }
            } catch (e) {
              _showMessageDialog(
                  context, AppStrings.errorMessage_invalidPhoneNumber);
            }
          },
          child: const Text('다음'),
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
