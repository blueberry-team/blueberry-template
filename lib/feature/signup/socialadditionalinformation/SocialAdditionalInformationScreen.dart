import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final PageController _pageController = PageController();

class SocialSignupScreen extends StatefulWidget {
  static const String name = 'SocialSignupScreen';
  const SocialSignupScreen({super.key});

  @override
  State<SocialSignupScreen> createState() => _SocialSignupScreenState();
}

class _SocialSignupScreenState extends State<SocialSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => context.pop()),
        title: const Text('소셜 회원가입'),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [],
      ),
    );
  }
}
