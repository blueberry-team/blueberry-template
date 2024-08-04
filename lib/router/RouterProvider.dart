import 'package:blueberry_flutter_template/screens/SettingScreen.dart';
import 'package:blueberry_flutter_template/screens/TopScreen.dart';
import 'package:blueberry_flutter_template/screens/mypage/MyPageScreen.dart';
import 'package:blueberry_flutter_template/screens/adminScreen/AdminLoadingPage.dart';
import 'package:blueberry_flutter_template/screens/adminScreen/AdminMainPage.dart';
import 'package:blueberry_flutter_template/screens/adminScreen/UserDetailPageInAdmin.dart';
import 'package:blueberry_flutter_template/screens/adminScreen/UserListInAdminPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/SplashScreen.dart';
import '../screens/mypage/SignUpScreen.dart';
import '../utils/ResponsiveLayoutBuilder.dart';


final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => ResponsiveLayoutBuilder(
                context,
                kIsWeb ? const TopScreen() : const SplashScreen(),
              )),
      GoRoute(
        path: '/TopScreen',
        name: TopScreen.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const TopScreen()),
      ),
      GoRoute(
        path: '/SignUpScreen',
        name: SignUpScreen.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const SignUpScreen()),
      ),
      GoRoute(
        path: '/SettingsScreen',
        name: SettingScreen.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const SettingScreen()),
      ),
      GoRoute(
        path: '/MyPageScreen',
        name: MyPageScreen.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const MyPageScreen()),
      ),
      GoRoute(
        path: '/AdminLoadingPage',
        name: AdminLoadingPage.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const AdminLoadingPage()),
      ),
      GoRoute(
        path: '/AdminMainPage',
        name: AdminMainPage.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const AdminMainPage()),
      ),
      GoRoute(
        path: '/UserListInAdminPage',
        name: UserListInAdminPage.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const UserListInAdminPage()),
      ),
      GoRoute(
        path: '/UserDetailPageInAdmin',
        name: UserDetailPageInAdmin.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const UserDetailPageInAdmin()),
      ),
    ],
  );
});
