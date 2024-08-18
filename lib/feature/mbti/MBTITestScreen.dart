import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widget/MBTITestWidget.dart';

class MBTITestScreen extends StatelessWidget {
  static const String name = 'MBTITestScreen';

  const MBTITestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(AppStrings.titleMBTITest),
          leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: MBTITestWidget()),
          ],
        ),
      ),
    );
  }
}
