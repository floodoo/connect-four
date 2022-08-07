import 'package:connect_four/enums/player.enum.dart';
import 'package:connect_four/models/game_board_field.dart';
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
