import 'package:blueberry_flutter_template/screens/SettingScreen.dart';
import 'package:blueberry_flutter_template/screens/TopScreen.dart';
import 'package:blueberry_flutter_template/screens/mypage/MyPageScreen.dart';
import 'package:blueberry_flutter_template/utils/Talker.dart';
import 'package:blueberry_flutter_template/screens/mypage/camera/SettingInsideAccountManagerWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../screens/SplashScreen.dart';
import '../screens/mypage/SignUpScreen.dart';
import '../utils/ResponsiveLayoutBuilder.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    observers: [TalkerRouteObserver(talker)],
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => ResponsiveLayoutBuilder(
                context,
                kIsWeb ? const TopScreen() : const SplashScreen(),
              )),
      GoRoute(
        path: '/top',
        name: TopScreen.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const TopScreen()),
      ),
      GoRoute(
        path: '/signup',
        name: SignUpScreen.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const SignUpScreen()),
      ),
      GoRoute(
        path: '/setting',
        name: SettingScreen.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const SettingScreen()),
      ),
      GoRoute(
        path: '/mypage',
        name: MyPageScreen.name,
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const MyPageScreen()),
      ),
      GoRoute(
        path: '/SettingAccountManagerWidget',
        name: SettingAccountManagerWidget.name,  // 여기를 수정
        builder: (context, state) =>
            ResponsiveLayoutBuilder(context, const SettingAccountManagerWidget()),
      ),
    ],
  );
});
