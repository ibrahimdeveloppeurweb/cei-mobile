import 'package:freezed_annotation/freezed_annotation.dart';

part 'reclamation_model.freezed.dart';
part 'reclamation_model.g.dart';

@freezed
class ReclamationModel with _$ReclamationModel {
  const factory ReclamationModel({
    int? id,
    String? type, // RADIATION | OMISSION | ERREUR
    String? motif,
    String? etat, // EN ATTENTE | EN COURS | TERMINE
    Map<String, dynamic>? data,
    String? personFullName,
    int? personId,
  }) = _ReclamationModel;

  factory ReclamationModel.fromJson(Map<String, dynamic> json) =>
      _$ReclamationModelFromJson(json);
}
