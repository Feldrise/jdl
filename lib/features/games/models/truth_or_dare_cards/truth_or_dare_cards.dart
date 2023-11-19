import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:masoiree/features/games/models/game_card/game_card.dart';

part 'truth_or_dare_cards.freezed.dart';
part 'truth_or_dare_cards.g.dart';

@freezed
class TruthOrDareCards with _$TruthOrDareCards {
  const factory TruthOrDareCards({
    @JsonKey(name: "truth_cards") required List<GameCard> truth,
    @JsonKey(name: "dare_cards") required List<GameCard> dare,
  }) = _TruthOrDareCards;

  factory TruthOrDareCards.fromJson(Map<String, dynamic> json) => _$TruthOrDareCardsFromJson(json);
}
