import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_wins/enums/game_board_field.enum.dart';
import 'package:four_wins/pages/game_board/game_board.controller.dart';
import 'package:logging/logging.dart';

class GameBoard extends ConsumerWidget {
  const GameBoard({Key? key}) : super(key: key);
  static final Logger _log = Logger('game_board.screen.dart');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _log.info('Building game board');
    final gameBoard = ref.watch(gameBoardControllerProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(gameBoardControllerProvider.notifier).buildGameBoard();
            },
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: gameBoard.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (context, index) {
          final gameBoardField = gameBoard[index];
          return ElevatedButton(
            onPressed: () => ref.read(gameBoardControllerProvider.notifier).setCoinOnGameField(index: index),
            style: ElevatedButton.styleFrom(
              primary: gameBoardField.status == Status.empty ? Colors.blue : Colors.red,
            ),
            child: Text(
              '$index',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}
