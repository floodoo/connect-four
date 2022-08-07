import 'package:connect_four/app.dart';
import 'package:connect_four/utils/logger.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  final log = LoggerUtil(name: 'main.dart').logger;

  WidgetsFlutterBinding.ensureInitialized();

  log.info('Going full screen');

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  runApp(const ProviderScope(child: MyApp()));
}
