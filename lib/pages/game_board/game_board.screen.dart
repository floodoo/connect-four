import 'package:connect_four/enums/game_board_field.enum.dart';
import 'package:connect_four/enums/player.enum.dart';
import 'package:connect_four/pages/game_board/game_board.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

class GameBoard extends ConsumerWidget {
  const GameBoard({Key? key}) : super(key: key);
  static final Logger _log = Logger('game_board.screen.dart');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameBoardFieldList = ref.watch(gameBoardControllerProvider).gameBoardFieldList;

    final won = ref.watch(gameBoardControllerProvider).won;

    if (won) {
      Future.delayed(Duration.zero, () {
        GoRouter.of(context).go('/play/win');
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _log.info('Refreshing game board');
              ref.read(gameBoardControllerProvider.notifier).buildGameBoard();
            },
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: gameBoardFieldList.length,
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final gameBoardField = gameBoardFieldList[index];
          return ElevatedButton(
            onPressed: () => gameBoardField.status != Status.empty
                ? null
                : ref.read(gameBoardControllerProvider.notifier).setCoinOnGameField(index: index),
            style: ElevatedButton.styleFrom(
              primary: gameBoardField.status == Status.empty
                  ? Colors.grey
                  : gameBoardField.player == Player.player1
                      ? Colors.blue
                      : Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Container(),
          );
        },
      ),
    );
  }
}
