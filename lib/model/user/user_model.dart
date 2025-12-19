import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    final int? id,
    final String? username,
    final String? email,
    @JsonKey(name: 'phone_number') final String? phoneNumber,
    final List<String>? roles,
    final String? firstName,
    final String? lastName,
    final String? uniqueRegistrationNumber,
    final String? formNumber,
    final String? numEnregister,
    final DateTime? dateOfBirth,
    final String? placeOfBirth,
    final String? gender,
    final String? profession,
    final String? residence,
    final String? fatherName,
    final DateTime? fatherDateOfBirth,
    final String? fatherPlaceOfBirth,
    final String? motherName,
    final DateTime? motherDateOfBirth,
    final String? motherPlaceOfBirth,
    final String? voterStatus,
    final String? imageUrl,
    final String? orderNumber,
    final BureauModel? pollingStation,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@freezed
class BureauModel with _$BureauModel {
  const factory BureauModel({
    final int? id,
    final String? numero,
    final CentreModel? centre
  }) = _BureauModel;

  factory BureauModel.fromJson(Map<String, dynamic> json) =>
      _$BureauModelFromJson(json);
}

@freezed
class CentreModel with _$CentreModel {
  const factory CentreModel({
    final int? id,
    final String? name,
    final String? rue,
    final String? localisation,
    final String? avenue,
    final String? quartier,
    final DistrictModel? district,
    final RegionModel? region,
    final DepartementModel? departement,
    final SousPrefectureModel? sousPrefecture,
    final CommuneModel? commune,
    final VillageModel? village,
  }) = _CentreModel;

  factory CentreModel.fromJson(Map<String, dynamic> json) =>
      _$CentreModelFromJson(json);
}

@freezed
class DistrictModel with _$DistrictModel {
  const factory DistrictModel({
    final int? id,
    final String? name,
  }) = _DistrictModel;

  factory DistrictModel.fromJson(Map<String, dynamic> json) =>
      _$DistrictModelFromJson(json);
}

@freezed
class RegionModel with _$RegionModel {
  const factory RegionModel({
    final int? id,
    final String? name,
  }) = _RegionModel;

  factory RegionModel.fromJson(Map<String, dynamic> json) =>
      _$RegionModelFromJson(json);
}

@freezed
class DepartementModel with _$DepartementModel {
  const factory DepartementModel({
    final int? id,
    final String? name,
  }) = _DepartementModel;

  factory DepartementModel.fromJson(Map<String, dynamic> json) =>
      _$DepartementModelFromJson(json);
}

@freezed
class SousPrefectureModel with _$SousPrefectureModel {
  const factory SousPrefectureModel({
    final int? id,
    final String? name,
  }) = _SousPrefectureModel;

  factory SousPrefectureModel.fromJson(Map<String, dynamic> json) =>
      _$SousPrefectureModelFromJson(json);
}

@freezed
class CommuneModel with _$CommuneModel {
  const factory CommuneModel({
    final int? id,
    final String? name,
  }) = _CommuneModel;

  factory CommuneModel.fromJson(Map<String, dynamic> json) =>
      _$CommuneModelFromJson(json);
}

@freezed
class VillageModel with _$VillageModel {
  const factory VillageModel({
    final int? id,
    final String? name,
  }) = _VillageModel;

  factory VillageModel.fromJson(Map<String, dynamic> json) =>
      _$VillageModelFromJson(json);
}

@freezed
class AnneeModel with _$AnneeModel {
  const factory AnneeModel({
    final int? id,
    final String? name,
  }) = _AnneeModel;

  factory AnneeModel.fromJson(Map<String, dynamic> json) =>
      _$AnneeModelFromJson(json);
}