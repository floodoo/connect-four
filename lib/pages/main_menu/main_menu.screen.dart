import 'package:connect_four/core/changeNotifier/change_notifier.dart';
import 'package:connect_four/utils/lifecycle_event_handler.dart';
import 'package:connect_four/utils/logger.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainMenuScreen extends ConsumerStatefulWidget {
  const MainMenuScreen({super.key});

  @override
  ConsumerState<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen> {
  final _log = LoggerUtil(name: "main_menu.screen.dart").logger;

  @override
  void initState() {
    ref.read(audioControllerProvider).playMusic();
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        resumeCallBack: () async {
          _log.info("App has resumed");
          ref.read(audioControllerProvider).resumeMusic();
        },
        pauseCallBack: () async {
          _log.info("App has paused");
          ref.read(audioControllerProvider).pauseMusic();
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            Transform.rotate(
              angle: -0.1,
              child: Text(
                "Connect Four",
                textAlign: TextAlign.center,
                style: theme.textTheme.headline1,
              ),
            ),
            Expanded(child: Container()),
            ElevatedButton(onPressed: () => GoRouter.of(context).go('/play'), child: const Text("Play")),
            ElevatedButton(onPressed: () {}, child: const Text("Settings")),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
