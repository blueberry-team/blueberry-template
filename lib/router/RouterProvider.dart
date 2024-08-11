import 'package:blueberry_flutter_template/feature/admin/AdminLoadingPage.dart';
import 'package:blueberry_flutter_template/feature/admin/AdminScreen.dart';
import 'package:blueberry_flutter_template/feature/admin/AdminUserDetailPage.dart';
import 'package:blueberry_flutter_template/feature/admin/AdminUserListPage.dart';
import 'package:blueberry_flutter_template/feature/chat/ChatScreen.dart';
import 'package:blueberry_flutter_template/feature/mbti/MBTITestScreen.dart';
import 'package:blueberry_flutter_template/feature/payment/widget/WebPaymentWidget.dart';
import 'package:blueberry_flutter_template/feature/setting/SettingScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/SplashScreen.dart';
import '../core/TopScreen.dart';
import '../feature/camera/SettingInsideAccountManagerWidget.dart';
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
    initialLocation:
        kIsWeb ? '/' :'/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (context, state) => ResponsiveLayoutBuilder(
          context,
          const SplashScreen(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return TopScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: TopScreen.name,
            builder: (context, state) => const ChatScreen(), // 초기 화면 설정
          ),
          GoRoute(
            path: '/chat',
            name: ChatScreen.name,
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            path: '/friends',
            name: FriendsListScreen.name,
            builder: (context, state) => const FriendsListScreen(),
          ),
          GoRoute(
            path: '/match',
            name: MatchScreen.name,
            builder: (context, state) => const MatchScreen(),
          ),
          GoRoute(
            path: '/mbti',
            name: MBTITestScreen.name,
            builder: (context, state) => const MBTITestScreen(),
          ),
          GoRoute(
            path: '/mypage',
            name: MyPageScreen.name,
            builder: (context, state) => const MyPageScreen(),
          ),
          GoRoute(
            path: '/profiledetail',
            name: ProfileDetailScreen.name,
            builder: (context, state) => const ProfileDetailScreen(),
          ),
          GoRoute(
            path: '/rank',
            name: RankingScreen.name,
            builder: (context, state) => const RankingScreen(),
          ),
          GoRoute(
            path: '/post',
            name: PostScreen.name,
            builder: (context, state) => const PostScreen(),
          ),
        ],
      ),
      // 바텀 네비게이션바가 필요 없는 루트
      GoRoute(
        path: '/signup',
        name: SignUpScreen.name,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/setting',
        name: SettingScreen.name,
        builder: (context, state) => const SettingScreen(),
      ),
      GoRoute(
        path: '/settingaccount',
        name: SettingAccountManagerWidget.name,
        builder: (context, state) => ResponsiveLayoutBuilder(
            context, const SettingAccountManagerWidget()),
      ),
      GoRoute(
        path: '/webpayment',
        name: WebPaymentWidget.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const WebPaymentWidget()),
      ),
      //Admin 관련 루트
      GoRoute(
        path: '/admin',
        name: AdminScreen.name,
        builder: (context, state) => ResponsiveLayoutBuilder(
            context, const AdminScreen()),
        routes: [
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
            path: 'loading',
            name: AdminLoadingPage.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const AdminLoadingPage()),
          ),
        ],
      ),
    ],
  );
});
