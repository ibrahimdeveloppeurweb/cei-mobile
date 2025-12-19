import 'package:cei_mobile/core/constants/api_constants.dart' show ApiConstants;
import 'package:cei_mobile/main.dart';



Future<dynamic> verifyEnrolmentForm(Map<String, dynamic> req) async {
  return apiClient.post("${ApiConstants.verification}/form-number", body: req);
}

Future<dynamic> verifyEnrolmentUniqId(Map<String, dynamic> req) async {
  return apiClient.post("${ApiConstants.verification}/registration-number", body: req);
}

Future<dynamic> verifyEnrolmentName(Map<String, dynamic> req) async {
  return apiClient.post("${ApiConstants.verification}/identity", body: req);
}
