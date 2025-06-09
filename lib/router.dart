import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'ui/main_layout.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (_, __) => const NoTransitionPage(child: MainLayout()),
    ),
    // later you can push other stand‑alone pages (details, payment…) here
  ],
);
