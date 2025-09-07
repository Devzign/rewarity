import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router.dart';
import 'theme.dart';

class RewarityApp extends StatelessWidget {
  const RewarityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: _RewarityAppRoot(),
    );
  }
}

class _RewarityAppRoot extends ConsumerWidget {
  const _RewarityAppRoot();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Rewarity',
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.light,
      routerConfig: router,
      locale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('hi')],
    );
  }
}
