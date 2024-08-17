import 'package:flutter/material.dart';

import 'widget/FriendsListViewWidget.dart';

/// FriendsListScreen - 완성 되었습니다
/// 8월 15일 상현

class FriendsListScreen extends StatelessWidget {
  static const String name = 'FriendsListScreen';

  const FriendsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: FriendsListViewWidget()),
          ],
        ),
      ),
    );
  }
}
