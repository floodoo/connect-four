import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_wins/app.dart';
import 'package:four_wins/utils/logger.util.dart';

void main() {
  final log = LoggerUtil(name: 'main.dart').logger;

  WidgetsFlutterBinding.ensureInitialized();

  log.info('Going full screen');

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  runApp(const ProviderScope(child: MyApp()));
}
