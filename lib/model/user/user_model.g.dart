// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      uniqueRegistrationNumber: json['uniqueRegistrationNumber'] as String?,
      formNumber: json['formNumber'] as String?,
      numEnregister: json['numEnregister'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      placeOfBirth: json['placeOfBirth'] as String?,
      gender: json['gender'] as String?,
      profession: json['profession'] as String?,
      residence: json['residence'] as String?,
      fatherName: json['fatherName'] as String?,
      fatherDateOfBirth: json['fatherDateOfBirth'] == null
          ? null
          : DateTime.parse(json['fatherDateOfBirth'] as String),
      fatherPlaceOfBirth: json['fatherPlaceOfBirth'] as String?,
      motherName: json['motherName'] as String?,
      motherDateOfBirth: json['motherDateOfBirth'] == null
          ? null
          : DateTime.parse(json['motherDateOfBirth'] as String),
      motherPlaceOfBirth: json['motherPlaceOfBirth'] as String?,
      voterStatus: json['voterStatus'] as String?,
      imageUrl: json['imageUrl'] as String?,
      orderNumber: json['orderNumber'] as String?,
      pollingStation: json['pollingStation'] == null
          ? null
          : BureauModel.fromJson(
              json['pollingStation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'roles': instance.roles,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'uniqueRegistrationNumber': instance.uniqueRegistrationNumber,
      'formNumber': instance.formNumber,
      'numEnregister': instance.numEnregister,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'placeOfBirth': instance.placeOfBirth,
      'gender': instance.gender,
      'profession': instance.profession,
      'residence': instance.residence,
      'fatherName': instance.fatherName,
      'fatherDateOfBirth': instance.fatherDateOfBirth?.toIso8601String(),
      'fatherPlaceOfBirth': instance.fatherPlaceOfBirth,
      'motherName': instance.motherName,
      'motherDateOfBirth': instance.motherDateOfBirth?.toIso8601String(),
      'motherPlaceOfBirth': instance.motherPlaceOfBirth,
      'voterStatus': instance.voterStatus,
      'imageUrl': instance.imageUrl,
      'orderNumber': instance.orderNumber,
      'pollingStation': instance.pollingStation,
    };

_$BureauModelImpl _$$BureauModelImplFromJson(Map<String, dynamic> json) =>
    _$BureauModelImpl(
      id: (json['id'] as num?)?.toInt(),
      numero: json['numero'] as String?,
      centre: json['centre'] == null
          ? null
          : CentreModel.fromJson(json['centre'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BureauModelImplToJson(_$BureauModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numero': instance.numero,
      'centre': instance.centre,
    };

_$CentreModelImpl _$$CentreModelImplFromJson(Map<String, dynamic> json) =>
    _$CentreModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      rue: json['rue'] as String?,
      localisation: json['localisation'] as String?,
      avenue: json['avenue'] as String?,
      quartier: json['quartier'] as String?,
      district: json['district'] == null
          ? null
          : DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : RegionModel.fromJson(json['region'] as Map<String, dynamic>),
      departement: json['departement'] == null
          ? null
          : DepartementModel.fromJson(
              json['departement'] as Map<String, dynamic>),
      sousPrefecture: json['sousPrefecture'] == null
          ? null
          : SousPrefectureModel.fromJson(
              json['sousPrefecture'] as Map<String, dynamic>),
      commune: json['commune'] == null
          ? null
          : CommuneModel.fromJson(json['commune'] as Map<String, dynamic>),
      village: json['village'] == null
          ? null
          : VillageModel.fromJson(json['village'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CentreModelImplToJson(_$CentreModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rue': instance.rue,
      'localisation': instance.localisation,
      'avenue': instance.avenue,
      'quartier': instance.quartier,
      'district': instance.district,
      'region': instance.region,
      'departement': instance.departement,
      'sousPrefecture': instance.sousPrefecture,
      'commune': instance.commune,
      'village': instance.village,
    };

_$DistrictModelImpl _$$DistrictModelImplFromJson(Map<String, dynamic> json) =>
    _$DistrictModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$DistrictModelImplToJson(_$DistrictModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$RegionModelImpl _$$RegionModelImplFromJson(Map<String, dynamic> json) =>
    _$RegionModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$RegionModelImplToJson(_$RegionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$DepartementModelImpl _$$DepartementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DepartementModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$DepartementModelImplToJson(
        _$DepartementModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$SousPrefectureModelImpl _$$SousPrefectureModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SousPrefectureModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$SousPrefectureModelImplToJson(
        _$SousPrefectureModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$CommuneModelImpl _$$CommuneModelImplFromJson(Map<String, dynamic> json) =>
    _$CommuneModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$CommuneModelImplToJson(_$CommuneModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$VillageModelImpl _$$VillageModelImplFromJson(Map<String, dynamic> json) =>
    _$VillageModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$VillageModelImplToJson(_$VillageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$AnneeModelImpl _$$AnneeModelImplFromJson(Map<String, dynamic> json) =>
    _$AnneeModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$AnneeModelImplToJson(_$AnneeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
