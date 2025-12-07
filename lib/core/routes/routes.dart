import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/screen_a/screen_a.dart';
import '../../modules/screen_b/screen_b.dart';
import '../../modules/screen_c/screen_c.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ScreenA();
      },
    ),
    GoRoute(
      path: '/screen-b',
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, String>?;
        return ScreenB(phrase: extra?['phrase'], hashtags: extra?['hashtags']);
      },
      routes: [
        GoRoute(
          path: 'screen-c',
          builder: (BuildContext context, GoRouterState state) {
            return const ScreenC();
          },
        ),
      ],
    ),
  ],
);
