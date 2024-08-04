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
            title: const Text('MBTI Test'),
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
        ));
  }
}
