import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_wins/enums/game_board_field.enum.dart';
import 'package:four_wins/enums/player.enum.dart';
import 'package:four_wins/models/game_board_field.dart';
import 'package:four_wins/pages/game_board/game_board.state.dart';
import 'package:four_wins/utils/logger.util.dart';

final gameBoardControllerProvider = StateNotifierProvider.autoDispose<GameBoardController, GameBoardState>(
  (ref) {
    return GameBoardController();
  },
);

class GameBoardController extends StateNotifier<GameBoardState> {
  GameBoardController() : super(GameBoardState()) {
    buildGameBoard();
  }

  static final _log = LoggerUtil(name: "game_board.controller.dart").logger;
  Player player = Player.player1;

  void buildGameBoard() async {
    _log.info('Building game board');
    final gameBoardFields = List<GameBoardField>.generate(
      42,
      (index) => GameBoardField(
        index: index,
        status: Status.empty,
      ),
    );
    state = state.copyWith(gameBoardFieldList: gameBoardFields);
  }

  void setCoinOnGameField({required int index}) {
    int bottomFieldIndex = index;

    // calculate the index of the bottom field, which is the field with the lowest index that is not empty
    for (var i = index; i <= state.gameBoardFieldList.length - 1; i += 7) {
      if (state.gameBoardFieldList[i].status == Status.empty) {
        bottomFieldIndex = i;
      }
    }

    final gameBoardField = state.gameBoardFieldList[bottomFieldIndex];
    final newGameBoardField = gameBoardField.copyWith(status: Status.filled, player: player);

    // replace the old field with the new field
    state = state.copyWith(
      gameBoardFieldList: state.gameBoardFieldList.map((field) {
        if (field.index == bottomFieldIndex) {
          return newGameBoardField;
        }
        return field;
      }).toList(),
    );

    checkIfSomebodyWon(bottomFieldIndex: bottomFieldIndex);

    if (player == Player.player1) {
      player = Player.player2;
    } else {
      player = Player.player1;
    }
    _log.info('$player is now playing');
  }

  void setWinner(bool player1, bool player2) {
    final Player winner = player1 ? Player.player1 : Player.player2;
    _log.info('setWinner: $winner');
    state = state.copyWith(won: true, winner: winner);
  }

  void checkIfSomebodyWon({required int bottomFieldIndex}) {
    _log.info('Checking if somebody won');
    bool player1Won = true;
    bool player2Won = true;

    // check if somebody won on the right side
    if (bottomFieldIndex % 7 <= 3) {
      for (int i = bottomFieldIndex; i <= bottomFieldIndex + 3 && i <= state.gameBoardFieldList.length - 1; i++) {
        if (state.gameBoardFieldList[i].status == Status.filled) {
          if (state.gameBoardFieldList[i].player != Player.player1) {
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
        setWinner(player1Won, player2Won);
      }
    }

    // check if somebody won on the left side
    player1Won = true;
    player2Won = true;

    if (bottomFieldIndex % 7 >= 3) {
      for (int i = bottomFieldIndex; i >= bottomFieldIndex - 3 && i >= 0; i--) {
        if (state.gameBoardFieldList[i].status == Status.filled) {
          if (state.gameBoardFieldList[i].player != Player.player1) {
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
        setWinner(player1Won, player2Won);
      }
    }

    // check if somebody won from bottom index to top index
    if (bottomFieldIndex - 3 * 7 >= 0) {
      player1Won = true;
      player2Won = true;

      for (int i = bottomFieldIndex; i >= bottomFieldIndex - 3 * 7 && i >= 0; i -= 7) {
        if (state.gameBoardFieldList[i].status == Status.filled) {
          if (state.gameBoardFieldList[i].player != Player.player1) {
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
        setWinner(player1Won, player2Won);
      }
    }
    // check if somebody won from top index to bottom index
    else {
      player1Won = true;
      player2Won = true;

      for (int i = bottomFieldIndex;
          i <= bottomFieldIndex + 3 * 7 && i <= state.gameBoardFieldList.length - 1;
          i += 7) {
        if (state.gameBoardFieldList[i].status == Status.filled) {
          if (state.gameBoardFieldList[i].player != Player.player1) {
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
        setWinner(player1Won, player2Won);
      }
    }

    // check if somebody won diagonally from bottomFieldIndex to top left corner
    player1Won = true;
    player2Won = true;
    int fieldCounter = 0;

    // count diagonally from bottomFieldIndex to top left corner and max 4 fields
    for (int i = bottomFieldIndex; i >= bottomFieldIndex - 3 * 8 && i >= 0; i -= 8) {
      fieldCounter++;
      if (i % 7 == 0) {
        break;
      }
    }

    // if there are 4 fields, check if they are filled by the same player
    if (fieldCounter == 4) {
      for (int i = bottomFieldIndex; i >= bottomFieldIndex - 3 * 8 && i >= 0; i -= 8) {
        if (state.gameBoardFieldList[i].status == Status.filled) {
          if (state.gameBoardFieldList[i].player != Player.player1) {
            player1Won = false;
          } else {
            player2Won = false;
          }
        } else {
          player1Won = false;
          player2Won = false;
        }
        if (i % 7 == 0) {
          break;
        }
      }

      if (player1Won || player2Won) {
        setWinner(player1Won, player2Won);
      }
    }

    // check if somebody won diagonally from bottomFieldIndex to bottom right corner
    player1Won = true;
    player2Won = true;
    fieldCounter = 0;

    // count diagonally from bottomFieldIndex to bottom right and max 4 fields
    for (int i = bottomFieldIndex; i <= bottomFieldIndex + 3 * 8 && i <= state.gameBoardFieldList.length - 1; i += 8) {
      fieldCounter++;
      if (i % 7 == 6) {
        break;
      }
    }

    // if there are 4 fields, check if they are filled by the same player
    if (fieldCounter == 4) {
      for (int i = bottomFieldIndex;
          i <= bottomFieldIndex + 3 * 8 && i <= state.gameBoardFieldList.length - 1;
          i += 8) {
        if (state.gameBoardFieldList[i].status == Status.filled) {
          if (state.gameBoardFieldList[i].player != Player.player1) {
            player1Won = false;
          } else {
            player2Won = false;
          }
        } else {
          player1Won = false;
          player2Won = false;
        }
        if (i % 7 == 6) {
          break;
        }
      }

      if (player1Won || player2Won) {
        setWinner(player1Won, player2Won);
      }
    }
  }
}
