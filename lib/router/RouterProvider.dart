import 'package:blueberry_flutter_template/screens/SettingScreen.dart';
import 'package:blueberry_flutter_template/screens/TopScreen.dart';
import 'package:blueberry_flutter_template/screens/adminScreen/AdminLoadingPage.dart';
import 'package:blueberry_flutter_template/screens/adminScreen/AdminMainPage.dart';
import 'package:blueberry_flutter_template/screens/adminScreen/UserDetailPageInAdmin.dart';
import 'package:blueberry_flutter_template/screens/adminScreen/UserListInAdminPage.dart';
import 'package:blueberry_flutter_template/screens/chat/ChatScreen.dart';
import 'package:blueberry_flutter_template/screens/mbti/MBTITestScreen.dart';
import 'package:blueberry_flutter_template/screens/mypage/MyPageScreen.dart';
import 'package:blueberry_flutter_template/screens/mypage/camera/SettingInsideAccountManagerWidget.dart';
import 'package:blueberry_flutter_template/widgets/payment/WebPaymentWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/SplashScreen.dart';
import '../screens/mypage/SignUpScreen.dart';
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
            name: AdminMainPage.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const AdminMainPage()),
          ),
          GoRoute(
            path: 'userlistinadmin',
            name: UserListInAdminPage.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const UserListInAdminPage()),
          ),
          GoRoute(
            path: 'userdetailinadmin',
            name: UserDetailPageInAdmin.name,
            builder: (context, state) =>
                ResponsiveLayoutBuilder(context, const UserDetailPageInAdmin()),
          ),
        ],
      ),
    ],
  );
});
