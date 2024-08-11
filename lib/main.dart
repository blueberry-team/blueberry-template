import 'package:blueberry_flutter_template/router/RouterProvider.dart';
import 'package:blueberry_flutter_template/services/notification/firebase_cloud_messaging_manager.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';
import 'core/provider/ThemeProvider.dart';
import 'utils/AppTheme.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en_US', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseCloudMessagingManager.initialize(onTokenRefresh: (token) {
    debugPrint('FCM Token: $token');
  });

  setPathUrlStrategy(); // Hash URL(#)을 제거하고 Path URL을 사용하도록 설정

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeNotifierProvider); // 테마 모드 상태 관리 객체
        final router = ref.watch(routerProvider); // 라우터 객체

        return MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
        );
      },
    );
  }
}
