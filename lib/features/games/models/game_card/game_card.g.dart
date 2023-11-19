// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameCardImpl _$$GameCardImplFromJson(Map<String, dynamic> json) =>
    _$GameCardImpl(
      json['id'] as int,
      content: json['content'] as String,
      type: json['type'] as String?,
      modes: (json['modes'] as List<dynamic>?)
              ?.map((e) => GameMode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GameMode>[],
    );

Map<String, dynamic> _$$GameCardImplToJson(_$GameCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': instance.type,
      'modes': instance.modes,
    };
