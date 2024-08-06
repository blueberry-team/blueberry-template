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
import '../feature/chat/ChatRoomScreen.dart';
import '../feature/friend/FriendsListScreen.dart';
import '../feature/mypage/MyPageScreen.dart';
import '../feature/profile/ProfileDetailScreen.dart';
import '../feature/rank/RankScreen.dart';
import '../feature/signup/SignUpScreen.dart';
import '../utils/ResponsiveLayoutBuilder.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: kIsWeb ? '/' : '/splash',
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
            path: 'settingaccount',
            name: SettingAccountManagerWidget.name,
            builder: (context, state) => ResponsiveLayoutBuilder(
                context, const SettingAccountManagerWidget()),
          ),
          GoRoute(
            path: 'webpayment',
            name: WebPaymentWidget.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const WebPaymentWidget()),
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
            path: 'adminloading',
            name: AdminLoadingPage.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const AdminLoadingPage()),
          ),
          GoRoute(
            path: 'adminmain',
            name: AdminScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const AdminScreen()),
          ),
          GoRoute(
            path: 'userlistinadmin',
            name: AdminUserListPage.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const AdminUserListPage()),
          ),
          GoRoute(
            path: 'userdetailinadmin',
            name: AdminUserDetailPage.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const AdminUserDetailPage()),
          ),
          GoRoute(
            path: 'chatroom',
            name: ChatRoomScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const ChatRoomScreen()),
          ),
          GoRoute(
            path: 'friends',
            name: FriendsListScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const FriendsListScreen()),
          ),
          GoRoute(
            path: 'ranking',
            name: RankingScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const RankingScreen()),
          ),
          GoRoute(
            path: 'profiledetail',
            name: ProfileDetailScreen.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const ProfileDetailScreen()),
          )
        ],
      ),
    ],
  );
});
