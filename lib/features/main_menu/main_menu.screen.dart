import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

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
                '4 Wins',
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
