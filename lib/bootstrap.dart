import 'dart:async';
import 'package:flutter/widgets.dart';
import 'core/di/locator.dart';
import 'core/logging/logger.dart';

Future<void> bootstrap(Widget Function() appBuilder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runZonedGuarded(() {
    runApp(appBuilder());
  }, (error, stack) {
    getLogger().e('Uncaught zone error', error: error, stackTrace: stack);
  });
}
