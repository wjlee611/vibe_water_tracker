import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vibe_water_tracker/src/core/router.dart';
import 'package:vibe_water_tracker/src/core/theme.dart';
import 'package:vibe_water_tracker/src/data/repositories/auth_repository.dart';
import 'package:vibe_water_tracker/src/features/auth/cubit/auth_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GoogleSignIn.instance.initialize();
  runApp(const VibeApp());
}

class VibeApp extends StatelessWidget {
  const VibeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Vibe Water Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter(context).router,
    );
  }
}
