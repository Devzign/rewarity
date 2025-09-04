import 'package:logger/logger.dart' as l;

class AppLogger {
  final l.Logger _logger;
  AppLogger._(this._logger);
  factory AppLogger.sl() => AppLogger._(l.Logger());

  void d(String m) => _logger.d(m);
  void i(String m) => _logger.i(m);
  void w(String m) => _logger.w(m);
  void e(String m, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(m, error: error, stackTrace: stackTrace);
}

AppLogger getLogger() => AppLogger.sl(); // through get_it in practice
