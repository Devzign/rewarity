import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../features/loyalty/presentation/pages/dashboard_page.dart';
import '../features/loyalty/presentation/pages/onboarding_page.dart';
import '../features/loyalty/presentation/pages/rewards_page.dart';


final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  routes: <RouteBase>[
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (BuildContext context, GoRouterState state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (BuildContext context, GoRouterState state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/rewards',
      name: 'rewards',
      builder: (BuildContext context, GoRouterState state) => const RewardsPage(),
    ),
  ],
);


