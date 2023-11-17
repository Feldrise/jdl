// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameCard _$GameCardFromJson(Map<String, dynamic> json) {
  return _GameCard.fromJson(json);
}

/// @nodoc
mixin _$GameCard {
  int get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCardCopyWith<GameCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCardCopyWith<$Res> {
  factory $GameCardCopyWith(GameCard value, $Res Function(GameCard) then) =
      _$GameCardCopyWithImpl<$Res, GameCard>;
  @useResult
  $Res call({int id, String content});
}

/// @nodoc
class _$GameCardCopyWithImpl<$Res, $Val extends GameCard>
    implements $GameCardCopyWith<$Res> {
  _$GameCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameCardImplCopyWith<$Res>
    implements $GameCardCopyWith<$Res> {
  factory _$$GameCardImplCopyWith(
          _$GameCardImpl value, $Res Function(_$GameCardImpl) then) =
      __$$GameCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String content});
}

/// @nodoc
class __$$GameCardImplCopyWithImpl<$Res>
    extends _$GameCardCopyWithImpl<$Res, _$GameCardImpl>
    implements _$$GameCardImplCopyWith<$Res> {
  __$$GameCardImplCopyWithImpl(
      _$GameCardImpl _value, $Res Function(_$GameCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
  }) {
    return _then(_$GameCardImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameCardImpl implements _GameCard {
  const _$GameCardImpl(this.id, {required this.content});

  factory _$GameCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameCardImplFromJson(json);

  @override
  final int id;
  @override
  final String content;

  @override
  String toString() {
    return 'GameCard(id: $id, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameCardImplCopyWith<_$GameCardImpl> get copyWith =>
      __$$GameCardImplCopyWithImpl<_$GameCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameCardImplToJson(
      this,
    );
  }
}

abstract class _GameCard implements GameCard {
  const factory _GameCard(final int id, {required final String content}) =
      _$GameCardImpl;

  factory _GameCard.fromJson(Map<String, dynamic> json) =
      _$GameCardImpl.fromJson;

  @override
  int get id;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$GameCardImplCopyWith<_$GameCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
