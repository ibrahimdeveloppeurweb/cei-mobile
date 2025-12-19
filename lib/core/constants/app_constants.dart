class AppConstants {
  // App info
  static const String appName = 'CEI MOBILE';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // Shared preferences keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String isFirstLaunchKey = 'is_first_launch';
  static const String themeKey = 'app_theme';
  static const String localeKey = 'app_locale';
  static const isLoggedInKey = 'is_logged_in';
  static const isVoterCenterSavedKey = 'is_voter_center_saved';
  static const voterCenterIdKey = 'voter_center_id_key';
  static const bureauDeVoteNumberKey = 'bureau_de_vote_number_key';
  static const numEnregisterKey = 'num_enregister_key';

  // Default values
  static const String defaultLanguage = 'en';
  static const String defaultCountry = 'US';

  // Pagination
  static const int defaultPageSize = 20;

  // Timeout durations
  static const int splashDuration = 2; // seconds
  static const int snackBarDuration = 3; // seconds

  // Regex patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';

  // Enrollment Process
  static const String hasEnrollmentDataKey = "hasEnrollmentData";
  static const String isEnrollmentCompleteKey = "isEnrollmentComplete";
  static const String enrollmentCurrentStepKey = "enrollmentCurrentStep";

  // Enrollment Step 1 Data
  static const String enrollmentLastNameKey = "enrollmentLastName";
  static const String enrollmentFirstNameKey = "enrollmentFirstName";
  static const String enrollmentGenderKey = "enrollmentGender";
  static const String enrollmentBirthDateKey = "enrollmentBirthDate";
  static const String enrollmentCityKey = "enrollmentCity";
  static const String enrollmentCommuneKey = "enrollmentCommune";
  static const String enrollmentQuarterKey = "enrollmentQuarter";

  // Enrollment Step 2 Data
  static const String enrollmentCountryKey = "enrollmentCountry";
  static const String enrollmentCenterKey = "enrollmentCenter";

  // Enrollment Step 3 Data
  static const String enrollmentPhotoTakenKey = "enrollmentPhotoTaken";

  // Enrollment Step 4 Data
  static const String enrollmentIdTypeKey = "enrollmentIdType";
  static const String enrollmentIdNumberKey = "enrollmentIdNumber";
  static const String enrollmentIssueDateKey = "enrollmentIssueDate";

  // Enrollment Step 5 Data
  static const String enrollmentAddressKey = "enrollmentAddress";
  static const String enrollmentAddressCityKey = "enrollmentAddressCity";
  static const String enrollmentAddressCommuneKey = "enrollmentAddressCommune";
  static const String enrollmentAddressQuarterKey = "enrollmentAddressQuarter";
  static const String enrollmentIsCIESelectedKey = "enrollmentIsCIESelected";
  static const String enrollmentIsSODECISelectedKey = "enrollmentIsSODECISelected";

  // Enrollment Step 5 Data
  static const String enrollmentPhoneKey = "enrollmentPhone";
  static const String enrollmentSecondPhoneKey = "enrollmentSecondPhone";
  static const String enrollmentEmailKey = "enrollmentEmail";
  static const String enrollmentProfessionKey = "enrollmentProfession";
  static const String enrollmentDomicileCountryKey = "enrollmentDomicileCountry";
  static const String enrollmentDomicileCityKey = "enrollmentDomicileCity";
  static const String enrollmentDomicileCommuneKey = "enrollmentDomicileCommune";
  static const String enrollmentDomicileQuarterKey = "enrollmentDomicileQuarter";
  static const String enrollmentReferenceNumberKey = 'enrollmentReferenceNumber';


  static const String enrollmentFatherLastNameKey = 'enrollment_father_last_name';
  static const String enrollmentFatherFirstNameKey = 'enrollment_father_first_name';
  static const String enrollmentFatherBirthdateKey = 'enrollment_father_birthdate';
  static const String enrollmentFatherBirthplaceKey = 'enrollment_father_birthplace';
  static const String enrollmentMotherLastNameKey = 'enrollment_mother_last_name';
  static const String enrollmentMotherFirstNameKey = 'enrollment_mother_first_name';
  static const String enrollmentMotherBirthdateKey = 'enrollment_mother_birthdate';
  static const String enrollmentMotherBirthplaceKey = 'enrollment_mother_birthplace';

  static const String districts = "/api/districts";
  static const String regions = "/api/regions";
  static const String departements = "/api/departements";
  static const String sousPrefectures = "/api/sous-prefectures";
  static const String communes = "/admin/api/communes";
}