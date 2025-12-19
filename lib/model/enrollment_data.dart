import 'package:cei_mobile/model/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'enrollment_data.freezed.dart';
part 'enrollment_data.g.dart';

@freezed
class EnrollmentData with _$EnrollmentData {
  const factory EnrollmentData({
    int? id,
    DateTime? dateEnrolement,
    DateTime? dateValidation,
    String? status,
    String? motifRejet,
    String? numOrder,
    String? numForm,
    String? numCarte,
    String? typeCarte,
    DateTime? expireDateCarte,
    DateTime? deleveryDateCarte,
    String? numEnregister,
    String? lastName,
    String? firstName,
    DateTime? birthdate,
    String? birthplace,
    String? gender,
    String? profession,
    String? address,
    String? lastNameFather,
    String? firstNameFather,
    DateTime? birthdateFather,
    String? birthplaceFather,
    String? lastNameMother,
    String? firstNameMother,
    DateTime? birthdateMother,
    String? birthplaceMother,
    String? photoIdentite,
    String? quartier,
    CentreModel? centre,
  }) = _EnrollmentData;

  factory EnrollmentData.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentDataFromJson(json);
}
