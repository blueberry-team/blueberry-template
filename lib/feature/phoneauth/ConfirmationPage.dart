import 'dart:async';

import 'package:blueberry_flutter_template/feature/signup/provider/SignUpDataProviders.dart';
import 'package:blueberry_flutter_template/services/FirebaseAuthServiceProvider.dart';
import 'package:blueberry_flutter_template/services/FirebaseService.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/TopScreen.dart';

final signUpProvider = FutureProvider((ref) async {
  // Simulate a network request with a 2-second delay
  await Future.delayed(const Duration(seconds: 2));
  return true;
});

class ConfirmationPage extends ConsumerWidget {
  final VoidCallback onNext;

  const ConfirmationPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    final name = ref.watch(nameProvider);
    final passwordConfirm = ref.watch(passwordConfirmProvider);
    final nickname = ref.watch(nicknameProvider);
    final isLoading = ref.watch(signUpProvider);
    final firebaseService = FirebaseService();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('이메일: $email'),
          const SizedBox(height: 20),
          Text('이름: $name'),
          const SizedBox(height: 20),
          Text('닉네임: $nickname'),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(value: true, onChanged: (value) {}),
              const Text('개인정보 처리방침에 동의합니다.'),
            ],
          ),
          Row(
            children: [
              Checkbox(value: true, onChanged: (value) {}),
              const Text('이용약관에 동의합니다.'),
            ],
          ),
          const SizedBox(height: 20),
          isLoading.when(
            data: (value) => ElevatedButton(
              onPressed: () async {
                await ref
                    .watch(firebaseAuthServiceProvider)
                    .signUpWithEmailPassword(email, passwordConfirm);
                // 오류 뱉어내는거 하나 만들어야함 ex ) ID or Password 형식에 문제가 있다라고 쏴야할듯 ?
                await firebaseService.upDateUserDB(email, name);
                FirebaseAnalytics.instance.logSignUp(signUpMethod: 'email');
                if (context.mounted) {
                  context.goNamed(TopScreen.name);
                }
              },
              child: const Text(AppStrings.signUpButtonText),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text('Error: $error'),
          ),
        ],
      ),
    );
  }
}
