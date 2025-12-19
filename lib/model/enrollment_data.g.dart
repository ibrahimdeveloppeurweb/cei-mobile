// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EnrollmentDataImpl _$$EnrollmentDataImplFromJson(Map<String, dynamic> json) =>
    _$EnrollmentDataImpl(
      id: (json['id'] as num?)?.toInt(),
      dateEnrolement: json['dateEnrolement'] == null
          ? null
          : DateTime.parse(json['dateEnrolement'] as String),
      dateValidation: json['dateValidation'] == null
          ? null
          : DateTime.parse(json['dateValidation'] as String),
      status: json['status'] as String?,
      motifRejet: json['motifRejet'] as String?,
      numOrder: json['numOrder'] as String?,
      numForm: json['numForm'] as String?,
      numCarte: json['numCarte'] as String?,
      typeCarte: json['typeCarte'] as String?,
      expireDateCarte: json['expireDateCarte'] == null
          ? null
          : DateTime.parse(json['expireDateCarte'] as String),
      deleveryDateCarte: json['deleveryDateCarte'] == null
          ? null
          : DateTime.parse(json['deleveryDateCarte'] as String),
      numEnregister: json['numEnregister'] as String?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      birthplace: json['birthplace'] as String?,
      gender: json['gender'] as String?,
      profession: json['profession'] as String?,
      address: json['address'] as String?,
      lastNameFather: json['lastNameFather'] as String?,
      firstNameFather: json['firstNameFather'] as String?,
      birthdateFather: json['birthdateFather'] == null
          ? null
          : DateTime.parse(json['birthdateFather'] as String),
      birthplaceFather: json['birthplaceFather'] as String?,
      lastNameMother: json['lastNameMother'] as String?,
      firstNameMother: json['firstNameMother'] as String?,
      birthdateMother: json['birthdateMother'] == null
          ? null
          : DateTime.parse(json['birthdateMother'] as String),
      birthplaceMother: json['birthplaceMother'] as String?,
      photoIdentite: json['photoIdentite'] as String?,
      quartier: json['quartier'] as String?,
      centre: json['centre'] == null
          ? null
          : CentreModel.fromJson(json['centre'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EnrollmentDataImplToJson(
        _$EnrollmentDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateEnrolement': instance.dateEnrolement?.toIso8601String(),
      'dateValidation': instance.dateValidation?.toIso8601String(),
      'status': instance.status,
      'motifRejet': instance.motifRejet,
      'numOrder': instance.numOrder,
      'numForm': instance.numForm,
      'numCarte': instance.numCarte,
      'typeCarte': instance.typeCarte,
      'expireDateCarte': instance.expireDateCarte?.toIso8601String(),
      'deleveryDateCarte': instance.deleveryDateCarte?.toIso8601String(),
      'numEnregister': instance.numEnregister,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'birthdate': instance.birthdate?.toIso8601String(),
      'birthplace': instance.birthplace,
      'gender': instance.gender,
      'profession': instance.profession,
      'address': instance.address,
      'lastNameFather': instance.lastNameFather,
      'firstNameFather': instance.firstNameFather,
      'birthdateFather': instance.birthdateFather?.toIso8601String(),
      'birthplaceFather': instance.birthplaceFather,
      'lastNameMother': instance.lastNameMother,
      'firstNameMother': instance.firstNameMother,
      'birthdateMother': instance.birthdateMother?.toIso8601String(),
      'birthplaceMother': instance.birthplaceMother,
      'photoIdentite': instance.photoIdentite,
      'quartier': instance.quartier,
      'centre': instance.centre,
    };
