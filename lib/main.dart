import 'package:cei_mobile/screens/splash/providers/first_time_provider.dart';
import 'package:cei_mobile/services/electoral_code_serve.dart';
import 'package:cei_mobile/store/AppStore.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';
import 'package:cei_mobile/store/EnrollmentStore.dart';
import 'package:cei_mobile/store/ScanCustomerStore.dart';
import 'package:cei_mobile/store/UserStore.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/constants/user_constants.dart';
import 'core/network/api_client.dart';
import 'core/network/response_handler.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

final tokenManager = TokenManager();
final apiClient = ApiClient(
  client: http.Client(),
  responseHandler: ResponseHandler(),
  tokenManager: tokenManager,
);

AppStore appStore = AppStore();
UserStore userStore = UserStore();
EnrollmentStore enrollmentStore = EnrollmentStore();
CandidatureStore candidatureStore = CandidatureStore();
ScanCustomerStore scanCustomerStore = ScanCustomerStore();
//final ElectoralCodeService _service = ElectoralCodeService.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FaceCamera.initialize();
  await initialize();
  //await _service.loadElectoralCode();

  final savedToken = getStringAsync(AppConstants.authTokenKey);
  final savedRefreshToken = getStringAsync(AppConstants.refreshTokenKey);
  appStore.setLoggedIn(getBoolAsync(AppConstants.isLoggedInKey));
  appStore
      .setIsVoterCenterSaved(getBoolAsync(AppConstants.isVoterCenterSavedKey));
  appStore
      .setVoterCenterId(getIntAsync(AppConstants.voterCenterIdKey));
  appStore.setNumEnregister(getStringAsync(AppConstants.numEnregisterKey));
  userStore.setUniqueRegistrationNumber(getStringAsync(USER_UNIQUE_REGISTRATION_NUMBER));
  if (savedToken.isNotEmpty) {
    tokenManager.setTokens(
      token: savedToken,
      refreshToken: savedRefreshToken,
    );
  }

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white));
  userStore.initUserFromPrefs();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FirstTimeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CREDIT FEF',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
