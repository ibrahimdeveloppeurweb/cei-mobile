import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/model/user/user_model.dart';
import 'package:cei_mobile/screens/account/account_screen.dart';
import 'package:cei_mobile/screens/account/identity_scan_customer_screen.dart';
import 'package:cei_mobile/screens/account/identity_verification_info_screen.dart';
import 'package:cei_mobile/screens/account/identity_verification_screen.dart';
import 'package:cei_mobile/screens/account/terms_conditions_screen.dart';
import 'package:cei_mobile/screens/account/welcome_bank_screen.dart';
import 'package:cei_mobile/screens/auth/credit_fef_assistant_pin_screen.dart';
import 'package:cei_mobile/screens/auth/login_screen.dart';
import 'package:cei_mobile/screens/auth/register_step2_screen.dart';
import 'package:cei_mobile/screens/auth/register_step3_screen.dart';
import 'package:cei_mobile/screens/auth/register_step1_screen.dart';
import 'package:cei_mobile/screens/banks/account_bank_screen.dart';
import 'package:cei_mobile/screens/banks/account_detail.dart';
import 'package:cei_mobile/screens/banks/operation_retrait_compte.dart';
import 'package:cei_mobile/screens/banks/plus_bank_screen.dart';
import 'package:cei_mobile/screens/banks/support_bank_screen.dart';
import 'package:cei_mobile/screens/banks/transaction_detail.dart';
import 'package:cei_mobile/screens/banks/virement_bank_screen.dart';
import 'package:cei_mobile/screens/banks/wallet_mobile.dart';
import 'package:cei_mobile/screens/candidature/candidature_election_verification_result.dart';
import 'package:cei_mobile/screens/candidature/candidature_enrollment_verification.dart';
import 'package:cei_mobile/screens/candidature/candidature_presidentielle_screen.dart';
import 'package:cei_mobile/screens/candidature/candidature_screen.dart';
import 'package:cei_mobile/screens/candidature/canidature_face_verification.dart';
import 'package:cei_mobile/screens/candidature/election_selection_screen.dart';
import 'package:cei_mobile/screens/candidature/models/election_type.dart';
import 'package:cei_mobile/screens/complains/reclamation_details_screen.dart';
import 'package:cei_mobile/screens/complains/reclamation_list_screen.dart';
import 'package:cei_mobile/screens/complains/reclamation_screen.dart';
import 'package:cei_mobile/screens/electorallist/electoral_form_screen.dart';
import 'package:cei_mobile/screens/electorallist/electoral_list_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_center_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_recap_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_status_dynamic.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_status_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_step1_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_step2_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_step3_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_step4_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_step5_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_verification_result_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_verification_screen.dart';
import 'package:cei_mobile/screens/home/credit_fef_dashboard_screen.dart';
import 'package:cei_mobile/screens/home/home_screen.dart';
import 'package:cei_mobile/screens/news/news_screen.dart';
import 'package:cei_mobile/screens/onboarding/onboarding_screen.dart';
import 'package:cei_mobile/screens/resultat_election/election_result_screen.dart';
import 'package:cei_mobile/screens/resultat_election/election_selection_screen.dart';
import 'package:cei_mobile/screens/resultat_election/others_election_result.dart';
import 'package:cei_mobile/screens/splash/splash_screen.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class AppRoutes {
  // Route names
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String registerStep1 = 'register-step1';
  static const String registerStep2 = 'register-step2';
  static const String registerStep3 = 'register-step3';
  static const String forgotPassword = 'forgotPassword';
  static const String home = 'home';
  static const String enrollment = 'enrollment';
  static const String enrollmentStep1 = 'enrollment_step1';
  static const String enrollmentStep2 = 'enrollment_step2';
  static const String enrollmentStep3 = 'enrollment_step3';
  static const String enrollmentStep4 = 'enrollment_step4';
  static const String enrollmentStep5 = 'enrollment_step5';
  static const String enrollmentVerification = 'enrollment_verification';
  static const String enrollmentVerificationResult = 'enrollment_verification_result';
  static const String enrollmentCenter = 'enrollment_center';
  static const String enrollmentStatus= 'enrollment_status';
  static const String enrollmentStatusDynamic = 'enrollment_status_dynamic';
  static const String reclamation = 'reclamation';
  static const String profile = 'profile';
  static const String settings = 'settings';
  static const String details = 'details';
  static const String reclamationList = 'reclamation-list';
  static const String reclamationDetails = 'reclamation-details';
  static const String electoralList = 'electoral-list';
  static const String electoralForm = 'electoral-form';
  static const String electionSelection = 'election-selection';
  static const String electionResults = 'election-results';
  static const String otherElectionResults = 'others-election-results';
  static const String candidature = 'candidature';
  static const String faceVerificationScreen = 'faceVerificationScreen';
  static const String candidatureVerificationScreen = 'candidatureVerificationScreen';
  static const String candidatureSelectionScreen = 'candidatureSelectionScreen';
  static const String welcomeBankScreen = 'welcomeBankScreen';
  static const String termsConditionsScreen = 'termsConditionsScreen';
  static const String identityVerificationScreen = 'identityVerificationScreen';
  static const String identityVerificationInfoScreen = 'identityVerificationInfoScreen';
  static const String identityScanScreen = 'identityScanScreen';
  static const String accountBankScreen = 'accountBankScreen';
  static const String virementsBankScreen = 'virementsBankScreen';
  static const String supportScreen = 'supportScreen';
  static const String addInfosScreen = 'addInfosScreen';
  static const String walletScreen = 'walletScreen';
  static const String accountDetailScreen = 'accountDetailScreen';
  static const String transactionDetailScreen = 'transactionDetailScreen';
  static const String operationRetraitCompteScreen  = 'operationRetraitCompteScreen';
  static const String creditFefAssistantPinScreen  = 'creditFefAssistantPinScreen';
  static const String accueilScreen  = 'accueilScreen';

  // Route paths
  static const String splashPath = '/';
  static const String onboardingPath = '/onboarding';
  static const String loginPath = '/login';
  static const String registerStep1Path = '/register-step1';
  static const String registerStep2Path = '/register-step2/:phoneNumber';
  static const String registerStep3Path = '/register-step3/:phoneNumber';
  static const String forgotPasswordPath = '/forgot-password';
  static const String homePath = '/home';
  static const String enrollmentPath = '/enrollment';
  static const String enrollmentStep1Path = '/enrollment-step1';
  static const String enrollmentStep2Path = '/enrollment-step2';
  static const String enrollmentStep3Path = '/enrollment-step3';
  static const String enrollmentStep4Path = '/enrollment-step4';
  static const String enrollmentStep5Path = '/enrollment-step5';
  static const String enrollmentVerificationPath = '/enrollment-verification/:isAddLocation';
  static const String enrollmentVerificationResultPath = '/enrollment-verification-result';
  static const String enrollmentCenterPath = '/enrollment-center';
  static const String enrollmentStatusPath = '/enrollment-status';
  static const String enrollmentStatusDynamicPath = '/enrollment-status-dynamic';
  static const String reclamationPath = '/reclamation';
  static const String profilePath = '/profile';
  static const String settingsPath = '/settings';
  static const String detailsPath = '/details/:id';
  static const String electoralListPath = '/electoral-list';
  static const String electoralFormPath = '/electoral-form';
  static const String candidatureEnrollmentVerificationScreen = '/candidatureEnrollmentVerificationScreen';
  static const String candidatureEnrollmentVerificationResultScreen = '/candidatureEnrollmentVerificationResultScreen';
  static const String welcomeBankPath = '/welcomeBankPath';
  static const String termsConditionsPath = '/termsConditionsPath';
  static const String identityVerificationPath = '/identityVerificationPath';
  static const String identityVerificationInfoPath = '/identityVerificationInfoPath';
  static const String identityScanPath = '/identityScanPath';
  static const String accountBankPath = '/accountBankPath';
  static const String virementsPath = '/virementsPath';
  static const String supportPath = '/supportPath';
  static const String addInfosPath = '/addInfosPath';
  static const String walletPath = '/walletPath';
  static const String accountDetailPath = '/accountDetailPath';
  static const String transactionDetailPath = '/transactionDetailPath';
  static const String operationRetraitComptePath  = '/operationRetraitComptePath';
  static const String creditFefAssistantPinPath  = '/creditFefAssistantPinPath';
  static const String accueilPath  = '/accueilPath';


}

class AppRouter {
  // Router instance
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  // Auth state

  // Router configuration
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splashPath,
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) {
      // Check if the user is authenticated - directly access appStore
      var isLoggedIn = appStore.isLoggedIn;
      final isGoingToLogin = state.matchedLocation == AppRoutes.loginPath ||
          state.matchedLocation.startsWith('/register-step')   ||
          state.matchedLocation == AppRoutes.termsConditionsPath ||
          state.matchedLocation == AppRoutes.welcomeBankPath ||
          state.matchedLocation == AppRoutes.identityVerificationPath ||
          state.matchedLocation == AppRoutes.identityVerificationInfoPath ||
          state.matchedLocation == AppRoutes.identityScanPath ||
         // state.matchedLocation == AppRoutes.homePath ||
          state.matchedLocation == AppRoutes.accountBankPath ||
          state.matchedLocation == AppRoutes.virementsPath ||
          state.matchedLocation == AppRoutes.supportPath ||
          state.matchedLocation == AppRoutes.addInfosPath ||
          state.matchedLocation == AppRoutes.walletPath ||
          state.matchedLocation == AppRoutes.accountDetailPath ||
          state.matchedLocation == AppRoutes.transactionDetailPath ||
          state.matchedLocation == AppRoutes.operationRetraitComptePath ||
          state.matchedLocation == AppRoutes.creditFefAssistantPinPath ||
          state.matchedLocation == AppRoutes.accueilPath||
          state.matchedLocation == AppRoutes.creditFefAssistantPinPath ||
          state.matchedLocation == AppRoutes.forgotPasswordPath;

      // Splash screen has no redirects
      if (state.matchedLocation == AppRoutes.splashPath) {
        return null;
      }

      // Redirect to login if not authenticated and not already going to login
      if (!isLoggedIn && !isGoingToLogin && !state.matchedLocation.contains(AppRoutes.onboardingPath)) {
        return AppRoutes.loginPath;
      }

      // Redirect to home if authenticated and trying to access login/register
      if (isLoggedIn && isGoingToLogin) {
        return AppRoutes.homePath;
      }

      return null;
    },
    routes: [
      // Splash screen
      GoRoute(
        name: AppRoutes.splash,
        path: AppRoutes.splashPath,
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding
      GoRoute(
        name: AppRoutes.onboarding,
        path: AppRoutes.onboardingPath,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Authentication routes
      GoRoute(
        name: AppRoutes.login,
        path: AppRoutes.loginPath,
        builder: (context, state) =>  const LoginScreen(),
      ),

      GoRoute(
        name: AppRoutes.forgotPassword,
        path: AppRoutes.forgotPasswordPath,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        name: AppRoutes.welcomeBankScreen,
        path: AppRoutes.welcomeBankPath,
        builder: (context, state) => const WelcomeBankScreen(),
      ),
      GoRoute(
        name: AppRoutes.termsConditionsScreen,
        path: AppRoutes.termsConditionsPath,
        builder: (context, state) => const TermsConditionsScreen(),
      ),
      GoRoute(
        name: AppRoutes.identityVerificationScreen,
        path: AppRoutes.identityVerificationPath,
        builder: (context, state) => const IdentityVerificationScreen(),
      ),
      GoRoute(
        name: AppRoutes.identityVerificationInfoScreen,
        path: AppRoutes.identityVerificationInfoPath,
        builder: (context, state) => const IdentityVerificationInfoScreen(),
      ),
      GoRoute(
        name: AppRoutes.identityScanScreen,
        path: AppRoutes.identityScanPath,
        builder: (context, state) => const ScanInfoCustomer(),
      ),
      GoRoute(
        name: AppRoutes.walletScreen,
        path: AppRoutes.walletPath,
        builder: (context, state) => const WalletMobile(),
      ),
      GoRoute(
        name: AppRoutes.accountDetailScreen,
        path: AppRoutes.accountDetailPath,
        builder: (context, state) => const AccountDetail(),
      ),
      GoRoute(
        name: AppRoutes.transactionDetailScreen,
        path: AppRoutes.transactionDetailPath,
        builder: (context, state) => const TransactionDetails(),
      ),
      GoRoute(
        name: AppRoutes.operationRetraitCompteScreen,
        path: AppRoutes.operationRetraitComptePath,
        builder: (context, state) => const OperationRetraitCompte(),
      ),

      GoRoute(
        name: AppRoutes.creditFefAssistantPinScreen,
        path: AppRoutes.creditFefAssistantPinPath,
        builder: (context, state) => const CreditFefAssistantPinScreen(),
      ),




      // Main app shell with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Home tab
          GoRoute(
            name: AppRoutes.accueilScreen,
            path: AppRoutes.accueilPath,
            builder: (context, state) => BankingHomePage(),
            routes: [
              // Nested route example
              GoRoute(
                name: AppRoutes.details,
                path: 'details/:id',
                builder: (context, state) {
                  final id = state.pathParameters['id'] ?? '';
                  return DetailsScreen(id: id);
                },
              ),
            ],
          ),

          // Account Bank Screen
          GoRoute(
            name: AppRoutes.accountBankScreen,
            path: AppRoutes.accountBankPath,
            builder: (context, state) => AccountBankScreen(),
          ),

          // Virements tab
          GoRoute(
            name: AppRoutes.virementsBankScreen,
            path: AppRoutes.virementsPath,
            builder: (context, state) => const VirementsScreen(),
          ),

          // Support tab
          GoRoute(
            name: AppRoutes.supportScreen,
            path: AppRoutes.supportPath,
            builder: (context, state) => const SupportScreen(),
          ),

          // Settings tab (Plus) - CORRIGÉ
          GoRoute(
            name: AppRoutes.addInfosScreen,
            path: AppRoutes.addInfosPath,
            builder: (context, state) => const AddInfosScreen(),
          ),
        ],
      ),
      GoRoute(
        name: AppRoutes.enrollment,
        path: AppRoutes.enrollmentPath,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return const ScanInfoCustomer();
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.enrollmentStep1,
        path: AppRoutes.enrollmentStep1Path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return const EnrollmentStep1Screen();
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.enrollmentStep2,
        path: AppRoutes.enrollmentStep2Path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return const EnrollmentStep2Screen();
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.enrollmentStep3,
        path: AppRoutes.enrollmentStep3Path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return const EnrollmentStep3Screen();
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.enrollmentStep4,
        path: AppRoutes.enrollmentStep4Path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return const EnrollmentStep4Screen();
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.enrollmentStep5,
        path: AppRoutes.enrollmentStep5Path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return const EnrollmentStep5Screen();
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.enrollmentVerification,
        path: AppRoutes.enrollmentVerificationPath,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final isAddLocation = state.pathParameters['isAddLocation'].toBool();
            return EnrollmentVerificationScreen(isAddLocation: isAddLocation);
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.enrollmentStatus,
        path: AppRoutes.enrollmentStatusPath,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return const EnrollmentStatusScreen();
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.enrollmentStatusDynamic,
        path: AppRoutes.enrollmentStatusDynamicPath,
        pageBuilder: (context, state) {
          final data = state.extra as EnrollmentData;
          return   CustomTransitionPage(
            key: state.pageKey,
            child: const ReclamationScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return  EnrollmentStatusDynamicScreen(enrollmentData: data);
            },
          );},
      ),
      GoRoute(
        name: AppRoutes.enrollmentVerificationResult,
        path: AppRoutes.enrollmentVerificationResultPath,
        pageBuilder: (context, state) {
          final user = state.extra as EnrollmentData;
          print(state.extra);
          return CustomTransitionPage(
            key: state.pageKey,
            child: EnrollmentVerificationResultScreen(userModel: user),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: AppRoutes.enrollmentCenter,
        path: AppRoutes.enrollmentCenterPath,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final centerId = state.extra as int;

            return EnrollmentCenterScreen(centerId: centerId,);
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.registerStep1,
        path: AppRoutes.registerStep1Path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return const RegisterStep1Screen();
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.registerStep2,
        path: AppRoutes.registerStep2Path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final phoneNumber = state.pathParameters['phoneNumber'] ?? '';
            return RegisterStep2Screen(phoneNumber: phoneNumber);
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.registerStep3,
        path: AppRoutes.registerStep3Path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final phoneNumber = state.pathParameters['phoneNumber'] ?? '';
            return RegisterStep3Screen(phoneNumber: phoneNumber);
          },
        ),

      ),
      GoRoute(
        name: AppRoutes.reclamation,
        path: '/reclamation',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.reclamationList,
        path: '/reclamation-list',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReclamationListScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.reclamationDetails,
        path: '/reclamation-details',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ReclamationDetailsScreen(
            reclamation: state.extra as Map<String, dynamic>,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/enrollment/success',
        builder: (context, state) {
          return const EnrollmentSuccessScreen();
        },
      ),
      GoRoute(
        name: AppRoutes.electoralList,
        path: AppRoutes.electoralListPath,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const Scaffold(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return const ElectoralListScreen();
          },
        ),
      ),
      GoRoute(
        name: AppRoutes.electoralForm,
        path: AppRoutes.electoralFormPath,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const Scaffold(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return const ElectoralFormScreen();
          },
        ),
      ),
      GoRoute(
        path: '/election-selection',
        name: AppRoutes.electionSelection,
        builder: (context, state) => const ElectionSelectionScreen(),
      ),
      GoRoute(
        path: '/election-results',
        name: AppRoutes.electionResults,
        builder: (context, state) {
          final election = state.extra as ElectionItem;
          return ElectionResultsScreen(election: election);
        },
      ),
      GoRoute(
        path: '/others-election-results',
        name: AppRoutes.otherElectionResults,
        builder: (context, state) {
          final election = state.extra as ElectionItem;
          return OthersElectionResultsScreen(election: election);
        },
      ),
      GoRoute(
        path: '/candidature',
        name: AppRoutes.candidature,
        builder: (context, state) {
          return  const CandidaturePresidentiellePage();
        },
      ),

      GoRoute(
        path: '/faceVerificationScreen',
        name: AppRoutes.faceVerificationScreen,
        builder: (context, state) {
          final data = state.extra as Map;
          final election = data['election'];
          return  CandidatureFaceVerificationScreen(election: election, enrollmentData: appStore.enrollmentData);
        },
      ),
      GoRoute(
        path: '/candidatureSelectionScreen',
        name: AppRoutes.candidatureSelectionScreen,
        builder: (context, state) {
          return  const CandidatureSelectionScreen();
        },
      ),
      GoRoute(
          path: '/candidatureEnrollmentVerificationScreen',
          name: AppRoutes.candidatureEnrollmentVerificationScreen,
          builder: (context, state) {
            final data = state.extra as Map;
            final isAddLocation = data['isAddLocation'] as bool;
            final election = data['selectedElection'] as ElectionType;
            return   CandidatureEnrollmentVerificationScreen(isAddLocation: isAddLocation, selectedElection: election);
          }
      ),
      GoRoute(
          path: '/candidatureEnrollmentVerificationResultScreen',
          name: AppRoutes.candidatureEnrollmentVerificationResultScreen,
          builder: (context, state) {
            final data = state.extra as Map;
            final enrollmentData = data['enrollmentData'] as EnrollmentData;
            final selectedElection = data['selectedElection'] as ElectionType;
            return   CandidatureEnrollmentVerificationResultScreen(enrollmentData: enrollmentData, selectedElection: selectedElection,returnToCandidature: true, );
          })
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),
  );
}


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Forgot Password')));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Profile')));
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Compte')));
}

class DetailsScreen extends StatelessWidget {
  final String id;
  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('Details: $id')));
}

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('Error: $error')));
}

class EnrollmentSuccessScreen extends StatelessWidget {
  const EnrollmentSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Text(
        'Enrollment Success',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Crucial pour afficher tous les éléments
        selectedItemColor: AppColors.primary, // Couleur de l'élément sélectionné
        unselectedItemColor: Colors.grey, // Couleur des éléments non sélectionnés
        backgroundColor: Colors.white, // Couleur de fond
        elevation: 8, // Élévation pour l'ombre
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Comptes'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Virements'),
          BottomNavigationBarItem(icon: Icon(Icons.headset_mic), label: 'Support'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Plus'),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;

    print('Current location: $location'); // Debug

    // Vérification plus précise des routes
    if (location == AppRoutes.homePath || location.startsWith('${AppRoutes.homePath}/')) {
      return 0;
    }
    if (location == AppRoutes.accountBankPath || location.startsWith('${AppRoutes.accountBankPath}/')) {
      return 1;
    }
    if (location == AppRoutes.virementsPath || location.startsWith('${AppRoutes.virementsPath}/')) {
      return 2;
    }
    if (location == AppRoutes.supportPath || location.startsWith('${AppRoutes.supportPath}/')) {
      return 3;
    }
    if (location == AppRoutes.addInfosPath || location.startsWith('${AppRoutes.addInfosPath}/')) {
      return 4;
    }

    return 0; // Par défaut, retourner à Accueil
  }

  void _onItemTapped(int index, BuildContext context) {
    print('Tapped index: $index'); // Debug

    switch (index) {
      case 0:
        context.go(AppRoutes.homePath);
        break;
      case 1:
        context.go(AppRoutes.accountBankPath);
        break;
      case 2:
        context.go(AppRoutes.virementsPath);
        break;
      case 3:
        context.go(AppRoutes.supportPath);
        break;
      case 4:
        context.go(AppRoutes.addInfosPath);
        break;
    }
  }
}