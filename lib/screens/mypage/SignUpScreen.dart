import 'package:blueberry_flutter_template/widgets/signup/EmailDuplicateWidget.dart';
import 'package:blueberry_flutter_template/widgets/signup/EmailVerifyWidget.dart';
import 'package:blueberry_flutter_template/widgets/signup/NameInputWidget.dart';
import 'package:blueberry_flutter_template/widgets/signup/NickNameInputWidget.dart';
import 'package:blueberry_flutter_template/widgets/signup/PasswordConfirmWidget.dart';
import 'package:blueberry_flutter_template/widgets/signup/PasswordInputWidget.dart';
import 'package:blueberry_flutter_template/widgets/signup/PrivacyPolicyWidget.dart';
import 'package:blueberry_flutter_template/widgets/signup/TermsOfServiceWidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'signup/ConfirmationPage.dart';

final PageController _pageController = PageController();

class SignUpScreen extends StatefulWidget {
  static const String name = 'SignUpScreen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => context.pop()),
        title: const Text('회원가입'),
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
          EmailVerifyPage(
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
          NameInputWidget(),
          NickNameInputWidget(onNext: onNext),
        ],
      ),
    );
  }
}

class EmailVerifyPage extends StatelessWidget {
  final VoidCallback onNext;

  const EmailVerifyPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return EmailVerifyWidget(onNext: onNext);
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
