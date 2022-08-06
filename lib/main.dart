import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_wins/app.dart';
import 'package:logging/logging.dart';

void main() {
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

  final log = Logger('main.dart');

  WidgetsFlutterBinding.ensureInitialized();

  log.info('Going full screen');

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  runApp(const ProviderScope(child: MyApp()));
}
