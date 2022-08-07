import 'package:connect_four/core/changeNotifier/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    ref.read(audioController).playMusic();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            Transform.rotate(
              angle: -0.1,
              child: Text(
                'Connect Four',
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
