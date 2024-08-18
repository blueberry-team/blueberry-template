import 'package:blueberry_flutter_template/feature/signup/widget/EmailDuplicateWidget.dart';
import 'package:blueberry_flutter_template/feature/signup/widget/EmailVerifyWidget.dart';
import 'package:blueberry_flutter_template/feature/signup/widget/NameInputWidget.dart';
import 'package:blueberry_flutter_template/feature/signup/widget/NickNameInputWidget.dart';
import 'package:blueberry_flutter_template/feature/signup/widget/PasswordConfirmWidget.dart';
import 'package:blueberry_flutter_template/feature/signup/widget/PasswordInputWidget.dart';
import 'package:blueberry_flutter_template/feature/signup/widget/PrivacyPolicyWidget.dart';
import 'package:blueberry_flutter_template/feature/signup/widget/TermsOfServiceWidget.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../phoneauth/ConfirmationPage.dart';

final PageController _pageController = PageController();

class SignUpScreen extends ConsumerStatefulWidget {
  static const String name = 'SignUpScreen';

  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => context.pop()),
        title: const Text(AppStrings.signUpPageTitle),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          EmailInputPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          EmailVerification(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          PasswordInputPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          PasswordConfirmPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          NameNickNameInputPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          TermsOfServicePage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          PrivacyPolicyPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          ConfirmationPage(
            onNext: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class EmailInputPage extends StatelessWidget {
  final VoidCallback onNext;

  const EmailInputPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return EmailDuplicateWidget(onNext: onNext);
  }
}

class EmailVerification extends StatelessWidget {
  final VoidCallback onNext;

  const EmailVerification({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return EmailVerifyWidget(onNext: onNext);
  }
}

class PasswordInputPage extends StatelessWidget {
  final VoidCallback onNext;

  const PasswordInputPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return PasswordInputWidget(onNext: onNext);
  }
}

class PasswordConfirmPage extends StatelessWidget {
  final VoidCallback onNext;

  const PasswordConfirmPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return PasswordConfirmWidget(onNext: onNext);
  }
}

class NameNickNameInputPage extends StatelessWidget {
  final VoidCallback onNext;

  const NameNickNameInputPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const NameInputWidget(),
          NickNameInputWidget(onNext: onNext),
        ],
      ),
    );
  }
}

class TermsOfServicePage extends StatelessWidget {
  final VoidCallback onNext;

  const TermsOfServicePage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return TermsOfServiceWidget(onNext: onNext);
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  final VoidCallback onNext;

  const PrivacyPolicyPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return PrivacyPolicyWidget(onNext: onNext);
  }
}
