// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_mode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameMode _$GameModeFromJson(Map<String, dynamic> json) {
  return _GameMode.fromJson(json);
}

/// @nodoc
mixin _$GameMode {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameModeCopyWith<GameMode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameModeCopyWith<$Res> {
  factory $GameModeCopyWith(GameMode value, $Res Function(GameMode) then) =
      _$GameModeCopyWithImpl<$Res, GameMode>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$GameModeCopyWithImpl<$Res, $Val extends GameMode>
    implements $GameModeCopyWith<$Res> {
  _$GameModeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameModeImplCopyWith<$Res>
    implements $GameModeCopyWith<$Res> {
  factory _$$GameModeImplCopyWith(
          _$GameModeImpl value, $Res Function(_$GameModeImpl) then) =
      __$$GameModeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$GameModeImplCopyWithImpl<$Res>
    extends _$GameModeCopyWithImpl<$Res, _$GameModeImpl>
    implements _$$GameModeImplCopyWith<$Res> {
  __$$GameModeImplCopyWithImpl(
      _$GameModeImpl _value, $Res Function(_$GameModeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$GameModeImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameModeImpl implements _GameMode {
  const _$GameModeImpl(this.id, {required this.name});

  factory _$GameModeImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameModeImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'GameMode(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameModeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameModeImplCopyWith<_$GameModeImpl> get copyWith =>
      __$$GameModeImplCopyWithImpl<_$GameModeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameModeImplToJson(
      this,
    );
  }
}

abstract class _GameMode implements GameMode {
  const factory _GameMode(final int id, {required final String name}) =
      _$GameModeImpl;

  factory _GameMode.fromJson(Map<String, dynamic> json) =
      _$GameModeImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$GameModeImplCopyWith<_$GameModeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
