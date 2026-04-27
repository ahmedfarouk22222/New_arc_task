import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'route_names.dart';

@lazySingleton
class AppRouter {
  GoRouter get router => GoRouter(
        initialLocation: RouteNames.splash,
        routes: <RouteBase>[
          GoRoute(
            path: RouteNames.splash,
            builder: (_, __) => const SizedBox.shrink(),
          ),
        ],
      );
}
