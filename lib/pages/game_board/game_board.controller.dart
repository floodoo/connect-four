import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_wins/enums/game_board_field.enum.dart';
import 'package:four_wins/enums/player.enum.dart';
import 'package:four_wins/models/game_board_field.model.dart';
import 'package:four_wins/utils/logger.util.dart';

final gameBoardControllerProvider = StateNotifierProvider.autoDispose<PlaceController, List<GameBoardFieldModel>>(
  (ref) {
    return PlaceController();
  },
);

class PlaceController extends StateNotifier<List<GameBoardFieldModel>> {
  PlaceController() : super([]) {
    buildGameBoard();
  }

  static final _log = LoggerUtil(name: "game_board.controller.dart").logger;
  Player player = Player.player1;

  void buildGameBoard() async {
    _log.info('Building game board');
    final gameBoardFields = List<GameBoardFieldModel>.generate(
      42,
      (index) => GameBoardFieldModel(
        index: index,
        status: Status.empty,
      ),
    );
    state = gameBoardFields;
  }

  void setCoinOnGameField({required int index}) {
    _log.fine('Setting coin on game field $index');
    int bottomFieldIndex = index;

    // calculate the index of the bottom field, which is the field with the lowest index that is not empty
    for (var i = index; i <= state.length - 1; i += 7) {
      if (state[i].status == Status.empty) {
        bottomFieldIndex = i;
      }
    }

    _log.fine('Setting coin on index: $bottomFieldIndex');
    final gameBoardField = state[bottomFieldIndex];
    final newGameBoardField = gameBoardField.copyWith(status: Status.filled, player: player);

    // replace the old field with the new field
    state = state.map((gameBoardField) {
      if (gameBoardField.index == bottomFieldIndex) {
        return newGameBoardField;
      }
      return gameBoardField;
    }).toList();

    final somebodyWon = checkIfSomebodyWon(index: bottomFieldIndex);
    if (somebodyWon) {}

    if (player == Player.player1) {
      player = Player.player2;
    } else {
      player = Player.player1;
    }
    _log.info('$player is now playing');
  }

  bool checkIfSomebodyWon({required int index}) {
    _log.fine('Checking if somebody won');
    bool player1Won = true;
    bool player2Won = true;

    // check if somebody won on the right side
    if (index % 7 <= 3) {
      for (int i = index; i <= index + 3 && i <= state.length - 1; i++) {
        if (state[i].status == Status.filled) {
          if (state[i].player != Player.player1) {
            player1Won = false;
          } else {
            player2Won = false;
          }
        } else {
          player1Won = false;
          player2Won = false;
        }
      }

      if (player1Won || player2Won) {
        if (player1Won) {
          _log.info('Player 1 won');
        } else {
          _log.info('Player 2 won');
        }
        return true;
      }
    }

    // check if somebody won on the left side
    if (index % 7 >= 3) {
      for (int i = index; i >= index - 3 && i >= 0; i--) {
        if (state[i].status == Status.filled) {
          if (state[i].player != Player.player1) {
            player1Won = false;
          } else {
            player2Won = false;
          }
        } else {
          player1Won = false;
          player2Won = false;
        }
      }

      if (player1Won || player2Won) {
        if (player1Won) {
          _log.info('Player 1 won');
        } else {
          _log.info('Player 2 won');
        }
        return true;
      }
    }

    return false;
  }
}
