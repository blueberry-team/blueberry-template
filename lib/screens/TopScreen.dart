import 'package:blueberry_flutter_template/screens/chat/ChatRoomScreen.dart';
import 'package:blueberry_flutter_template/screens/mbti/MBTIScreen.dart';
import 'package:blueberry_flutter_template/screens/profileDetail/ProfileDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'friendsList/FriendsListScreen.dart';
import 'match/MatchScreen.dart';
import 'mypage/LoginScreen.dart';

/// TopScreen.dart
///
/// Top Page
/// - BottomNavigationBar를 통해 각 페이지로 이동
///
/// @jwson-automation

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class TopScreen extends ConsumerWidget {
  static const String name = '/TopScreen';

  const TopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    final List<Widget> pages = [
      const ChatRoomScreen(),
      const FriendsListScreen(),
      const MatchScreen(),
      const MBTIScreen(),
      const LoginScreen(),
      const ProfileDetailScreen(),
    ];

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
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'match',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search),
            label: 'mbti',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'MyPage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_rounded),
            label: 'ProfileDetail',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) =>
            ref.read(selectedIndexProvider.notifier).state = index,
      ),
    );
  }
}
