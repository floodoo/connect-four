import 'package:four_wins/enums/game_board_field.enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../pages/game_board/game_board_field.model.freezed.dart';
part '../pages/game_board/game_board_field.model.g.dart';

@freezed
class GameBoardFieldModel with _$GameBoardFieldModel {
  const GameBoardFieldModel._();

  const factory GameBoardFieldModel({
    required int index,
    required Status status,
  }) = _GameBoardFieldModel;

  factory GameBoardFieldModel.fromJson(Map<String, dynamic> json) => _$GameBoardFieldModelFromJson(json);
}
