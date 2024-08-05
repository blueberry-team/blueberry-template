import 'package:blueberry_flutter_template/core/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widget/CustomFab.dart';
import '../mbti/MBTITestScreen.dart';
import 'widget/FriendsListWidget.dart';

class FriendsListScreen extends StatelessWidget {
  const FriendsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: FriendsListWidget()),
          ],
        ),
      ),
      floatingActionButton: buildCustomFAB(context),
    );
  }
}

CustomFab buildCustomFAB(BuildContext context) {
  return CustomFab(
    mainColor: Colors.blue,
    mainIcon: Icons.add,
    fabButtons: [
      FabButton(
        icon: Icons.accessibility_sharp,
        label: 'MBTI',
        onPressed: () {
          context.goNamed(MBTITestScreen.name);
        },
        color: Colors.orange,
      ),
      FabButton(
        icon: Icons.message,
        label: 'Message',
        onPressed: () {
          print('Message button pressed');
        },
        color: Colors.green,
      ),
      FabButton(
        icon: Icons.settings,
        label: 'Settings',
        onPressed: () {
          print('Settings button pressed');
        },
        color: Colors.red,
      ),
    ],
  );
}
