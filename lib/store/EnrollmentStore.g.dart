// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EnrollmentStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EnrollmentStore on EnrollmentStoreBase, Store {
  Computed<bool>? _$hasActiveEnrollmentComputed;

  @override
  bool get hasActiveEnrollment => (_$hasActiveEnrollmentComputed ??=
          Computed<bool>(() => super.hasActiveEnrollment,
              name: 'EnrollmentStoreBase.hasActiveEnrollment'))
      .value;
  Computed<bool>? _$isStep1ValidComputed;

  @override
  bool get isStep1Valid =>
      (_$isStep1ValidComputed ??= Computed<bool>(() => super.isStep1Valid,
              name: 'EnrollmentStoreBase.isStep1Valid'))
          .value;
  Computed<bool>? _$isStep2ValidComputed;

  @override
  bool get isStep2Valid =>
      (_$isStep2ValidComputed ??= Computed<bool>(() => super.isStep2Valid,
              name: 'EnrollmentStoreBase.isStep2Valid'))
          .value;
  Computed<bool>? _$isStep3ValidComputed;

  @override
  bool get isStep3Valid =>
      (_$isStep3ValidComputed ??= Computed<bool>(() => super.isStep3Valid,
              name: 'EnrollmentStoreBase.isStep3Valid'))
          .value;
  Computed<bool>? _$isStep4ValidComputed;

  @override
  bool get isStep4Valid =>
      (_$isStep4ValidComputed ??= Computed<bool>(() => super.isStep4Valid,
              name: 'EnrollmentStoreBase.isStep4Valid'))
          .value;
  Computed<bool>? _$isStep5ValidComputed;

  @override
  bool get isStep5Valid =>
      (_$isStep5ValidComputed ??= Computed<bool>(() => super.isStep5Valid,
              name: 'EnrollmentStoreBase.isStep5Valid'))
          .value;
  Computed<bool>? _$isStep6ValidComputed;

  @override
  bool get isStep6Valid =>
      (_$isStep6ValidComputed ??= Computed<bool>(() => super.isStep6Valid,
              name: 'EnrollmentStoreBase.isStep6Valid'))
          .value;
  Computed<bool>? _$isStep7ValidComputed;

  @override
  bool get isStep7Valid =>
      (_$isStep7ValidComputed ??= Computed<bool>(() => super.isStep7Valid,
              name: 'EnrollmentStoreBase.isStep7Valid'))
          .value;

  late final _$idFrontPhotoAtom =
      Atom(name: 'EnrollmentStoreBase.idFrontPhoto', context: context);

  @override
  File? get idFrontPhoto {
    _$idFrontPhotoAtom.reportRead();
    return super.idFrontPhoto;
  }

  @override
  set idFrontPhoto(File? value) {
    _$idFrontPhotoAtom.reportWrite(value, super.idFrontPhoto, () {
      super.idFrontPhoto = value;
    });
  }

  late final _$idBackPhotoAtom =
      Atom(name: 'EnrollmentStoreBase.idBackPhoto', context: context);

  @override
  File? get idBackPhoto {
    _$idBackPhotoAtom.reportRead();
    return super.idBackPhoto;
  }

  @override
  set idBackPhoto(File? value) {
    _$idBackPhotoAtom.reportWrite(value, super.idBackPhoto, () {
      super.idBackPhoto = value;
    });
  }

  late final _$documentFacePhotoAtom =
      Atom(name: 'EnrollmentStoreBase.documentFacePhoto', context: context);

  @override
  File? get documentFacePhoto {
    _$documentFacePhotoAtom.reportRead();
    return super.documentFacePhoto;
  }

  @override
  set documentFacePhoto(File? value) {
    _$documentFacePhotoAtom.reportWrite(value, super.documentFacePhoto, () {
      super.documentFacePhoto = value;
    });
  }

  late final _$idTypeAtom =
      Atom(name: 'EnrollmentStoreBase.idType', context: context);

  @override
  String? get idType {
    _$idTypeAtom.reportRead();
    return super.idType;
  }

  @override
  set idType(String? value) {
    _$idTypeAtom.reportWrite(value, super.idType, () {
      super.idType = value;
    });
  }

  late final _$idNumberAtom =
      Atom(name: 'EnrollmentStoreBase.idNumber', context: context);

  @override
  String get idNumber {
    _$idNumberAtom.reportRead();
    return super.idNumber;
  }

  @override
  set idNumber(String value) {
    _$idNumberAtom.reportWrite(value, super.idNumber, () {
      super.idNumber = value;
    });
  }

  late final _$serialNumberAtom =
      Atom(name: 'EnrollmentStoreBase.serialNumber', context: context);

  @override
  String get serialNumber {
    _$serialNumberAtom.reportRead();
    return super.serialNumber;
  }

  @override
  set serialNumber(String value) {
    _$serialNumberAtom.reportWrite(value, super.serialNumber, () {
      super.serialNumber = value;
    });
  }

  late final _$expireDateAtom =
      Atom(name: 'EnrollmentStoreBase.expireDate', context: context);

  @override
  DateTime? get expireDate {
    _$expireDateAtom.reportRead();
    return super.expireDate;
  }

  @override
  set expireDate(DateTime? value) {
    _$expireDateAtom.reportWrite(value, super.expireDate, () {
      super.expireDate = value;
    });
  }

  late final _$issueDateAtom =
      Atom(name: 'EnrollmentStoreBase.issueDate', context: context);

  @override
  DateTime? get issueDate {
    _$issueDateAtom.reportRead();
    return super.issueDate;
  }

  @override
  set issueDate(DateTime? value) {
    _$issueDateAtom.reportWrite(value, super.issueDate, () {
      super.issueDate = value;
    });
  }

  late final _$nationalityAtom =
      Atom(name: 'EnrollmentStoreBase.nationality', context: context);

  @override
  String get nationality {
    _$nationalityAtom.reportRead();
    return super.nationality;
  }

  @override
  set nationality(String value) {
    _$nationalityAtom.reportWrite(value, super.nationality, () {
      super.nationality = value;
    });
  }

  late final _$dobAtom =
      Atom(name: 'EnrollmentStoreBase.dob', context: context);

  @override
  String get dob {
    _$dobAtom.reportRead();
    return super.dob;
  }

  @override
  set dob(String value) {
    _$dobAtom.reportWrite(value, super.dob, () {
      super.dob = value;
    });
  }

  late final _$placeOfBirthAtom =
      Atom(name: 'EnrollmentStoreBase.placeOfBirth', context: context);

  @override
  String get placeOfBirth {
    _$placeOfBirthAtom.reportRead();
    return super.placeOfBirth;
  }

  @override
  set placeOfBirth(String value) {
    _$placeOfBirthAtom.reportWrite(value, super.placeOfBirth, () {
      super.placeOfBirth = value;
    });
  }

  late final _$professionAtom =
      Atom(name: 'EnrollmentStoreBase.profession', context: context);

  @override
  String get profession {
    _$professionAtom.reportRead();
    return super.profession;
  }

  @override
  set profession(String value) {
    _$professionAtom.reportWrite(value, super.profession, () {
      super.profession = value;
    });
  }

  late final _$personalNumberAtom =
      Atom(name: 'EnrollmentStoreBase.personalNumber', context: context);

  @override
  String get personalNumber {
    _$personalNumberAtom.reportRead();
    return super.personalNumber;
  }

  @override
  set personalNumber(String value) {
    _$personalNumberAtom.reportWrite(value, super.personalNumber, () {
      super.personalNumber = value;
    });
  }

  late final _$heightAtom =
      Atom(name: 'EnrollmentStoreBase.height', context: context);

  @override
  String get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(String value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  late final _$ageAtom =
      Atom(name: 'EnrollmentStoreBase.age', context: context);

  @override
  String get age {
    _$ageAtom.reportRead();
    return super.age;
  }

  @override
  set age(String value) {
    _$ageAtom.reportWrite(value, super.age, () {
      super.age = value;
    });
  }

  late final _$issuePlaceAtom =
      Atom(name: 'EnrollmentStoreBase.issuePlace', context: context);

  @override
  String get issuePlace {
    _$issuePlaceAtom.reportRead();
    return super.issuePlace;
  }

  @override
  set issuePlace(String value) {
    _$issuePlaceAtom.reportWrite(value, super.issuePlace, () {
      super.issuePlace = value;
    });
  }

  late final _$cardAccessNumberAtom =
      Atom(name: 'EnrollmentStoreBase.cardAccessNumber', context: context);

  @override
  String get cardAccessNumber {
    _$cardAccessNumberAtom.reportRead();
    return super.cardAccessNumber;
  }

  @override
  set cardAccessNumber(String value) {
    _$cardAccessNumberAtom.reportWrite(value, super.cardAccessNumber, () {
      super.cardAccessNumber = value;
    });
  }

  late final _$step1FilesAtom =
      Atom(name: 'EnrollmentStoreBase.step1Files', context: context);

  @override
  ObservableList<PlatformFile> get step1Files {
    _$step1FilesAtom.reportRead();
    return super.step1Files;
  }

  @override
  set step1Files(ObservableList<PlatformFile> value) {
    _$step1FilesAtom.reportWrite(value, super.step1Files, () {
      super.step1Files = value;
    });
  }

  late final _$idPhotoAtom =
      Atom(name: 'EnrollmentStoreBase.idPhoto', context: context);

  @override
  File? get idPhoto {
    _$idPhotoAtom.reportRead();
    return super.idPhoto;
  }

  @override
  set idPhoto(File? value) {
    _$idPhotoAtom.reportWrite(value, super.idPhoto, () {
      super.idPhoto = value;
    });
  }

  late final _$photoTakenAtom =
      Atom(name: 'EnrollmentStoreBase.photoTaken', context: context);

  @override
  bool get photoTaken {
    _$photoTakenAtom.reportRead();
    return super.photoTaken;
  }

  @override
  set photoTaken(bool value) {
    _$photoTakenAtom.reportWrite(value, super.photoTaken, () {
      super.photoTaken = value;
    });
  }

  late final _$faceVerifiedAtom =
      Atom(name: 'EnrollmentStoreBase.faceVerified', context: context);

  @override
  bool get faceVerified {
    _$faceVerifiedAtom.reportRead();
    return super.faceVerified;
  }

  @override
  set faceVerified(bool value) {
    _$faceVerifiedAtom.reportWrite(value, super.faceVerified, () {
      super.faceVerified = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: 'EnrollmentStoreBase.lastName', context: context);

  @override
  String get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$firstNameAtom =
      Atom(name: 'EnrollmentStoreBase.firstName', context: context);

  @override
  String get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  late final _$genderAtom =
      Atom(name: 'EnrollmentStoreBase.gender', context: context);

  @override
  String? get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String? value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$cityAtom =
      Atom(name: 'EnrollmentStoreBase.city', context: context);

  @override
  String? get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(String? value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  late final _$communeAtom =
      Atom(name: 'EnrollmentStoreBase.commune', context: context);

  @override
  String? get commune {
    _$communeAtom.reportRead();
    return super.commune;
  }

  @override
  set commune(String? value) {
    _$communeAtom.reportWrite(value, super.commune, () {
      super.commune = value;
    });
  }

  late final _$quarterAtom =
      Atom(name: 'EnrollmentStoreBase.quarter', context: context);

  @override
  String get quarter {
    _$quarterAtom.reportRead();
    return super.quarter;
  }

  @override
  set quarter(String value) {
    _$quarterAtom.reportWrite(value, super.quarter, () {
      super.quarter = value;
    });
  }

  late final _$lastNameFatherAtom =
      Atom(name: 'EnrollmentStoreBase.lastNameFather', context: context);

  @override
  String get lastNameFather {
    _$lastNameFatherAtom.reportRead();
    return super.lastNameFather;
  }

  @override
  set lastNameFather(String value) {
    _$lastNameFatherAtom.reportWrite(value, super.lastNameFather, () {
      super.lastNameFather = value;
    });
  }

  late final _$firstNameFatherAtom =
      Atom(name: 'EnrollmentStoreBase.firstNameFather', context: context);

  @override
  String get firstNameFather {
    _$firstNameFatherAtom.reportRead();
    return super.firstNameFather;
  }

  @override
  set firstNameFather(String value) {
    _$firstNameFatherAtom.reportWrite(value, super.firstNameFather, () {
      super.firstNameFather = value;
    });
  }

  late final _$birthdateFatherAtom =
      Atom(name: 'EnrollmentStoreBase.birthdateFather', context: context);

  @override
  String get birthdateFather {
    _$birthdateFatherAtom.reportRead();
    return super.birthdateFather;
  }

  @override
  set birthdateFather(String value) {
    _$birthdateFatherAtom.reportWrite(value, super.birthdateFather, () {
      super.birthdateFather = value;
    });
  }

  late final _$birthplaceFatherAtom =
      Atom(name: 'EnrollmentStoreBase.birthplaceFather', context: context);

  @override
  String get birthplaceFather {
    _$birthplaceFatherAtom.reportRead();
    return super.birthplaceFather;
  }

  @override
  set birthplaceFather(String value) {
    _$birthplaceFatherAtom.reportWrite(value, super.birthplaceFather, () {
      super.birthplaceFather = value;
    });
  }

  late final _$lastNameMotherAtom =
      Atom(name: 'EnrollmentStoreBase.lastNameMother', context: context);

  @override
  String get lastNameMother {
    _$lastNameMotherAtom.reportRead();
    return super.lastNameMother;
  }

  @override
  set lastNameMother(String value) {
    _$lastNameMotherAtom.reportWrite(value, super.lastNameMother, () {
      super.lastNameMother = value;
    });
  }

  late final _$firstNameMotherAtom =
      Atom(name: 'EnrollmentStoreBase.firstNameMother', context: context);

  @override
  String get firstNameMother {
    _$firstNameMotherAtom.reportRead();
    return super.firstNameMother;
  }

  @override
  set firstNameMother(String value) {
    _$firstNameMotherAtom.reportWrite(value, super.firstNameMother, () {
      super.firstNameMother = value;
    });
  }

  late final _$birthdateMotherAtom =
      Atom(name: 'EnrollmentStoreBase.birthdateMother', context: context);

  @override
  String get birthdateMother {
    _$birthdateMotherAtom.reportRead();
    return super.birthdateMother;
  }

  @override
  set birthdateMother(String value) {
    _$birthdateMotherAtom.reportWrite(value, super.birthdateMother, () {
      super.birthdateMother = value;
    });
  }

  late final _$birthplaceMotherAtom =
      Atom(name: 'EnrollmentStoreBase.birthplaceMother', context: context);

  @override
  String get birthplaceMother {
    _$birthplaceMotherAtom.reportRead();
    return super.birthplaceMother;
  }

  @override
  set birthplaceMother(String value) {
    _$birthplaceMotherAtom.reportWrite(value, super.birthplaceMother, () {
      super.birthplaceMother = value;
    });
  }

  late final _$enrollmentCenterAtom =
      Atom(name: 'EnrollmentStoreBase.enrollmentCenter', context: context);

  @override
  CentreModel? get enrollmentCenter {
    _$enrollmentCenterAtom.reportRead();
    return super.enrollmentCenter;
  }

  @override
  set enrollmentCenter(CentreModel? value) {
    _$enrollmentCenterAtom.reportWrite(value, super.enrollmentCenter, () {
      super.enrollmentCenter = value;
    });
  }

  late final _$districtAtom =
      Atom(name: 'EnrollmentStoreBase.district', context: context);

  @override
  DistrictModel? get district {
    _$districtAtom.reportRead();
    return super.district;
  }

  @override
  set district(DistrictModel? value) {
    _$districtAtom.reportWrite(value, super.district, () {
      super.district = value;
    });
  }

  late final _$addressAtom =
      Atom(name: 'EnrollmentStoreBase.address', context: context);

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  late final _$addressCityAtom =
      Atom(name: 'EnrollmentStoreBase.addressCity', context: context);

  @override
  String? get addressCity {
    _$addressCityAtom.reportRead();
    return super.addressCity;
  }

  @override
  set addressCity(String? value) {
    _$addressCityAtom.reportWrite(value, super.addressCity, () {
      super.addressCity = value;
    });
  }

  late final _$addressCommuneAtom =
      Atom(name: 'EnrollmentStoreBase.addressCommune', context: context);

  @override
  String? get addressCommune {
    _$addressCommuneAtom.reportRead();
    return super.addressCommune;
  }

  @override
  set addressCommune(String? value) {
    _$addressCommuneAtom.reportWrite(value, super.addressCommune, () {
      super.addressCommune = value;
    });
  }

  late final _$addressQuarterAtom =
      Atom(name: 'EnrollmentStoreBase.addressQuarter', context: context);

  @override
  String? get addressQuarter {
    _$addressQuarterAtom.reportRead();
    return super.addressQuarter;
  }

  @override
  set addressQuarter(String? value) {
    _$addressQuarterAtom.reportWrite(value, super.addressQuarter, () {
      super.addressQuarter = value;
    });
  }

  late final _$isCIESelectedAtom =
      Atom(name: 'EnrollmentStoreBase.isCIESelected', context: context);

  @override
  bool get isCIESelected {
    _$isCIESelectedAtom.reportRead();
    return super.isCIESelected;
  }

  @override
  set isCIESelected(bool value) {
    _$isCIESelectedAtom.reportWrite(value, super.isCIESelected, () {
      super.isCIESelected = value;
    });
  }

  late final _$isSODECISelectedAtom =
      Atom(name: 'EnrollmentStoreBase.isSODECISelected', context: context);

  @override
  bool get isSODECISelected {
    _$isSODECISelectedAtom.reportRead();
    return super.isSODECISelected;
  }

  @override
  set isSODECISelected(bool value) {
    _$isSODECISelectedAtom.reportWrite(value, super.isSODECISelected, () {
      super.isSODECISelected = value;
    });
  }

  late final _$step6FilesCIEAtom =
      Atom(name: 'EnrollmentStoreBase.step6FilesCIE', context: context);

  @override
  ObservableList<PlatformFile> get step6FilesCIE {
    _$step6FilesCIEAtom.reportRead();
    return super.step6FilesCIE;
  }

  @override
  set step6FilesCIE(ObservableList<PlatformFile> value) {
    _$step6FilesCIEAtom.reportWrite(value, super.step6FilesCIE, () {
      super.step6FilesCIE = value;
    });
  }

  late final _$step6FilesCertificatAtom =
      Atom(name: 'EnrollmentStoreBase.step6FilesCertificat', context: context);

  @override
  ObservableList<PlatformFile> get step6FilesCertificat {
    _$step6FilesCertificatAtom.reportRead();
    return super.step6FilesCertificat;
  }

  @override
  set step6FilesCertificat(ObservableList<PlatformFile> value) {
    _$step6FilesCertificatAtom.reportWrite(value, super.step6FilesCertificat,
        () {
      super.step6FilesCertificat = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: 'EnrollmentStoreBase.phoneNumber', context: context);

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$secondPhoneNumberAtom =
      Atom(name: 'EnrollmentStoreBase.secondPhoneNumber', context: context);

  @override
  String get secondPhoneNumber {
    _$secondPhoneNumberAtom.reportRead();
    return super.secondPhoneNumber;
  }

  @override
  set secondPhoneNumber(String value) {
    _$secondPhoneNumberAtom.reportWrite(value, super.secondPhoneNumber, () {
      super.secondPhoneNumber = value;
    });
  }

  late final _$emailAtom =
      Atom(name: 'EnrollmentStoreBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$currentStepAtom =
      Atom(name: 'EnrollmentStoreBase.currentStep', context: context);

  @override
  int get currentStep {
    _$currentStepAtom.reportRead();
    return super.currentStep;
  }

  @override
  set currentStep(int value) {
    _$currentStepAtom.reportWrite(value, super.currentStep, () {
      super.currentStep = value;
    });
  }

  late final _$isEnrollmentCompleteAtom =
      Atom(name: 'EnrollmentStoreBase.isEnrollmentComplete', context: context);

  @override
  bool get isEnrollmentComplete {
    _$isEnrollmentCompleteAtom.reportRead();
    return super.isEnrollmentComplete;
  }

  @override
  set isEnrollmentComplete(bool value) {
    _$isEnrollmentCompleteAtom.reportWrite(value, super.isEnrollmentComplete,
        () {
      super.isEnrollmentComplete = value;
    });
  }

  late final _$isSubmittingAtom =
      Atom(name: 'EnrollmentStoreBase.isSubmitting', context: context);

  @override
  bool get isSubmitting {
    _$isSubmittingAtom.reportRead();
    return super.isSubmitting;
  }

  @override
  set isSubmitting(bool value) {
    _$isSubmittingAtom.reportWrite(value, super.isSubmitting, () {
      super.isSubmitting = value;
    });
  }

  late final _$enrollmentReferenceNumberAtom = Atom(
      name: 'EnrollmentStoreBase.enrollmentReferenceNumber', context: context);

  @override
  String? get enrollmentReferenceNumber {
    _$enrollmentReferenceNumberAtom.reportRead();
    return super.enrollmentReferenceNumber;
  }

  @override
  set enrollmentReferenceNumber(String? value) {
    _$enrollmentReferenceNumberAtom
        .reportWrite(value, super.enrollmentReferenceNumber, () {
      super.enrollmentReferenceNumber = value;
    });
  }

  late final _$enrollmentStatusAtom =
      Atom(name: 'EnrollmentStoreBase.enrollmentStatus', context: context);

  @override
  String get enrollmentStatus {
    _$enrollmentStatusAtom.reportRead();
    return super.enrollmentStatus;
  }

  @override
  set enrollmentStatus(String value) {
    _$enrollmentStatusAtom.reportWrite(value, super.enrollmentStatus, () {
      super.enrollmentStatus = value;
    });
  }

  late final _$submissionDateAtom =
      Atom(name: 'EnrollmentStoreBase.submissionDate', context: context);

  @override
  DateTime? get submissionDate {
    _$submissionDateAtom.reportRead();
    return super.submissionDate;
  }

  @override
  set submissionDate(DateTime? value) {
    _$submissionDateAtom.reportWrite(value, super.submissionDate, () {
      super.submissionDate = value;
    });
  }

  late final _$submitEnrollmentAsyncAction =
      AsyncAction('EnrollmentStoreBase.submitEnrollment', context: context);

  @override
  Future<void> submitEnrollment() {
    return _$submitEnrollmentAsyncAction.run(() => super.submitEnrollment());
  }

  late final _$loadSavedEnrollmentDataAsyncAction = AsyncAction(
      'EnrollmentStoreBase.loadSavedEnrollmentData',
      context: context);

  @override
  Future<void> loadSavedEnrollmentData() {
    return _$loadSavedEnrollmentDataAsyncAction
        .run(() => super.loadSavedEnrollmentData());
  }

  late final _$saveEnrollmentProgressAsyncAction = AsyncAction(
      'EnrollmentStoreBase.saveEnrollmentProgress',
      context: context);

  @override
  Future<void> saveEnrollmentProgress() {
    return _$saveEnrollmentProgressAsyncAction
        .run(() => super.saveEnrollmentProgress());
  }

  late final _$loadEnrollmentStatusAsyncAction =
      AsyncAction('EnrollmentStoreBase.loadEnrollmentStatus', context: context);

  @override
  Future<void> loadEnrollmentStatus() {
    return _$loadEnrollmentStatusAsyncAction
        .run(() => super.loadEnrollmentStatus());
  }

  late final _$cancelEnrollmentAsyncAction =
      AsyncAction('EnrollmentStoreBase.cancelEnrollment', context: context);

  @override
  Future<void> cancelEnrollment() {
    return _$cancelEnrollmentAsyncAction.run(() => super.cancelEnrollment());
  }

  late final _$EnrollmentStoreBaseActionController =
      ActionController(name: 'EnrollmentStoreBase', context: context);

  @override
  void setStep1Data(
      {File? idFrontPhoto,
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
      List<PlatformFile>? files}) {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.setStep1Data');
    try {
      return super.setStep1Data(
          idFrontPhoto: idFrontPhoto,
          idBackPhoto: idBackPhoto,
          documentFacePhoto: documentFacePhoto,
          idType: idType,
          idNumber: idNumber,
          serialNumber: serialNumber,
          expireDate: expireDate,
          issueDate: issueDate,
          lastName: lastName,
          firstName: firstName,
          gender: gender,
          birthplace: birthplace,
          nationality: nationality,
          dob: dob,
          placeOfBirth: placeOfBirth,
          profession: profession,
          personalNumber: personalNumber,
          height: height,
          age: age,
          issuePlace: issuePlace,
          cardAccessNumber: cardAccessNumber,
          files: files);
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStep2Data({File? idPhoto, bool? photoTaken, bool? faceVerified}) {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.setStep2Data');
    try {
      return super.setStep2Data(
          idPhoto: idPhoto, photoTaken: photoTaken, faceVerified: faceVerified);
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStep3Data(
      {required String? city,
      required String? commune,
      required String quarter}) {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.setStep3Data');
    try {
      return super.setStep3Data(city: city, commune: commune, quarter: quarter);
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStep4Data(
      {required String lastNameFather,
      required String firstNameFather,
      required String birthdateFather,
      required String birthplaceFather,
      required String lastNameMother,
      required String firstNameMother,
      required String birthdateMother,
      required String birthplaceMother}) {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.setStep4Data');
    try {
      return super.setStep4Data(
          lastNameFather: lastNameFather,
          firstNameFather: firstNameFather,
          birthdateFather: birthdateFather,
          birthplaceFather: birthplaceFather,
          lastNameMother: lastNameMother,
          firstNameMother: firstNameMother,
          birthdateMother: birthdateMother,
          birthplaceMother: birthplaceMother);
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStep5Data(
      {required DistrictModel? district,
      required CentreModel? enrollmentCenter}) {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.setStep5Data');
    try {
      return super
          .setStep5Data(district: district, enrollmentCenter: enrollmentCenter);
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStep6Data(
      {required String address,
      required String? city,
      required String? commune,
      required String? quarter,
      required bool isCIESelected,
      required bool isSODECISelected,
      required List<PlatformFile> filesCIE,
      required List<PlatformFile> filesCertificat}) {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.setStep6Data');
    try {
      return super.setStep6Data(
          address: address,
          city: city,
          commune: commune,
          quarter: quarter,
          isCIESelected: isCIESelected,
          isSODECISelected: isSODECISelected,
          filesCIE: filesCIE,
          filesCertificat: filesCertificat);
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStep7Data(
      {required String phoneNumber,
      String? secondPhoneNumber,
      required String email,
      required String profession}) {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.setStep7Data');
    try {
      return super.setStep7Data(
          phoneNumber: phoneNumber,
          secondPhoneNumber: secondPhoneNumber,
          email: email,
          profession: profession);
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextStep() {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.nextStep');
    try {
      return super.nextStep();
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void previousStep() {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.previousStep');
    try {
      return super.previousStep();
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToStep(int step) {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.goToStep');
    try {
      return super.goToStep(step);
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetEnrollment() {
    final _$actionInfo = _$EnrollmentStoreBaseActionController.startAction(
        name: 'EnrollmentStoreBase.resetEnrollment');
    try {
      return super.resetEnrollment();
    } finally {
      _$EnrollmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
idFrontPhoto: ${idFrontPhoto},
idBackPhoto: ${idBackPhoto},
documentFacePhoto: ${documentFacePhoto},
idType: ${idType},
idNumber: ${idNumber},
serialNumber: ${serialNumber},
expireDate: ${expireDate},
issueDate: ${issueDate},
nationality: ${nationality},
dob: ${dob},
placeOfBirth: ${placeOfBirth},
profession: ${profession},
personalNumber: ${personalNumber},
height: ${height},
age: ${age},
issuePlace: ${issuePlace},
cardAccessNumber: ${cardAccessNumber},
step1Files: ${step1Files},
idPhoto: ${idPhoto},
photoTaken: ${photoTaken},
faceVerified: ${faceVerified},
lastName: ${lastName},
firstName: ${firstName},
gender: ${gender},
city: ${city},
commune: ${commune},
quarter: ${quarter},
lastNameFather: ${lastNameFather},
firstNameFather: ${firstNameFather},
birthdateFather: ${birthdateFather},
birthplaceFather: ${birthplaceFather},
lastNameMother: ${lastNameMother},
firstNameMother: ${firstNameMother},
birthdateMother: ${birthdateMother},
birthplaceMother: ${birthplaceMother},
enrollmentCenter: ${enrollmentCenter},
district: ${district},
address: ${address},
addressCity: ${addressCity},
addressCommune: ${addressCommune},
addressQuarter: ${addressQuarter},
isCIESelected: ${isCIESelected},
isSODECISelected: ${isSODECISelected},
step6FilesCIE: ${step6FilesCIE},
step6FilesCertificat: ${step6FilesCertificat},
phoneNumber: ${phoneNumber},
secondPhoneNumber: ${secondPhoneNumber},
email: ${email},
currentStep: ${currentStep},
isEnrollmentComplete: ${isEnrollmentComplete},
isSubmitting: ${isSubmitting},
enrollmentReferenceNumber: ${enrollmentReferenceNumber},
enrollmentStatus: ${enrollmentStatus},
submissionDate: ${submissionDate},
hasActiveEnrollment: ${hasActiveEnrollment},
isStep1Valid: ${isStep1Valid},
isStep2Valid: ${isStep2Valid},
isStep3Valid: ${isStep3Valid},
isStep4Valid: ${isStep4Valid},
isStep5Valid: ${isStep5Valid},
isStep6Valid: ${isStep6Valid},
isStep7Valid: ${isStep7Valid}
    ''';
  }
}
