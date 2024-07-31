import 'package:blueberry_flutter_template/screens/SettingScreen.dart';
import 'package:blueberry_flutter_template/screens/TopScreen.dart';
import 'package:blueberry_flutter_template/screens/mypage/MyPageScreen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../providers/TalkerProvider.dart';
import '../screens/SplashScreen.dart';
import '../screens/mypage/SignUpScreen.dart';
import '../utils/ResponsiveLayoutBuilder.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final talker = ref.watch(talkerProvider);
  return GoRouter(
    observers: [CustomTalkerRouteObserver(talker)],
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
    ],
  );
});

// 이동 예정
class CustomTalkerRouteObserver extends NavigatorObserver {
  CustomTalkerRouteObserver(this.talker);

  final Talker talker;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    talker.logTyped(TalkerRouteLog(route: route));
    logRouteChange(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    talker.logTyped(TalkerRouteLog(route: route, isPush: false));
    logRouteChange(previousRoute);
  }

  void logRouteChange(Route? route) {
    final routeName = route?.settings.name;
    if (routeName != null) {
      talker.log("Navigated to $routeName");
      FirebaseAnalytics.instance.logEvent(
        name: 'route_change',
        parameters: {'route': routeName},
      );
    }
  }
}
