import 'package:blueberry_flutter_template/feature/mbti/widget/MBTIHomeWidget.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';

class MBTIScreen extends StatelessWidget {
  static const String name = 'mbtiScreen';

  const MBTIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleMBTI)),
      body: const Center(
        child: Expanded(child: MBTIHomeWidget()),
      ),
    );
  }
}
