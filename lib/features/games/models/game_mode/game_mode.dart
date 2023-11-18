import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_mode.freezed.dart';
part 'game_mode.g.dart';

@freezed
class GameMode with _$GameMode {
  const factory GameMode(int id, {required String name}) = _GameMode;

  factory GameMode.fromJson(Map<String, dynamic> json) => _$GameModeFromJson(json);
}
