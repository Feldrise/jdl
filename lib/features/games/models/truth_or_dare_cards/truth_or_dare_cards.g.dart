// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truth_or_dare_cards.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TruthOrDareCardsImpl _$$TruthOrDareCardsImplFromJson(
        Map<String, dynamic> json) =>
    _$TruthOrDareCardsImpl(
      truth: (json['truth_cards'] as List<dynamic>)
          .map((e) => GameCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      dare: (json['dare_cards'] as List<dynamic>)
          .map((e) => GameCard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TruthOrDareCardsImplToJson(
        _$TruthOrDareCardsImpl instance) =>
    <String, dynamic>{
      'truth_cards': instance.truth,
      'dare_cards': instance.dare,
    };
