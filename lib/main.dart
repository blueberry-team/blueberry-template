import 'dart:async';

import 'package:blueberry_flutter_template/router/RouterProvider.dart';
import 'package:blueberry_flutter_template/services/notification/firebase_cloud_messaging_manager.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/provider/ThemeProvider.dart';
import 'firebase_options.dart';
import 'utils/AppTheme.dart';
import 'utils/Talker.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    // 날짜 형식 초기화
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('en_US', null);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseCloudMessagingManager.initialize(onTokenRefresh: (token) {
      talker.info('FCM Token: $token');
    });

    // Crashlytics 설정
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }

    setPathUrlStrategy(); // Hash URL(#)을 제거하고 Path URL을 사용하도록 설정

    runApp(const ProviderScope(
      child: MyApp(),
    ));
  }, (error, stackTrace) {
    talker.error('Uncaught error: $error');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
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
