// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demande_acces_liste_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DemandeAccesListe _$DemandeAccesListeFromJson(Map<String, dynamic> json) {
  return _DemandeAccesListe.fromJson(json);
}

/// @nodoc
mixin _$DemandeAccesListe {
  int get id => throw _privateConstructorUsedError;
  DemandeStatus get status => throw _privateConstructorUsedError;
  TypeAcces get typeAcces => throw _privateConstructorUsedError;
  TypeList? get typeList => throw _privateConstructorUsedError;
  String? get motif => throw _privateConstructorUsedError;
  DateTime? get dateValidation => throw _privateConstructorUsedError;
  String? get commentaireValidation => throw _privateConstructorUsedError;
  DateTime? get dateExpiration =>
      throw _privateConstructorUsedError; // Relations
  int? get demandeurId => throw _privateConstructorUsedError;
  String? get demandeurName => throw _privateConstructorUsedError;
  int? get anneeId => throw _privateConstructorUsedError;
  String? get anneeName => throw _privateConstructorUsedError;
  int? get districtId => throw _privateConstructorUsedError;
  String? get districtName => throw _privateConstructorUsedError;
  int? get regionId => throw _privateConstructorUsedError;
  String? get regionName => throw _privateConstructorUsedError;
  int? get departementId => throw _privateConstructorUsedError;
  String? get departementName => throw _privateConstructorUsedError;
  int? get sousPrefectureId => throw _privateConstructorUsedError;
  String? get sousPrefectureName => throw _privateConstructorUsedError;
  int? get communeId => throw _privateConstructorUsedError;
  String? get communeName => throw _privateConstructorUsedError;
  int? get countryId => throw _privateConstructorUsedError;
  String? get countryName => throw _privateConstructorUsedError;
  int? get ambassadeId => throw _privateConstructorUsedError;
  String? get ambassadeName => throw _privateConstructorUsedError;
  int? get consulatId => throw _privateConstructorUsedError;
  String? get consulatName => throw _privateConstructorUsedError;
  int? get electeurId =>
      throw _privateConstructorUsedError; // Timestamps (if needed)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DemandeAccesListe to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DemandeAccesListe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DemandeAccesListeCopyWith<DemandeAccesListe> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemandeAccesListeCopyWith<$Res> {
  factory $DemandeAccesListeCopyWith(
          DemandeAccesListe value, $Res Function(DemandeAccesListe) then) =
      _$DemandeAccesListeCopyWithImpl<$Res, DemandeAccesListe>;
  @useResult
  $Res call(
      {int id,
      DemandeStatus status,
      TypeAcces typeAcces,
      TypeList? typeList,
      String? motif,
      DateTime? dateValidation,
      String? commentaireValidation,
      DateTime? dateExpiration,
      int? demandeurId,
      String? demandeurName,
      int? anneeId,
      String? anneeName,
      int? districtId,
      String? districtName,
      int? regionId,
      String? regionName,
      int? departementId,
      String? departementName,
      int? sousPrefectureId,
      String? sousPrefectureName,
      int? communeId,
      String? communeName,
      int? countryId,
      String? countryName,
      int? ambassadeId,
      String? ambassadeName,
      int? consulatId,
      String? consulatName,
      int? electeurId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$DemandeAccesListeCopyWithImpl<$Res, $Val extends DemandeAccesListe>
    implements $DemandeAccesListeCopyWith<$Res> {
  _$DemandeAccesListeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DemandeAccesListe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? typeAcces = null,
    Object? typeList = freezed,
    Object? motif = freezed,
    Object? dateValidation = freezed,
    Object? commentaireValidation = freezed,
    Object? dateExpiration = freezed,
    Object? demandeurId = freezed,
    Object? demandeurName = freezed,
    Object? anneeId = freezed,
    Object? anneeName = freezed,
    Object? districtId = freezed,
    Object? districtName = freezed,
    Object? regionId = freezed,
    Object? regionName = freezed,
    Object? departementId = freezed,
    Object? departementName = freezed,
    Object? sousPrefectureId = freezed,
    Object? sousPrefectureName = freezed,
    Object? communeId = freezed,
    Object? communeName = freezed,
    Object? countryId = freezed,
    Object? countryName = freezed,
    Object? ambassadeId = freezed,
    Object? ambassadeName = freezed,
    Object? consulatId = freezed,
    Object? consulatName = freezed,
    Object? electeurId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DemandeStatus,
      typeAcces: null == typeAcces
          ? _value.typeAcces
          : typeAcces // ignore: cast_nullable_to_non_nullable
              as TypeAcces,
      typeList: freezed == typeList
          ? _value.typeList
          : typeList // ignore: cast_nullable_to_non_nullable
              as TypeList?,
      motif: freezed == motif
          ? _value.motif
          : motif // ignore: cast_nullable_to_non_nullable
              as String?,
      dateValidation: freezed == dateValidation
          ? _value.dateValidation
          : dateValidation // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      commentaireValidation: freezed == commentaireValidation
          ? _value.commentaireValidation
          : commentaireValidation // ignore: cast_nullable_to_non_nullable
              as String?,
      dateExpiration: freezed == dateExpiration
          ? _value.dateExpiration
          : dateExpiration // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      demandeurId: freezed == demandeurId
          ? _value.demandeurId
          : demandeurId // ignore: cast_nullable_to_non_nullable
              as int?,
      demandeurName: freezed == demandeurName
          ? _value.demandeurName
          : demandeurName // ignore: cast_nullable_to_non_nullable
              as String?,
      anneeId: freezed == anneeId
          ? _value.anneeId
          : anneeId // ignore: cast_nullable_to_non_nullable
              as int?,
      anneeName: freezed == anneeName
          ? _value.anneeName
          : anneeName // ignore: cast_nullable_to_non_nullable
              as String?,
      districtId: freezed == districtId
          ? _value.districtId
          : districtId // ignore: cast_nullable_to_non_nullable
              as int?,
      districtName: freezed == districtName
          ? _value.districtName
          : districtName // ignore: cast_nullable_to_non_nullable
              as String?,
      regionId: freezed == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int?,
      regionName: freezed == regionName
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String?,
      departementId: freezed == departementId
          ? _value.departementId
          : departementId // ignore: cast_nullable_to_non_nullable
              as int?,
      departementName: freezed == departementName
          ? _value.departementName
          : departementName // ignore: cast_nullable_to_non_nullable
              as String?,
      sousPrefectureId: freezed == sousPrefectureId
          ? _value.sousPrefectureId
          : sousPrefectureId // ignore: cast_nullable_to_non_nullable
              as int?,
      sousPrefectureName: freezed == sousPrefectureName
          ? _value.sousPrefectureName
          : sousPrefectureName // ignore: cast_nullable_to_non_nullable
              as String?,
      communeId: freezed == communeId
          ? _value.communeId
          : communeId // ignore: cast_nullable_to_non_nullable
              as int?,
      communeName: freezed == communeName
          ? _value.communeName
          : communeName // ignore: cast_nullable_to_non_nullable
              as String?,
      countryId: freezed == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int?,
      countryName: freezed == countryName
          ? _value.countryName
          : countryName // ignore: cast_nullable_to_non_nullable
              as String?,
      ambassadeId: freezed == ambassadeId
          ? _value.ambassadeId
          : ambassadeId // ignore: cast_nullable_to_non_nullable
              as int?,
      ambassadeName: freezed == ambassadeName
          ? _value.ambassadeName
          : ambassadeName // ignore: cast_nullable_to_non_nullable
              as String?,
      consulatId: freezed == consulatId
          ? _value.consulatId
          : consulatId // ignore: cast_nullable_to_non_nullable
              as int?,
      consulatName: freezed == consulatName
          ? _value.consulatName
          : consulatName // ignore: cast_nullable_to_non_nullable
              as String?,
      electeurId: freezed == electeurId
          ? _value.electeurId
          : electeurId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DemandeAccesListeImplCopyWith<$Res>
    implements $DemandeAccesListeCopyWith<$Res> {
  factory _$$DemandeAccesListeImplCopyWith(_$DemandeAccesListeImpl value,
          $Res Function(_$DemandeAccesListeImpl) then) =
      __$$DemandeAccesListeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DemandeStatus status,
      TypeAcces typeAcces,
      TypeList? typeList,
      String? motif,
      DateTime? dateValidation,
      String? commentaireValidation,
      DateTime? dateExpiration,
      int? demandeurId,
      String? demandeurName,
      int? anneeId,
      String? anneeName,
      int? districtId,
      String? districtName,
      int? regionId,
      String? regionName,
      int? departementId,
      String? departementName,
      int? sousPrefectureId,
      String? sousPrefectureName,
      int? communeId,
      String? communeName,
      int? countryId,
      String? countryName,
      int? ambassadeId,
      String? ambassadeName,
      int? consulatId,
      String? consulatName,
      int? electeurId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$DemandeAccesListeImplCopyWithImpl<$Res>
    extends _$DemandeAccesListeCopyWithImpl<$Res, _$DemandeAccesListeImpl>
    implements _$$DemandeAccesListeImplCopyWith<$Res> {
  __$$DemandeAccesListeImplCopyWithImpl(_$DemandeAccesListeImpl _value,
      $Res Function(_$DemandeAccesListeImpl) _then)
      : super(_value, _then);

  /// Create a copy of DemandeAccesListe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? typeAcces = null,
    Object? typeList = freezed,
    Object? motif = freezed,
    Object? dateValidation = freezed,
    Object? commentaireValidation = freezed,
    Object? dateExpiration = freezed,
    Object? demandeurId = freezed,
    Object? demandeurName = freezed,
    Object? anneeId = freezed,
    Object? anneeName = freezed,
    Object? districtId = freezed,
    Object? districtName = freezed,
    Object? regionId = freezed,
    Object? regionName = freezed,
    Object? departementId = freezed,
    Object? departementName = freezed,
    Object? sousPrefectureId = freezed,
    Object? sousPrefectureName = freezed,
    Object? communeId = freezed,
    Object? communeName = freezed,
    Object? countryId = freezed,
    Object? countryName = freezed,
    Object? ambassadeId = freezed,
    Object? ambassadeName = freezed,
    Object? consulatId = freezed,
    Object? consulatName = freezed,
    Object? electeurId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DemandeAccesListeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DemandeStatus,
      typeAcces: null == typeAcces
          ? _value.typeAcces
          : typeAcces // ignore: cast_nullable_to_non_nullable
              as TypeAcces,
      typeList: freezed == typeList
          ? _value.typeList
          : typeList // ignore: cast_nullable_to_non_nullable
              as TypeList?,
      motif: freezed == motif
          ? _value.motif
          : motif // ignore: cast_nullable_to_non_nullable
              as String?,
      dateValidation: freezed == dateValidation
          ? _value.dateValidation
          : dateValidation // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      commentaireValidation: freezed == commentaireValidation
          ? _value.commentaireValidation
          : commentaireValidation // ignore: cast_nullable_to_non_nullable
              as String?,
      dateExpiration: freezed == dateExpiration
          ? _value.dateExpiration
          : dateExpiration // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      demandeurId: freezed == demandeurId
          ? _value.demandeurId
          : demandeurId // ignore: cast_nullable_to_non_nullable
              as int?,
      demandeurName: freezed == demandeurName
          ? _value.demandeurName
          : demandeurName // ignore: cast_nullable_to_non_nullable
              as String?,
      anneeId: freezed == anneeId
          ? _value.anneeId
          : anneeId // ignore: cast_nullable_to_non_nullable
              as int?,
      anneeName: freezed == anneeName
          ? _value.anneeName
          : anneeName // ignore: cast_nullable_to_non_nullable
              as String?,
      districtId: freezed == districtId
          ? _value.districtId
          : districtId // ignore: cast_nullable_to_non_nullable
              as int?,
      districtName: freezed == districtName
          ? _value.districtName
          : districtName // ignore: cast_nullable_to_non_nullable
              as String?,
      regionId: freezed == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int?,
      regionName: freezed == regionName
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String?,
      departementId: freezed == departementId
          ? _value.departementId
          : departementId // ignore: cast_nullable_to_non_nullable
              as int?,
      departementName: freezed == departementName
          ? _value.departementName
          : departementName // ignore: cast_nullable_to_non_nullable
              as String?,
      sousPrefectureId: freezed == sousPrefectureId
          ? _value.sousPrefectureId
          : sousPrefectureId // ignore: cast_nullable_to_non_nullable
              as int?,
      sousPrefectureName: freezed == sousPrefectureName
          ? _value.sousPrefectureName
          : sousPrefectureName // ignore: cast_nullable_to_non_nullable
              as String?,
      communeId: freezed == communeId
          ? _value.communeId
          : communeId // ignore: cast_nullable_to_non_nullable
              as int?,
      communeName: freezed == communeName
          ? _value.communeName
          : communeName // ignore: cast_nullable_to_non_nullable
              as String?,
      countryId: freezed == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as int?,
      countryName: freezed == countryName
          ? _value.countryName
          : countryName // ignore: cast_nullable_to_non_nullable
              as String?,
      ambassadeId: freezed == ambassadeId
          ? _value.ambassadeId
          : ambassadeId // ignore: cast_nullable_to_non_nullable
              as int?,
      ambassadeName: freezed == ambassadeName
          ? _value.ambassadeName
          : ambassadeName // ignore: cast_nullable_to_non_nullable
              as String?,
      consulatId: freezed == consulatId
          ? _value.consulatId
          : consulatId // ignore: cast_nullable_to_non_nullable
              as int?,
      consulatName: freezed == consulatName
          ? _value.consulatName
          : consulatName // ignore: cast_nullable_to_non_nullable
              as String?,
      electeurId: freezed == electeurId
          ? _value.electeurId
          : electeurId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DemandeAccesListeImpl implements _DemandeAccesListe {
  const _$DemandeAccesListeImpl(
      {required this.id,
      this.status = DemandeStatus.enAttente,
      this.typeAcces = TypeAcces.lecture,
      this.typeList,
      this.motif,
      this.dateValidation,
      this.commentaireValidation,
      this.dateExpiration,
      this.demandeurId,
      this.demandeurName,
      this.anneeId,
      this.anneeName,
      this.districtId,
      this.districtName,
      this.regionId,
      this.regionName,
      this.departementId,
      this.departementName,
      this.sousPrefectureId,
      this.sousPrefectureName,
      this.communeId,
      this.communeName,
      this.countryId,
      this.countryName,
      this.ambassadeId,
      this.ambassadeName,
      this.consulatId,
      this.consulatName,
      this.electeurId,
      this.createdAt,
      this.updatedAt});

  factory _$DemandeAccesListeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DemandeAccesListeImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final DemandeStatus status;
  @override
  @JsonKey()
  final TypeAcces typeAcces;
  @override
  final TypeList? typeList;
  @override
  final String? motif;
  @override
  final DateTime? dateValidation;
  @override
  final String? commentaireValidation;
  @override
  final DateTime? dateExpiration;
// Relations
  @override
  final int? demandeurId;
  @override
  final String? demandeurName;
  @override
  final int? anneeId;
  @override
  final String? anneeName;
  @override
  final int? districtId;
  @override
  final String? districtName;
  @override
  final int? regionId;
  @override
  final String? regionName;
  @override
  final int? departementId;
  @override
  final String? departementName;
  @override
  final int? sousPrefectureId;
  @override
  final String? sousPrefectureName;
  @override
  final int? communeId;
  @override
  final String? communeName;
  @override
  final int? countryId;
  @override
  final String? countryName;
  @override
  final int? ambassadeId;
  @override
  final String? ambassadeName;
  @override
  final int? consulatId;
  @override
  final String? consulatName;
  @override
  final int? electeurId;
// Timestamps (if needed)
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'DemandeAccesListe(id: $id, status: $status, typeAcces: $typeAcces, typeList: $typeList, motif: $motif, dateValidation: $dateValidation, commentaireValidation: $commentaireValidation, dateExpiration: $dateExpiration, demandeurId: $demandeurId, demandeurName: $demandeurName, anneeId: $anneeId, anneeName: $anneeName, districtId: $districtId, districtName: $districtName, regionId: $regionId, regionName: $regionName, departementId: $departementId, departementName: $departementName, sousPrefectureId: $sousPrefectureId, sousPrefectureName: $sousPrefectureName, communeId: $communeId, communeName: $communeName, countryId: $countryId, countryName: $countryName, ambassadeId: $ambassadeId, ambassadeName: $ambassadeName, consulatId: $consulatId, consulatName: $consulatName, electeurId: $electeurId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemandeAccesListeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.typeAcces, typeAcces) ||
                other.typeAcces == typeAcces) &&
            (identical(other.typeList, typeList) ||
                other.typeList == typeList) &&
            (identical(other.motif, motif) || other.motif == motif) &&
            (identical(other.dateValidation, dateValidation) ||
                other.dateValidation == dateValidation) &&
            (identical(other.commentaireValidation, commentaireValidation) ||
                other.commentaireValidation == commentaireValidation) &&
            (identical(other.dateExpiration, dateExpiration) ||
                other.dateExpiration == dateExpiration) &&
            (identical(other.demandeurId, demandeurId) ||
                other.demandeurId == demandeurId) &&
            (identical(other.demandeurName, demandeurName) ||
                other.demandeurName == demandeurName) &&
            (identical(other.anneeId, anneeId) || other.anneeId == anneeId) &&
            (identical(other.anneeName, anneeName) ||
                other.anneeName == anneeName) &&
            (identical(other.districtId, districtId) ||
                other.districtId == districtId) &&
            (identical(other.districtName, districtName) ||
                other.districtName == districtName) &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId) &&
            (identical(other.regionName, regionName) ||
                other.regionName == regionName) &&
            (identical(other.departementId, departementId) ||
                other.departementId == departementId) &&
            (identical(other.departementName, departementName) ||
                other.departementName == departementName) &&
            (identical(other.sousPrefectureId, sousPrefectureId) ||
                other.sousPrefectureId == sousPrefectureId) &&
            (identical(other.sousPrefectureName, sousPrefectureName) ||
                other.sousPrefectureName == sousPrefectureName) &&
            (identical(other.communeId, communeId) ||
                other.communeId == communeId) &&
            (identical(other.communeName, communeName) ||
                other.communeName == communeName) &&
            (identical(other.countryId, countryId) ||
                other.countryId == countryId) &&
            (identical(other.countryName, countryName) ||
                other.countryName == countryName) &&
            (identical(other.ambassadeId, ambassadeId) ||
                other.ambassadeId == ambassadeId) &&
            (identical(other.ambassadeName, ambassadeName) ||
                other.ambassadeName == ambassadeName) &&
            (identical(other.consulatId, consulatId) ||
                other.consulatId == consulatId) &&
            (identical(other.consulatName, consulatName) ||
                other.consulatName == consulatName) &&
            (identical(other.electeurId, electeurId) ||
                other.electeurId == electeurId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        status,
        typeAcces,
        typeList,
        motif,
        dateValidation,
        commentaireValidation,
        dateExpiration,
        demandeurId,
        demandeurName,
        anneeId,
        anneeName,
        districtId,
        districtName,
        regionId,
        regionName,
        departementId,
        departementName,
        sousPrefectureId,
        sousPrefectureName,
        communeId,
        communeName,
        countryId,
        countryName,
        ambassadeId,
        ambassadeName,
        consulatId,
        consulatName,
        electeurId,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of DemandeAccesListe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DemandeAccesListeImplCopyWith<_$DemandeAccesListeImpl> get copyWith =>
      __$$DemandeAccesListeImplCopyWithImpl<_$DemandeAccesListeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DemandeAccesListeImplToJson(
      this,
    );
  }
}

abstract class _DemandeAccesListe implements DemandeAccesListe {
  const factory _DemandeAccesListe(
      {required final int id,
      final DemandeStatus status,
      final TypeAcces typeAcces,
      final TypeList? typeList,
      final String? motif,
      final DateTime? dateValidation,
      final String? commentaireValidation,
      final DateTime? dateExpiration,
      final int? demandeurId,
      final String? demandeurName,
      final int? anneeId,
      final String? anneeName,
      final int? districtId,
      final String? districtName,
      final int? regionId,
      final String? regionName,
      final int? departementId,
      final String? departementName,
      final int? sousPrefectureId,
      final String? sousPrefectureName,
      final int? communeId,
      final String? communeName,
      final int? countryId,
      final String? countryName,
      final int? ambassadeId,
      final String? ambassadeName,
      final int? consulatId,
      final String? consulatName,
      final int? electeurId,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$DemandeAccesListeImpl;

  factory _DemandeAccesListe.fromJson(Map<String, dynamic> json) =
      _$DemandeAccesListeImpl.fromJson;

  @override
  int get id;
  @override
  DemandeStatus get status;
  @override
  TypeAcces get typeAcces;
  @override
  TypeList? get typeList;
  @override
  String? get motif;
  @override
  DateTime? get dateValidation;
  @override
  String? get commentaireValidation;
  @override
  DateTime? get dateExpiration; // Relations
  @override
  int? get demandeurId;
  @override
  String? get demandeurName;
  @override
  int? get anneeId;
  @override
  String? get anneeName;
  @override
  int? get districtId;
  @override
  String? get districtName;
  @override
  int? get regionId;
  @override
  String? get regionName;
  @override
  int? get departementId;
  @override
  String? get departementName;
  @override
  int? get sousPrefectureId;
  @override
  String? get sousPrefectureName;
  @override
  int? get communeId;
  @override
  String? get communeName;
  @override
  int? get countryId;
  @override
  String? get countryName;
  @override
  int? get ambassadeId;
  @override
  String? get ambassadeName;
  @override
  int? get consulatId;
  @override
  String? get consulatName;
  @override
  int? get electeurId; // Timestamps (if needed)
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of DemandeAccesListe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DemandeAccesListeImplCopyWith<_$DemandeAccesListeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
