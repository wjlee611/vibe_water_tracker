import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO: 각 화면의 경로(path)와 빌더(builder)를 실제 위젯으로 교체해야 합니다.

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Splash Screen'),
        ),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Login Screen'),
        ),
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Home Screen'),
        ),
      ),
    ),
  ],
);
