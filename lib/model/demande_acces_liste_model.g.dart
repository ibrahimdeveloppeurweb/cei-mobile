// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demande_acces_liste_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DemandeAccesListeImpl _$$DemandeAccesListeImplFromJson(
        Map<String, dynamic> json) =>
    _$DemandeAccesListeImpl(
      id: (json['id'] as num).toInt(),
      status: $enumDecodeNullable(_$DemandeStatusEnumMap, json['status']) ??
          DemandeStatus.enAttente,
      typeAcces: $enumDecodeNullable(_$TypeAccesEnumMap, json['typeAcces']) ??
          TypeAcces.lecture,
      typeList: $enumDecodeNullable(_$TypeListEnumMap, json['typeList']),
      motif: json['motif'] as String?,
      dateValidation: json['dateValidation'] == null
          ? null
          : DateTime.parse(json['dateValidation'] as String),
      commentaireValidation: json['commentaireValidation'] as String?,
      dateExpiration: json['dateExpiration'] == null
          ? null
          : DateTime.parse(json['dateExpiration'] as String),
      demandeurId: (json['demandeurId'] as num?)?.toInt(),
      demandeurName: json['demandeurName'] as String?,
      anneeId: (json['anneeId'] as num?)?.toInt(),
      anneeName: json['anneeName'] as String?,
      districtId: (json['districtId'] as num?)?.toInt(),
      districtName: json['districtName'] as String?,
      regionId: (json['regionId'] as num?)?.toInt(),
      regionName: json['regionName'] as String?,
      departementId: (json['departementId'] as num?)?.toInt(),
      departementName: json['departementName'] as String?,
      sousPrefectureId: (json['sousPrefectureId'] as num?)?.toInt(),
      sousPrefectureName: json['sousPrefectureName'] as String?,
      communeId: (json['communeId'] as num?)?.toInt(),
      communeName: json['communeName'] as String?,
      countryId: (json['countryId'] as num?)?.toInt(),
      countryName: json['countryName'] as String?,
      ambassadeId: (json['ambassadeId'] as num?)?.toInt(),
      ambassadeName: json['ambassadeName'] as String?,
      consulatId: (json['consulatId'] as num?)?.toInt(),
      consulatName: json['consulatName'] as String?,
      electeurId: (json['electeurId'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DemandeAccesListeImplToJson(
        _$DemandeAccesListeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$DemandeStatusEnumMap[instance.status]!,
      'typeAcces': _$TypeAccesEnumMap[instance.typeAcces]!,
      'typeList': _$TypeListEnumMap[instance.typeList],
      'motif': instance.motif,
      'dateValidation': instance.dateValidation?.toIso8601String(),
      'commentaireValidation': instance.commentaireValidation,
      'dateExpiration': instance.dateExpiration?.toIso8601String(),
      'demandeurId': instance.demandeurId,
      'demandeurName': instance.demandeurName,
      'anneeId': instance.anneeId,
      'anneeName': instance.anneeName,
      'districtId': instance.districtId,
      'districtName': instance.districtName,
      'regionId': instance.regionId,
      'regionName': instance.regionName,
      'departementId': instance.departementId,
      'departementName': instance.departementName,
      'sousPrefectureId': instance.sousPrefectureId,
      'sousPrefectureName': instance.sousPrefectureName,
      'communeId': instance.communeId,
      'communeName': instance.communeName,
      'countryId': instance.countryId,
      'countryName': instance.countryName,
      'ambassadeId': instance.ambassadeId,
      'ambassadeName': instance.ambassadeName,
      'consulatId': instance.consulatId,
      'consulatName': instance.consulatName,
      'electeurId': instance.electeurId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$DemandeStatusEnumMap = {
  DemandeStatus.enAttente: 'en_attente',
  DemandeStatus.approuvee: 'approuvee',
  DemandeStatus.rejetee: 'rejetee',
};

const _$TypeAccesEnumMap = {
  TypeAcces.lecture: 'lecture',
  TypeAcces.ecriture: 'ecriture',
};

const _$TypeListEnumMap = {
  TypeList.provisoire: 'provisoire',
  TypeList.definitive: 'definitive',
};
