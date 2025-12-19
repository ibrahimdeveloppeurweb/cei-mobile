// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reclamation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReclamationModelImpl _$$ReclamationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReclamationModelImpl(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      motif: json['motif'] as String?,
      etat: json['etat'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      personFullName: json['personFullName'] as String?,
      personId: (json['personId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ReclamationModelImplToJson(
        _$ReclamationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'motif': instance.motif,
      'etat': instance.etat,
      'data': instance.data,
      'personFullName': instance.personFullName,
      'personId': instance.personId,
    };
