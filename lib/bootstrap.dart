import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/di/locator.dart';
import 'core/logging/logger.dart';

Future<void> bootstrap(Widget Function() appBuilder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();

  FlutterError.onError = (details) {
    getLogger().e('FlutterError', error: details.exception, stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    getLogger().e('PlatformDispatcher error', error: error, stackTrace: stack);
    return true;
  };

  runZonedGuarded(() {
    runApp(appBuilder());
  }, (error, stack) {
    getLogger().e('Uncaught zone error', error: error, stackTrace: stack);
  });
}
