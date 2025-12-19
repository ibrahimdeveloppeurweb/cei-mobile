import 'package:cei_mobile/core/constants/api_constants.dart';
import 'package:cei_mobile/main.dart';


Future<dynamic> registerApi(Map<String, dynamic> req) async {
  return apiClient.post(ApiConstants.register, body: req);
}

Future<dynamic> sendOtpRequest(String phoneNumber) async {
  return apiClient.post(ApiConstants.sendOtp, body: {'phoneNumber': phoneNumber});
}

Future<dynamic> resendOtpRequest(String phoneNumber) async {
  return apiClient.post(ApiConstants.resendOtp, body: {'phoneNumber': phoneNumber});
}

Future<dynamic> verifyOtpRequest(String otpCode, String phoneNumber) async {
  return apiClient.post(ApiConstants.verifyOtp, body: {'otp': otpCode, 'phoneNumber': phoneNumber});
}
