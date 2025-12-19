class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://cei-api.zenapi.net';
  static const String apiVersion = '/api/v1';

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/users/register';
  static const String verification = '/verification';
  static const String resetPassword = '/auth/reset-password';
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';
  static const String sendOtp = '/send/otp-code';
  static const String verifyOtp = '/verify/otp-code';
  static const String resendOtp = '/resend/otp-code';
  static const String enrolmentcenter = '/centre';

  static const String districts = "/districts";
  static const String regions = "/regions";
  static const String annnees = "/annees";
  static const String departements = "/departements";
  static const String sousPrefectures = "/sous-prefectures";
  static const String communes = "/communes";
  static const String centresToFilter = "/centre";
  static const String partie = "/parties";
  static const String reclamation = "/reclamation";
  static const String demandeAcces = "/demandes-acces";
  static const String mesDemandes = "/mes-demandes";

  // Request headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeouts in milliseconds
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
}