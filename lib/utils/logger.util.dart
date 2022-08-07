import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggerUtil {
  LoggerUtil({required this.name}) : super() {
    createLogger();
  }

  final String name;
  late Logger _logger;

  Logger get logger => _logger;

  createLogger() {
    if (kReleaseMode) {
      Logger.root.level = Level.WARNING;
    }

    Logger.root.onRecord.listen((record) {
      debugPrint(
        '${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}',
      );
    });

    _logger = Logger(name);
  }
}
