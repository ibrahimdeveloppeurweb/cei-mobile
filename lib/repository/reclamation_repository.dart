import 'package:cei_mobile/core/constants/api_constants.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/model/reclamation_model.dart';

Future<dynamic> submitReclamationApi(ReclamationModel reclamation) async {
  String url = ApiConstants.reclamation;
  return apiClient.post(url, body: reclamation.toJson());
}

Future<dynamic> getParties() async {
  String url = ApiConstants.reclamation;
  return apiClient.get(url);
}
