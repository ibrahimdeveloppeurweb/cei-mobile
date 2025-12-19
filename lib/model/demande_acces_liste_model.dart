import 'package:freezed_annotation/freezed_annotation.dart';

part 'demande_acces_liste_model.freezed.dart';
part 'demande_acces_liste_model.g.dart';

// Enums for status and access types
enum DemandeStatus {
  @JsonValue('en_attente')
  enAttente,
  @JsonValue('approuvee')
  approuvee,
  @JsonValue('rejetee')
  rejetee,
}

enum TypeAcces {
  @JsonValue('lecture')
  lecture,
  @JsonValue('ecriture')
  ecriture,
}

enum TypeList {
  @JsonValue('provisoire')
  provisoire,
  @JsonValue('definitive')
  definitive,
}

@freezed
class DemandeAccesListe with _$DemandeAccesListe {
  const factory DemandeAccesListe({
    required int id,
    @Default(DemandeStatus.enAttente) DemandeStatus status,
    @Default(TypeAcces.lecture) TypeAcces typeAcces,
    TypeList? typeList,
    String? motif,
    DateTime? dateValidation,
    String? commentaireValidation,
    DateTime? dateExpiration,

    // Relations
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

    // Timestamps (if needed)
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DemandeAccesListe;

  factory DemandeAccesListe.fromJson(Map<String, dynamic> json) =>
      _$DemandeAccesListeFromJson(json);
}
