import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../core/auth/auth_notifier.dart';
import '../core/auth/auth_service.dart';
import '../features/dashboard/presentation/widget/bottom_bar.dart';
import '../features/loyalty/presentation/pages/login_page.dart';
import '../features/loyalty/presentation/pages/onboarding_page.dart';
import '../features/loyalty/presentation/pages/otp_page.dart';
import '../features/loyalty/presentation/pages/rewards_page.dart';

final _authService = AuthService();
final _authNotifier = AuthNotifier(_authService);

final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  refreshListenable: _authNotifier,

  redirect: (context, state) {
    final loggedIn = _authNotifier.isLoggedIn;
    final loggingIn = state.fullPath == '/login' || state.fullPath == '/otp';

    if (!loggedIn) {
      final isOnboarding = state.fullPath == '/onboarding';
      if (!loggingIn && !isOnboarding) {
        return '/login';
      }
      return null;
    }
    if (loggedIn && loggingIn) {
      return '/dashboard';
    }
    return null;
  },

  routes: <RouteBase>[
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (BuildContext context, GoRouterState state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
    ),
    GoRoute(
      path: '/otp',
      name: 'otp',
      builder: (BuildContext context, GoRouterState state) {
        final extra = (state.extra as Map?) ?? {};
        final verificationId = extra['verificationId'] as String? ?? '';
        final phone = extra['phone'] as String? ?? '';
        return OtpPage(verificationId: verificationId, phone: phone);
      },
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (BuildContext context, GoRouterState state) => const BottomBar(),
    ),
    GoRoute(
      path: '/rewards',
      name: 'rewards',
      builder: (BuildContext context, GoRouterState state) => const RewardsPage(),
    ),
  ],
);
