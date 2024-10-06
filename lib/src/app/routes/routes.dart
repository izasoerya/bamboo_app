import 'package:bamboo_app/src/presentation/layout/app_layout.dart';
import 'package:bamboo_app/src/presentation/pages/login.dart';
import 'package:bamboo_app/src/presentation/pages/register.dart';
import 'package:bamboo_app/src/presentation/pages/dashboard.dart';
import 'package:bamboo_app/src/presentation/layout/auth_layout.dart';
import 'package:bamboo_app/src/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthLayout(child: SplashScreenPage());
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const AuthLayout(child: LoginPage());
          },
        ),
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return const AuthLayout(child: RegisterPage());
          },
        ),
        GoRoute(
          path: 'dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return const AppLayout(child: DashboardPage());
          },
        ),
      ],
    ),
  ],
);
