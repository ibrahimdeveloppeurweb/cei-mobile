import 'package:cei_mobile/core/constants/api_constants.dart';

import '../main.dart' show apiClient;

Future<dynamic> getParties() async {
  String url = ApiConstants.partie;
  return apiClient.get(url);
}