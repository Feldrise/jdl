import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_card.freezed.dart';
part 'game_card.g.dart';

@freezed
class GameCard with _$GameCard {
  const factory GameCard(
    int id, {
    required String content,
  }) = _GameCard;

  factory GameCard.fromJson(Map<String, dynamic> json) => _$GameCardFromJson(json);
}
