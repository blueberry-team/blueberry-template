import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppStringEnglish.dart';

/// TopScreen.dart
///
/// Top Page
/// - BottomNavigationBar를 통해 각 페이지로 이동
///
/// @jwson-automation

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final List<String> routes = [
  '/chat',
  '/friends',
  '/match',
  '/mbti',
  '/mypage',
  '/profiledetail',
  '/rank',
  '/post',
];

class TopScreen extends ConsumerWidget {
  static const String name = 'TopScreen';
  final Widget child;

  const TopScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(color: Colors.black),
        selectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: Colors.blueGrey[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: AppStringEnglish.chatScreenLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: AppStringEnglish.friendsScreenLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: AppStringEnglish.matchScreenLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search),
            label: AppStringEnglish.mbtiScreenLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: AppStringEnglish.myPageScreenLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_rounded),
            label: AppStringEnglish.profileDetailScreenLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: AppStringEnglish.rankingScreenLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.podcasts),
            label: AppStringEnglish.postScreenLabel,
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
          context.go(routes[index]);
        },
      ),
    );
  }
}
