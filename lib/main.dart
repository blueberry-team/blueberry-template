import 'package:blueberry_flutter_template/router/RouterProvider.dart';
import 'package:blueberry_flutter_template/utils/AppStrings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'providers/ThemeProvider.dart';
import 'utils/AppTheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseCloudMessagingManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
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
      ),
    );
  }
}
