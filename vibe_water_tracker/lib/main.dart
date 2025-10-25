import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vibe_water_tracker/src/core/router.dart';
import 'package:vibe_water_tracker/src/core/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Vibe Water Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // 시스템 설정에 따라 테마 변경
      routerConfig: router,
    );
  }
}
