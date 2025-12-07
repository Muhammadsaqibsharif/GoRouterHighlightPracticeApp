import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
    ),
  ],
);
