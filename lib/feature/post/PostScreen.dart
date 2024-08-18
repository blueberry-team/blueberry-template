// 게시물 화면!
//
import 'package:blueberry_flutter_template/feature/mbti/MBTIScreen.dart';
import 'package:blueberry_flutter_template/feature/post/widget/PostListViewWidget.dart';
import 'package:blueberry_flutter_template/feature/profile/ProfileDetailScreen.dart';
import 'package:blueberry_flutter_template/feature/rank/RankScreen.dart';
import 'package:blueberry_flutter_template/feature/setting/SettingScreen.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widget/CustomFab.dart';
import '../chat/ChatRoomScreen.dart';
import '../friendsList/FriendsListScreen.dart';
import 'PostingScreen.dart';

class PostScreen extends StatelessWidget {
  static const String name = 'PostScreen';
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: _buildAppBar(context),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            PostListViewWidget(),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: _buildCustomFAB(context),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    centerTitle: false,
    title: const Text(AppStrings.appbar_Text_Logo),
    actions: [
      IconButton(
        icon: const Icon(Icons.message),
        onPressed: () => context.goNamed(ChatRoomScreen.name),
      ),
      IconButton(
          icon: const Icon(Icons.emoji_events),
          onPressed: () => context.goNamed(RankingScreen.name)),
      IconButton(
        icon: const Icon(Icons.supervised_user_circle_rounded),
        onPressed: () => context.goNamed(ProfileDetailScreen.name),
      )
    ],
  );
}

CustomFab _buildCustomFAB(BuildContext context) {
  return CustomFab(
    mainColor: Colors.blue,
    mainIcon: Icons.add,
    fabButtons: [
      FabButton(
        icon: Icons.accessibility_sharp,
        label: 'MBTI',
        onPressed: () => context.goNamed(MBTIScreen.name),
        color: Colors.orange,
      ),
      FabButton(
        icon: Icons.person,
        label: 'friends',
        onPressed: () => context.goNamed(FriendsListScreen.name),
        color: Colors.green,
      ),
      FabButton(
          icon: Icons.add_a_photo,
          label: 'post',
          onPressed: () => context.goNamed(PostingScreen.name)),
      FabButton(
        icon: Icons.settings,
        label: 'Settings',
        onPressed: () => context.goNamed(SettingScreen.name),
        color: Colors.red,
      ),
    ],
  );
}
