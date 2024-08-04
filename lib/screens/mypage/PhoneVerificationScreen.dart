import 'package:blueberry_flutter_template/screens/mypage/signup/PhoneVerificationPage.dart';
import 'package:flutter/material.dart';

final PageController _pageController = PageController();

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          PhoneNumberInputPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            onDone: () => _pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          VerificationCodeInputPage(
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            onPrev: () => _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          PhoneVerificationDonePage(
            onNext: () {},
          ),
        ],
      ),
    );
  }
}
