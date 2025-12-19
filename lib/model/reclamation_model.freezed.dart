// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reclamation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReclamationModel _$ReclamationModelFromJson(Map<String, dynamic> json) {
  return _ReclamationModel.fromJson(json);
}

/// @nodoc
mixin _$ReclamationModel {
  int? get id => throw _privateConstructorUsedError;
  String? get type =>
      throw _privateConstructorUsedError; // RADIATION | OMISSION | ERREUR
  String? get motif => throw _privateConstructorUsedError;
  String? get etat =>
      throw _privateConstructorUsedError; // EN ATTENTE | EN COURS | TERMINE
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  String? get personFullName => throw _privateConstructorUsedError;
  int? get personId => throw _privateConstructorUsedError;

  /// Serializes this ReclamationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReclamationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReclamationModelCopyWith<ReclamationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReclamationModelCopyWith<$Res> {
  factory $ReclamationModelCopyWith(
          ReclamationModel value, $Res Function(ReclamationModel) then) =
      _$ReclamationModelCopyWithImpl<$Res, ReclamationModel>;
  @useResult
  $Res call(
      {int? id,
      String? type,
      String? motif,
      String? etat,
      Map<String, dynamic>? data,
      String? personFullName,
      int? personId});
}

/// @nodoc
class _$ReclamationModelCopyWithImpl<$Res, $Val extends ReclamationModel>
    implements $ReclamationModelCopyWith<$Res> {
  _$ReclamationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReclamationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? motif = freezed,
    Object? etat = freezed,
    Object? data = freezed,
    Object? personFullName = freezed,
    Object? personId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      motif: freezed == motif
          ? _value.motif
          : motif // ignore: cast_nullable_to_non_nullable
              as String?,
      etat: freezed == etat
          ? _value.etat
          : etat // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      personFullName: freezed == personFullName
          ? _value.personFullName
          : personFullName // ignore: cast_nullable_to_non_nullable
              as String?,
      personId: freezed == personId
          ? _value.personId
          : personId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReclamationModelImplCopyWith<$Res>
    implements $ReclamationModelCopyWith<$Res> {
  factory _$$ReclamationModelImplCopyWith(_$ReclamationModelImpl value,
          $Res Function(_$ReclamationModelImpl) then) =
      __$$ReclamationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? type,
      String? motif,
      String? etat,
      Map<String, dynamic>? data,
      String? personFullName,
      int? personId});
}

/// @nodoc
class __$$ReclamationModelImplCopyWithImpl<$Res>
    extends _$ReclamationModelCopyWithImpl<$Res, _$ReclamationModelImpl>
    implements _$$ReclamationModelImplCopyWith<$Res> {
  __$$ReclamationModelImplCopyWithImpl(_$ReclamationModelImpl _value,
      $Res Function(_$ReclamationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReclamationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? motif = freezed,
    Object? etat = freezed,
    Object? data = freezed,
    Object? personFullName = freezed,
    Object? personId = freezed,
  }) {
    return _then(_$ReclamationModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      motif: freezed == motif
          ? _value.motif
          : motif // ignore: cast_nullable_to_non_nullable
              as String?,
      etat: freezed == etat
          ? _value.etat
          : etat // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      personFullName: freezed == personFullName
          ? _value.personFullName
          : personFullName // ignore: cast_nullable_to_non_nullable
              as String?,
      personId: freezed == personId
          ? _value.personId
          : personId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReclamationModelImpl implements _ReclamationModel {
  const _$ReclamationModelImpl(
      {this.id,
      this.type,
      this.motif,
      this.etat,
      final Map<String, dynamic>? data,
      this.personFullName,
      this.personId})
      : _data = data;

  factory _$ReclamationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReclamationModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? type;
// RADIATION | OMISSION | ERREUR
  @override
  final String? motif;
  @override
  final String? etat;
// EN ATTENTE | EN COURS | TERMINE
  final Map<String, dynamic>? _data;
// EN ATTENTE | EN COURS | TERMINE
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? personFullName;
  @override
  final int? personId;

  @override
  String toString() {
    return 'ReclamationModel(id: $id, type: $type, motif: $motif, etat: $etat, data: $data, personFullName: $personFullName, personId: $personId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReclamationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.motif, motif) || other.motif == motif) &&
            (identical(other.etat, etat) || other.etat == etat) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.personFullName, personFullName) ||
                other.personFullName == personFullName) &&
            (identical(other.personId, personId) ||
                other.personId == personId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, motif, etat,
      const DeepCollectionEquality().hash(_data), personFullName, personId);

  /// Create a copy of ReclamationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReclamationModelImplCopyWith<_$ReclamationModelImpl> get copyWith =>
      __$$ReclamationModelImplCopyWithImpl<_$ReclamationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReclamationModelImplToJson(
      this,
    );
  }
}

abstract class _ReclamationModel implements ReclamationModel {
  const factory _ReclamationModel(
      {final int? id,
      final String? type,
      final String? motif,
      final String? etat,
      final Map<String, dynamic>? data,
      final String? personFullName,
      final int? personId}) = _$ReclamationModelImpl;

  factory _ReclamationModel.fromJson(Map<String, dynamic> json) =
      _$ReclamationModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get type; // RADIATION | OMISSION | ERREUR
  @override
  String? get motif;
  @override
  String? get etat; // EN ATTENTE | EN COURS | TERMINE
  @override
  Map<String, dynamic>? get data;
  @override
  String? get personFullName;
  @override
  int? get personId;

  /// Create a copy of ReclamationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReclamationModelImplCopyWith<_$ReclamationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
