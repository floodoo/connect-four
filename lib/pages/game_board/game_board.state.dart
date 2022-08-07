import 'package:four_wins/enums/player.enum.dart';
import 'package:four_wins/models/game_board_field.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_board.state.freezed.dart';

@freezed
class GameBoardState with _$GameBoardState {
  factory GameBoardState({
    @Default([]) List<GameBoardField> gameBoardFieldList,
    @Default(Player.player1) Player player,
    @Default(false) bool won,
    Player? winner,
  }) = _GameBoardState;
}
