import 'package:connect_four/pages/game_board/game_board.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WinMenuScreen extends ConsumerWidget {
  const WinMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final winningPlayer = ref.read(gameBoardControllerProvider).winner;
    final gameMoves = ref.read(gameBoardControllerProvider).moves;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: -0.1,
                child: Text(
                  "${winningPlayer?.name ?? ""} wins!",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline1,
                ),
              ),
              const SizedBox(height: 200),
              Text("You did $gameMoves moves", style: theme.textTheme.headline5),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () => GoRouter.of(context).go('/'),
                icon: const Icon(Icons.home),
                label: const Text("Home"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
