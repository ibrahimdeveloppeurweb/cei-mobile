import 'package:cei_mobile/core/constants/api_constants.dart';
import 'package:cei_mobile/main.dart';

Future<dynamic> submitElectoralListRequestApi(Map data) async {
  String url = ApiConstants.demandeAcces;
  return apiClient.post(url, body: data);
}

Future<dynamic> getElectoralListRequestApi() async {
  return apiClient.get("${ApiConstants.demandeAcces}/mes-demandes");
}