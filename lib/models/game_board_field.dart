import 'package:connect_four/enums/game_board_field.enum.dart';
import 'package:connect_four/enums/player.enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_board_field.freezed.dart';
part 'game_board_field.g.dart';

@freezed
class GameBoardField with _$GameBoardField {
  const GameBoardField._();

  const factory GameBoardField({
    required int index,
    required Status status,
    Player? player,
  }) = _GameBoardFieldModel;

  factory GameBoardField.fromJson(Map<String, dynamic> json) => _$GameBoardFieldFromJson(json);
}
