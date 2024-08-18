import 'package:blueberry_flutter_template/feature/admin/AdminUserListPage.dart';
import 'package:blueberry_flutter_template/feature/login/LoginScreen.dart';
import 'package:blueberry_flutter_template/feature/match/MatchScreen.dart';
import 'package:blueberry_flutter_template/feature/post/PostScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/AppStringEnglish.dart';

/// TopScreen.dart
///
/// Top Page
/// - BottomNavigationBar를 통해 각 페이지로 이동
///
/// @jwson-automation

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final List<Widget> pages = [
  const PostScreen(),
  const MatchScreen(),
  const LoginScreen(),
  const AdminUserListPage()
];

class TopScreen extends ConsumerWidget {
  static const String name = 'TopScreen';

  const TopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: Center(
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(color: Colors.black),
        selectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: Colors.blueGrey[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.podcasts),
            label: AppStringEnglish.postScreenLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: AppStringEnglish.matchScreenLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: AppStringEnglish.myPageScreenLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: AppStringEnglish.adminScreenLabel,
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) =>
            ref.read(selectedIndexProvider.notifier).state = index,
      ),
    );
  }
}
