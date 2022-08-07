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

  static final Logger _log = Logger('game_board.controller.dart');

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
    final gameBoardField = state[index];
    final newGameBoardField = gameBoardField.copyWith(status: Status.filled);
    state = state.map((gameBoardField) {
      if (gameBoardField.index == index) {
        return newGameBoardField;
      }
      return gameBoardField;
    }).toList();
  }
}
