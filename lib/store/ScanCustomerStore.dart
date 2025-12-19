import 'dart:io';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/model/user/user_model.dart';
import 'package:cei_mobile/repository/enrolment_repository.dart';
import 'package:cei_mobile/repository/scan_customer_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:cei_mobile/core/constants/app_constants.dart';
import 'package:nb_utils/nb_utils.dart';

part 'ScanCustomerStore.g.dart';

class ScanCustomerStore = ScanCustomerStoreBase with _$ScanCustomerStore;

abstract class ScanCustomerStoreBase with Store {
  // Step 1: ID Document
  @observable
  File? idFrontPhoto;

  @observable
  File? idBackPhoto;

  @observable
  File? documentFacePhoto;

  @observable
  String? idType;

  @observable
  String idNumber = '';

  @observable
  String serialNumber = '';

  @observable
  DateTime? expireDate;

  @observable
  DateTime? issueDate;

  @observable
  String nationality = '';

  @observable
  String dob = '';

  @observable
  String placeOfBirth = '';

  @observable
  String profession = '';

  @observable
  String personalNumber = '';

  @observable
  String height = '';

  @observable
  String age = '';

  @observable
  String issuePlace = '';

  @observable
  String cardAccessNumber = '';

  @observable
  ObservableList<PlatformFile> step1Files = ObservableList<PlatformFile>();

  // Step 2: ID Photo
  @observable
  File? idPhoto;

  @observable
  bool photoTaken = false;

  @observable
  bool faceVerified = false;

  // Step 3: Personal Information
  @observable
  String lastName = '';

  @observable
  String firstName = '';

  @observable
  String? gender;

  @observable
  String? city;

  @observable
  String? commune;

  @observable
  String quarter = '';

  // Step 4: Parent Information
  @observable
  String lastNameFather = '';

  @observable
  String firstNameFather = '';

  @observable
  String birthdateFather = '';

  @observable
  String birthplaceFather = '';

  @observable
  String lastNameMother = '';

  @observable
  String firstNameMother = '';

  @observable
  String birthdateMother = '';

  @observable
  String birthplaceMother = '';

  // Step 5: Center Information
  @observable
  CentreModel? scanCustomerCenter;

  @observable
  DistrictModel? district;

  // Step 6: Address Information
  @observable
  String address = '';

  @observable
  String? addressCity;

  @observable
  String? addressCommune;

  @observable
  String? addressQuarter;

  @observable
  bool isCIESelected = false;

  @observable
  bool isSODECISelected = false;

  @observable
  ObservableList<PlatformFile> step6FilesCIE = ObservableList<PlatformFile>();

  @observable
  ObservableList<PlatformFile> step6FilesCertificat = ObservableList<PlatformFile>();

  // Step 7: Personal Contact Information
  @observable
  String phoneNumber = '';

  @observable
  String secondPhoneNumber = '';

  @observable
  String email = '';

  // Current step tracking
  @observable
  int currentStep = 0;

  @observable
  bool isScanCustomerComplete = false;

  @observable
  bool isSubmitting = false;

  @observable
  String? scanCustomerReferenceNumber;

  @observable
  String scanCustomerStatus = 'En attente';

  @observable
  DateTime? submissionDate;

  @computed
  bool get hasActiveScanCustomer =>
      scanCustomerReferenceNumber != null &&
          scanCustomerReferenceNumber!.isNotEmpty;

  // Step validation
  @computed
  bool get isStep1Valid =>
      idFrontPhoto != null &&
          idBackPhoto != null &&
          idType != null &&
          idNumber.isNotEmpty &&
          serialNumber.isNotEmpty &&
          expireDate != null &&
          issueDate != null &&
          step1Files.isNotEmpty;

  @computed
  bool get isStep2Valid =>
      idPhoto != null &&
          photoTaken &&
          (documentFacePhoto == null || faceVerified);

  @computed
  bool get isStep3Valid =>
      lastName.isNotEmpty &&
          firstName.isNotEmpty &&
          gender != null &&
          city != null &&
          commune != null &&
          quarter.isNotEmpty;

  @computed
  bool get isStep4Valid =>
      lastNameFather.isNotEmpty &&
          firstNameFather.isNotEmpty &&
          birthdateFather.isNotEmpty &&
          birthplaceFather.isNotEmpty &&
          lastNameMother.isNotEmpty &&
          firstNameMother.isNotEmpty &&
          birthdateMother.isNotEmpty &&
          birthplaceMother.isNotEmpty;

  @computed
  bool get isStep5Valid =>
      district != null &&
          scanCustomerCenter != null;

  @computed
  bool get isStep6Valid =>
      address.isNotEmpty &&
          addressCity != null &&
          addressCommune != null &&
          addressQuarter != null;

  @computed
  bool get isStep7Valid =>
      phoneNumber.isNotEmpty &&
          email.isNotEmpty &&
          profession.isNotEmpty;

  // Step 1: ID Document
  @action
  void setStep1Data({
    File? idFrontPhoto,
    File? idBackPhoto,
    File? documentFacePhoto,
    String? idType,
    String? idNumber,
    String? serialNumber,
    DateTime? expireDate,
    DateTime? issueDate,
    String? lastName,
    String? firstName,
    String? gender,
    String? birthplace,
    String? nationality,
    String? dob,
    String? placeOfBirth,
    String? profession,
    String? personalNumber,
    String? height,
    String? age,
    String? issuePlace,
    String? cardAccessNumber,
    List<PlatformFile>? files,
  }) {
    if (idFrontPhoto != null) this.idFrontPhoto = idFrontPhoto;
    if (idBackPhoto != null) this.idBackPhoto = idBackPhoto;
    if (documentFacePhoto != null) this.documentFacePhoto = documentFacePhoto;
    if (idType != null) this.idType = idType;
    if (idNumber != null) this.idNumber = idNumber;
    if (serialNumber != null) this.serialNumber = serialNumber;
    if (expireDate != null) this.expireDate = expireDate;
    if (issueDate != null) this.issueDate = issueDate;
    if (lastName != null) this.lastName = lastName;
    if (firstName != null) this.firstName = firstName;
    if (gender != null) this.gender = gender;
    if (birthplace != null) this.placeOfBirth = birthplace;
    if (nationality != null) this.nationality = nationality;
    if (dob != null) this.dob = dob;
    if (placeOfBirth != null) this.placeOfBirth = placeOfBirth;
    if (profession != null) this.profession = profession;
    if (personalNumber != null) this.personalNumber = personalNumber;
    if (height != null) this.height = height;
    if (age != null) this.age = age;
    if (issuePlace != null) this.issuePlace = issuePlace;
    if (cardAccessNumber != null) this.cardAccessNumber = cardAccessNumber;

    if (files != null) {
      this.step1Files.clear();
      this.step1Files.addAll(files);
    }

    // Store document face photo path in preferences for persistence
    if (documentFacePhoto != null) {
      setValue('document_face_photo_path', documentFacePhoto.path);
    }
  }

  // Step 2: ID Photo
  @action
  void setStep2Data({
    File? idPhoto,
    bool? photoTaken,
    bool? faceVerified,
  }) {
    if (idPhoto != null) this.idPhoto = idPhoto;
    if (photoTaken != null) this.photoTaken = photoTaken;
    if (faceVerified != null) this.faceVerified = faceVerified;

    // Store verification status in preferences
    if (faceVerified != null) {
      setValue('face_verification_result', faceVerified);
    }
  }

  // Step 3: Personal Information
  @action
  void setStep3Data({
    required String? city,
    required String? commune,
    required String quarter,
  }) {
    this.city = city;
    this.commune = commune;
    this.quarter = quarter;
  }

  // Step 4: Parent Information
  @action
  void setStep4Data({
    required String lastNameFather,
    required String firstNameFather,
    required String birthdateFather,
    required String birthplaceFather,
    required String lastNameMother,
    required String firstNameMother,
    required String birthdateMother,
    required String birthplaceMother,
  }) {
    this.lastNameFather = lastNameFather;
    this.firstNameFather = firstNameFather;
    this.birthdateFather = birthdateFather;
    this.birthplaceFather = birthplaceFather;
    this.lastNameMother = lastNameMother;
    this.firstNameMother = firstNameMother;
    this.birthdateMother = birthdateMother;
    this.birthplaceMother = birthplaceMother;
  }

  // Step 5: Center Information
  @action
  void setStep5Data({
    required DistrictModel? district,
    required CentreModel? scanCustomerCenter,
  }) {
    this.district = district;
    this.scanCustomerCenter = scanCustomerCenter;
  }

  // Step 6: Address Information
  @action
  void setStep6Data({
    required String address,
    required String? city,
    required String? commune,
    required String? quarter,
    required bool isCIESelected,
    required bool isSODECISelected,
    required List<PlatformFile> filesCIE,
    required List<PlatformFile> filesCertificat,
  }) {
    this.address = address;
    this.addressCity = city;
    this.addressCommune = commune;
    this.addressQuarter = quarter;
    this.isCIESelected = isCIESelected;
    this.isSODECISelected = isSODECISelected;
    this.step6FilesCIE.clear();
    this.step6FilesCertificat.clear();
    this.step6FilesCIE.addAll(filesCIE);
    this.step6FilesCertificat.addAll(filesCertificat);
  }

  // Step 7: Personal Contact Information
  @action
  void setStep7Data({
    required String phoneNumber,
    String? secondPhoneNumber,
    required String email,
    required String profession,
  }) {
    this.phoneNumber = phoneNumber;
    this.secondPhoneNumber = secondPhoneNumber ?? '';
    this.email = email;
    this.profession = profession;
  }

  @action
  void nextStep() {
    if (currentStep < 7) {
      currentStep++;
    } else {
      resetScanCustomer();
    }
  }

  @action
  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
    }
  }

  @action
  void goToStep(int step) {
    if (step >= 0 && step <= 7) {
      currentStep = step;
    }
  }

  @action
  Future<void> submitScanCustomer() async {
    isSubmitting = true;

    try {

      EnrollmentData? enrollmentData;
      // Simulate API delay
      final data = await submitScanCustomerpi();

      try{
        enrollmentData = EnrollmentData.fromJson(data['enrolement']);
        userStore.setUniqueRegistrationNumber(enrollmentData.numEnregister);
        appStore.setEnrollmentData(enrollmentData);
      }catch(e){
        print('Error submitting enrollment: $e');
      }

      // On successful submission
      isScanCustomerComplete = true;

      // Save completion status to preferences
      setValue(AppConstants.isEnrollmentCompleteKey, true);

      // Generate a unique reference number for this enrollment
      final String referenceNumber = enrollmentData != null ? enrollmentData.numEnregister.validate() : 'CEI-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
      setValue(AppConstants.enrollmentReferenceNumberKey, referenceNumber);

      // Set the reference number in the store
      scanCustomerReferenceNumber = referenceNumber;

      // Set submission date
      submissionDate = DateTime.now();

      // Set initial status
      scanCustomerStatus = 'Soumis';

      // Clear the enrollment data since it's been submitted
      setValue(AppConstants.hasEnrollmentDataKey, false);

      // Clear temporary files
      _clearTemporaryFiles();

    } catch (e) {
      // Handle errors
      print('Erreur lors de la soumission de l\'inscription: $e');
      _showErrorDialog('Erreur de soumission', '$e');
      isScanCustomerComplete = false;
    } finally {
      isSubmitting = false;
    }
  }
  void _showErrorDialog(String title, String message) {
    // Get the current context from navigator
    final context = navigatorKey.currentContext;

    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            content: Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      );
    } else {
      // Fallback to toast if context is not available
      toast(message);
    }
  }
  // Helper method to clear temporary file references
  void _clearTemporaryFiles() {
    // Clear document face photo path
    setValue('document_face_photo_path', '');

    // Clear verification status
    setValue('face_verification_result', false);
    setValue('face_verification_score', 0.0);
  }

  @action
  void resetScanCustomer() {
    // Reset Step 1: ID Document
    idFrontPhoto = null;
    idBackPhoto = null;
    documentFacePhoto = null;
    idType = null;
    idNumber = '';
    serialNumber = '';
    expireDate = null;
    issueDate = null;
    step1Files.clear();

    // Reset Step 2: ID Photo
    idPhoto = null;
    photoTaken = false;
    faceVerified = false;

    // Reset Step 3: Personal Information
    lastName = '';
    firstName = '';
    gender = null;
    city = null;
    commune = null;
    quarter = '';

    // Reset Step 4: Parent Information
    lastNameFather = '';
    firstNameFather = '';
    birthdateFather = '';
    birthplaceFather = '';
    lastNameMother = '';
    firstNameMother = '';
    birthdateMother = '';
    birthplaceMother = '';

    // Reset Step 5: Center Information
    district = null;
    scanCustomerCenter = null;

    // Reset Step 6: Address Information
    address = '';
    addressCity = null;
    addressCommune = null;
    addressQuarter = null;
    isCIESelected = false;
    isSODECISelected = false;
    step6FilesCIE.clear();
    step6FilesCertificat.clear();

    // Reset Step 7: Personal Contact Information
    phoneNumber = '';
    secondPhoneNumber = '';
    email = '';
    profession = '';

    // Reset progress
    currentStep = 0;
    isScanCustomerComplete = false;
    isSubmitting = false;

    // Clear temporary files
    _clearTemporaryFiles();
  }

  // Load saved data from local storage if needed
  @action
  Future<void> loadSavedScanCustomerData() async {
    // Check if there's a saved enrollment in progress
    bool hasSavedData = getBoolAsync(AppConstants.hasEnrollmentDataKey, defaultValue: false);

    if (hasSavedData) {
      // Load Step 1 & 2 data through file paths in prefs
      final documentFacePath = getStringAsync('document_face_photo_path');
      if (documentFacePath.isNotEmpty) {
        final documentFaceFile = File(documentFacePath);
        if (documentFaceFile.existsSync()) {
          documentFacePhoto = documentFaceFile;
        }
      }

      // Load verification status
      faceVerified = getBoolAsync('face_verification_result', defaultValue: false);

      // Load Step 3: Personal Information
      lastName = getStringAsync(AppConstants.enrollmentLastNameKey, defaultValue: '');
      firstName = getStringAsync(AppConstants.enrollmentFirstNameKey, defaultValue: '');
      gender = getStringAsync(AppConstants.enrollmentGenderKey);
      city = getStringAsync(AppConstants.enrollmentCityKey);
      commune = getStringAsync(AppConstants.enrollmentCommuneKey);
      quarter = getStringAsync(AppConstants.enrollmentQuarterKey, defaultValue: '');

      // Load Step 4: Parent Information
      lastNameFather = getStringAsync(AppConstants.enrollmentFatherLastNameKey, defaultValue: '');
      firstNameFather = getStringAsync(AppConstants.enrollmentFatherFirstNameKey, defaultValue: '');
      birthdateFather = getStringAsync(AppConstants.enrollmentFatherBirthdateKey, defaultValue: '');
      birthplaceFather = getStringAsync(AppConstants.enrollmentFatherBirthplaceKey, defaultValue: '');
      lastNameMother = getStringAsync(AppConstants.enrollmentMotherLastNameKey, defaultValue: '');
      firstNameMother = getStringAsync(AppConstants.enrollmentMotherFirstNameKey, defaultValue: '');
      birthdateMother = getStringAsync(AppConstants.enrollmentMotherBirthdateKey, defaultValue: '');
      birthplaceMother = getStringAsync(AppConstants.enrollmentMotherBirthplaceKey, defaultValue: '');

      // Step 7: Personal Contact Information
      phoneNumber = getStringAsync(AppConstants.enrollmentPhoneKey, defaultValue: '');
      secondPhoneNumber = getStringAsync(AppConstants.enrollmentSecondPhoneKey, defaultValue: '');
      email = getStringAsync(AppConstants.enrollmentEmailKey, defaultValue: '');
      profession = getStringAsync(AppConstants.enrollmentProfessionKey, defaultValue: '');

      // Load the last step the user was on
      currentStep = getIntAsync(AppConstants.enrollmentCurrentStepKey, defaultValue: 0);
    }
  }

  // Save current data to local storage
  @action
  Future<void> saveEnrollmentProgress() async {
    // Mark that we have saved enrollment data
    setValue(AppConstants.hasEnrollmentDataKey, true);

    // Save Step 3: Personal Information
    setValue(AppConstants.enrollmentLastNameKey, lastName);
    setValue(AppConstants.enrollmentFirstNameKey, firstName);
    setValue(AppConstants.enrollmentGenderKey, gender);
    setValue(AppConstants.enrollmentCityKey, city);
    setValue(AppConstants.enrollmentCommuneKey, commune);
    setValue(AppConstants.enrollmentQuarterKey, quarter);

    // Save face verification status
    setValue('face_verification_result', faceVerified);

    // Save Step 4: Parent Information
    setValue(AppConstants.enrollmentFatherLastNameKey, lastNameFather);
    setValue(AppConstants.enrollmentFatherFirstNameKey, firstNameFather);
    setValue(AppConstants.enrollmentFatherBirthdateKey, birthdateFather);
    setValue(AppConstants.enrollmentFatherBirthplaceKey, birthplaceFather);
    setValue(AppConstants.enrollmentMotherLastNameKey, lastNameMother);
    setValue(AppConstants.enrollmentMotherFirstNameKey, firstNameMother);
    setValue(AppConstants.enrollmentMotherBirthdateKey, birthdateMother);
    setValue(AppConstants.enrollmentMotherBirthplaceKey, birthplaceMother);

    // Save Step 7: Personal Contact Information
    setValue(AppConstants.enrollmentPhoneKey, phoneNumber);
    setValue(AppConstants.enrollmentSecondPhoneKey, secondPhoneNumber);
    setValue(AppConstants.enrollmentEmailKey, email);
    setValue(AppConstants.enrollmentProfessionKey, profession);

    // Save the current step
    setValue(AppConstants.enrollmentCurrentStepKey, currentStep);
  }

  @action
  Future<void> loadEnrollmentStatus() async {
    try {
      // Load the reference number from preferences
      scanCustomerReferenceNumber = getStringAsync(AppConstants.enrollmentReferenceNumberKey);

      if (scanCustomerReferenceNumber != null && scanCustomerReferenceNumber!.isNotEmpty) {
        // In a real app, you would make an API call here using the reference number
        // For now, we'll simulate getting data from API with a delay
        await Future.delayed(const Duration(seconds: 1));

        // Mock response
        scanCustomerStatus = 'En cours de traitement';
        submissionDate = DateTime.now().subtract(const Duration(days: 2));
      }
    } catch (e) {
      print('Error loading enrollment status: $e');
    }
  }

  @action
  Future<void> cancelEnrollment() async {
    try {
      // In a real app, you would make an API call to cancel the enrollment
      await Future.delayed(const Duration(milliseconds: 500));

      // Clear the stored reference number
      setValue(AppConstants.enrollmentReferenceNumberKey, null);
      scanCustomerReferenceNumber = null;
      scanCustomerStatus = 'Annulé';

      // Reset other enrollment-related fields
      isScanCustomerComplete = false;

      // Clear temporary files
      _clearTemporaryFiles();
    } catch (e) {
      print('Error cancelling enrollment: $e');
    }
  }
}