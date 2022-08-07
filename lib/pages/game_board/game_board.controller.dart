import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_wins/enums/game_board_field.enum.dart';
import 'package:four_wins/models/game_board_field.model.dart';
import 'package:logging/logging.dart';

final gameBoardControllerProvider = StateNotifierProvider.autoDispose<PlaceController, List<GameBoardFieldModel>>(
  (ref) {
    return PlaceController();
  },
);

class PlaceController extends StateNotifier<List<GameBoardFieldModel>> {
  PlaceController() : super([]) {
    buildGameBoard();
  }

  final Logger _log = Logger('game_board.controller.dart');

  void buildGameBoard() async {
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
    _log.info('Setting coin on game field $index');
    int bottomFieldIndex = index;

    // calculate the index of the bottom field, which is the field with the lowest index that is not empty
    for (var i = index; i <= state.length - 1; i += 7) {
      if (state[i].status == Status.empty) {
        bottomFieldIndex = i;
      }
    }

    _log.info('Setting coin on index: $bottomFieldIndex');
    final gameBoardField = state[bottomFieldIndex];
    final newGameBoardField = gameBoardField.copyWith(status: Status.filled);

    // replace the old field with the new field
    state = state.map((gameBoardField) {
      if (gameBoardField.index == bottomFieldIndex) {
        return newGameBoardField;
      }
      return gameBoardField;
    }).toList();
  }
}
