import 'package:blueberry_flutter_template/feature/ProfilePicVerificationScreen.dart';
import 'package:blueberry_flutter_template/feature/admin/AdminLoadingPage.dart';
import 'package:blueberry_flutter_template/feature/admin/AdminScreen.dart';
import 'package:blueberry_flutter_template/feature/admin/AdminUserDetailPage.dart';
import 'package:blueberry_flutter_template/feature/admin/AdminUserListPage.dart';
import 'package:blueberry_flutter_template/feature/camera/CameraGalleryScreen.dart';
import 'package:blueberry_flutter_template/feature/camera/CameraScreen.dart';
import 'package:blueberry_flutter_template/feature/chat/ChatScreen.dart';
import 'package:blueberry_flutter_template/feature/mbti/MBTITestScreen.dart';
import 'package:blueberry_flutter_template/feature/setting/SettingScreen.dart';
import 'package:blueberry_flutter_template/feature/user/RestoreDeletedUserScreen.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../core/SplashScreen.dart';
import '../core/TopScreen.dart';
import '../feature/friend/FriendsListScreen.dart';
import '../feature/match/MatchScreen.dart';
import '../feature/mypage/MyPageScreen.dart';
import '../feature/post/PostScreen.dart';
import '../feature/profile/ProfileDetailScreen.dart';
import '../feature/rank/RankScreen.dart';
import '../feature/signup/SignUpScreen.dart';
import '../utils/ResponsiveLayoutBuilder.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: kIsWeb ? '/' : '/splash',
    observers: [TalkerRouteObserver(talker)],
    routes: [
      GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (context, state) => ResponsiveLayoutBuilder(
          context,
          const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/',
        name: TopScreen.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const TopScreen()),
        routes: [
          GoRoute(
            path: 'signup',
            name: SignUpScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const SignUpScreen()),
          ),
          GoRoute(
              path: 'post',
              name: PostScreen.name,
              builder: (context, state) => const PostScreen()),
          GoRoute(
            path: 'setting',
            name: SettingScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const SettingScreen()),
          ),
          GoRoute(
            path: 'mypage',
            name: MyPageScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const MyPageScreen()),
          ),
          GoRoute(
            path: 'chat',
            name: ChatScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const ChatScreen()),
          ),
          GoRoute(
            path: 'mbti',
            name: MBTITestScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const MBTITestScreen()),
          ),
          GoRoute(
            path: 'adminmain',
            name: AdminScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const AdminScreen()),
          ),
          GoRoute(
            path: 'restoredeleteduser',
            name: RestoreDeletedUserScreen.name,
            builder: (context, state) => ResponsiveLayoutBuilder(
                context, const RestoreDeletedUserScreen()),
          ),
          GoRoute(
            path: 'userlist',
            name: AdminUserListPage.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const AdminUserListPage()),
          ),
          GoRoute(
            path: 'userdetail',
            name: AdminUserDetailPage.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const AdminUserDetailPage()),
          ),
          GoRoute(
            path: 'rank',
            name: RankingScreen.name,
            builder: (context, state) => const RankingScreen(),
          ),
          GoRoute(
            path: 'profiledetail',
            name: ProfileDetailScreen.name,
            builder: (context, state) => const ProfileDetailScreen(),
          ),
          GoRoute(
            path: 'profilecamera',
            name: CameraScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const CameraScreen()),
          ),
          GoRoute(
            path: 'profilecameragallery',
            name: CameraGalleryScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const CameraGalleryScreen()),
          ),
          GoRoute(
            path: 'friends',
            name: FriendsListScreen.name,
            builder: (context, state) => const FriendsListScreen(),
          ),
          GoRoute(
            path: 'loading',
            name: AdminLoadingPage.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const AdminLoadingPage()),
          ),
          GoRoute(
              path: 'match',
              name: MatchScreen.name,
              builder: (context, state) => const MatchScreen()),
          GoRoute(
              path: 'profile-pic-verification',
              name: ProfilePicVerificationScreen.name,
              builder: (context, state) => const ProfilePicVerificationScreen()),
        ],
      ),
    ],
  );
});
