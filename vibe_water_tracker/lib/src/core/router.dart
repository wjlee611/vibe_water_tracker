import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe_water_tracker/src/features/auth/cubit/auth_cubit.dart';
import 'package:vibe_water_tracker/src/features/auth/cubit/auth_state.dart';
import 'package:vibe_water_tracker/src/features/auth/views/login_screen.dart';
import 'package:vibe_water_tracker/src/features/auth/views/splash_screen.dart';
import 'package:vibe_water_tracker/src/features/home/views/home_screen.dart';

class AppRouter {
  final BuildContext context;

  AppRouter(this.context);

  late final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final authState = context.read<AuthCubit>().state;
      final location = state.matchedLocation;

      if (authState.status == AuthStatus.unknown) {
        return '/splash';
      }

      if (authState.status == AuthStatus.authenticated) {
        if (location == '/login' || location == '/splash') {
          return '/home';
        }
      } else {
        if (location != '/login') {
          return '/login';
        }
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(context.read<AuthCubit>().stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}