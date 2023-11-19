// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'truth_or_dare_cards.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TruthOrDareCards _$TruthOrDareCardsFromJson(Map<String, dynamic> json) {
  return _TruthOrDareCards.fromJson(json);
}

/// @nodoc
mixin _$TruthOrDareCards {
  @JsonKey(name: "truth_cards")
  List<GameCard> get truth => throw _privateConstructorUsedError;
  @JsonKey(name: "dare_cards")
  List<GameCard> get dare => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TruthOrDareCardsCopyWith<TruthOrDareCards> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TruthOrDareCardsCopyWith<$Res> {
  factory $TruthOrDareCardsCopyWith(
          TruthOrDareCards value, $Res Function(TruthOrDareCards) then) =
      _$TruthOrDareCardsCopyWithImpl<$Res, TruthOrDareCards>;
  @useResult
  $Res call(
      {@JsonKey(name: "truth_cards") List<GameCard> truth,
      @JsonKey(name: "dare_cards") List<GameCard> dare});
}

/// @nodoc
class _$TruthOrDareCardsCopyWithImpl<$Res, $Val extends TruthOrDareCards>
    implements $TruthOrDareCardsCopyWith<$Res> {
  _$TruthOrDareCardsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? truth = null,
    Object? dare = null,
  }) {
    return _then(_value.copyWith(
      truth: null == truth
          ? _value.truth
          : truth // ignore: cast_nullable_to_non_nullable
              as List<GameCard>,
      dare: null == dare
          ? _value.dare
          : dare // ignore: cast_nullable_to_non_nullable
              as List<GameCard>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TruthOrDareCardsImplCopyWith<$Res>
    implements $TruthOrDareCardsCopyWith<$Res> {
  factory _$$TruthOrDareCardsImplCopyWith(_$TruthOrDareCardsImpl value,
          $Res Function(_$TruthOrDareCardsImpl) then) =
      __$$TruthOrDareCardsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "truth_cards") List<GameCard> truth,
      @JsonKey(name: "dare_cards") List<GameCard> dare});
}

/// @nodoc
class __$$TruthOrDareCardsImplCopyWithImpl<$Res>
    extends _$TruthOrDareCardsCopyWithImpl<$Res, _$TruthOrDareCardsImpl>
    implements _$$TruthOrDareCardsImplCopyWith<$Res> {
  __$$TruthOrDareCardsImplCopyWithImpl(_$TruthOrDareCardsImpl _value,
      $Res Function(_$TruthOrDareCardsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? truth = null,
    Object? dare = null,
  }) {
    return _then(_$TruthOrDareCardsImpl(
      truth: null == truth
          ? _value._truth
          : truth // ignore: cast_nullable_to_non_nullable
              as List<GameCard>,
      dare: null == dare
          ? _value._dare
          : dare // ignore: cast_nullable_to_non_nullable
              as List<GameCard>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TruthOrDareCardsImpl implements _TruthOrDareCards {
  const _$TruthOrDareCardsImpl(
      {@JsonKey(name: "truth_cards") required final List<GameCard> truth,
      @JsonKey(name: "dare_cards") required final List<GameCard> dare})
      : _truth = truth,
        _dare = dare;

  factory _$TruthOrDareCardsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TruthOrDareCardsImplFromJson(json);

  final List<GameCard> _truth;
  @override
  @JsonKey(name: "truth_cards")
  List<GameCard> get truth {
    if (_truth is EqualUnmodifiableListView) return _truth;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_truth);
  }

  final List<GameCard> _dare;
  @override
  @JsonKey(name: "dare_cards")
  List<GameCard> get dare {
    if (_dare is EqualUnmodifiableListView) return _dare;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dare);
  }

  @override
  String toString() {
    return 'TruthOrDareCards(truth: $truth, dare: $dare)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TruthOrDareCardsImpl &&
            const DeepCollectionEquality().equals(other._truth, _truth) &&
            const DeepCollectionEquality().equals(other._dare, _dare));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_truth),
      const DeepCollectionEquality().hash(_dare));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TruthOrDareCardsImplCopyWith<_$TruthOrDareCardsImpl> get copyWith =>
      __$$TruthOrDareCardsImplCopyWithImpl<_$TruthOrDareCardsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TruthOrDareCardsImplToJson(
      this,
    );
  }
}

abstract class _TruthOrDareCards implements TruthOrDareCards {
  const factory _TruthOrDareCards(
          {@JsonKey(name: "truth_cards") required final List<GameCard> truth,
          @JsonKey(name: "dare_cards") required final List<GameCard> dare}) =
      _$TruthOrDareCardsImpl;

  factory _TruthOrDareCards.fromJson(Map<String, dynamic> json) =
      _$TruthOrDareCardsImpl.fromJson;

  @override
  @JsonKey(name: "truth_cards")
  List<GameCard> get truth;
  @override
  @JsonKey(name: "dare_cards")
  List<GameCard> get dare;
  @override
  @JsonKey(ignore: true)
  _$$TruthOrDareCardsImplCopyWith<_$TruthOrDareCardsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
