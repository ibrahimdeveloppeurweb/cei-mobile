// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CandidatureStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CandidatureStore on CandidatureStoreBase, Store {
  Computed<Map<String, DocumentRequis>>? _$documentsSelonElectionComputed;

  @override
  Map<String, DocumentRequis> get documentsSelonElection =>
      (_$documentsSelonElectionComputed ??=
              Computed<Map<String, DocumentRequis>>(
                  () => super.documentsSelonElection,
                  name: 'CandidatureStoreBase.documentsSelonElection'))
          .value;
  Computed<double>? _$montantCautionnementRequisComputed;

  @override
  double get montantCautionnementRequis =>
      (_$montantCautionnementRequisComputed ??= Computed<double>(
              () => super.montantCautionnementRequis,
              name: 'CandidatureStoreBase.montantCautionnementRequis'))
          .value;
  Computed<bool>? _$isStep0ValidComputed;

  @override
  bool get isStep0Valid =>
      (_$isStep0ValidComputed ??= Computed<bool>(() => super.isStep0Valid,
              name: 'CandidatureStoreBase.isStep0Valid'))
          .value;
  Computed<bool>? _$isStep1ValidComputed;

  @override
  bool get isStep1Valid =>
      (_$isStep1ValidComputed ??= Computed<bool>(() => super.isStep1Valid,
              name: 'CandidatureStoreBase.isStep1Valid'))
          .value;
  Computed<bool>? _$isStep2ValidComputed;

  @override
  bool get isStep2Valid =>
      (_$isStep2ValidComputed ??= Computed<bool>(() => super.isStep2Valid,
              name: 'CandidatureStoreBase.isStep2Valid'))
          .value;
  Computed<bool>? _$isStep3ValidComputed;

  @override
  bool get isStep3Valid =>
      (_$isStep3ValidComputed ??= Computed<bool>(() => super.isStep3Valid,
              name: 'CandidatureStoreBase.isStep3Valid'))
          .value;
  Computed<bool>? _$isStep4ValidComputed;

  @override
  bool get isStep4Valid =>
      (_$isStep4ValidComputed ??= Computed<bool>(() => super.isStep4Valid,
              name: 'CandidatureStoreBase.isStep4Valid'))
          .value;
  Computed<bool>? _$isStep5ValidComputed;

  @override
  bool get isStep5Valid =>
      (_$isStep5ValidComputed ??= Computed<bool>(() => super.isStep5Valid,
              name: 'CandidatureStoreBase.isStep5Valid'))
          .value;
  Computed<bool>? _$isStep6ValidComputed;

  @override
  bool get isStep6Valid =>
      (_$isStep6ValidComputed ??= Computed<bool>(() => super.isStep6Valid,
              name: 'CandidatureStoreBase.isStep6Valid'))
          .value;
  Computed<bool>? _$isStep7ValidComputed;

  @override
  bool get isStep7Valid =>
      (_$isStep7ValidComputed ??= Computed<bool>(() => super.isStep7Valid,
              name: 'CandidatureStoreBase.isStep7Valid'))
          .value;
  Computed<bool>? _$isCandidatureCompleteComputed;

  @override
  bool get isCandidatureComplete => (_$isCandidatureCompleteComputed ??=
          Computed<bool>(() => super.isCandidatureComplete,
              name: 'CandidatureStoreBase.isCandidatureComplete'))
      .value;
  Computed<bool>? _$hasActiveCandidatureComputed;

  @override
  bool get hasActiveCandidature => (_$hasActiveCandidatureComputed ??=
          Computed<bool>(() => super.hasActiveCandidature,
              name: 'CandidatureStoreBase.hasActiveCandidature'))
      .value;
  Computed<int>? _$ageMinimumRequisComputed;

  @override
  int get ageMinimumRequis => (_$ageMinimumRequisComputed ??= Computed<int>(
          () => super.ageMinimumRequis,
          name: 'CandidatureStoreBase.ageMinimumRequis'))
      .value;
  Computed<bool>? _$isEligibleComputed;

  @override
  bool get isEligible =>
      (_$isEligibleComputed ??= Computed<bool>(() => super.isEligible,
              name: 'CandidatureStoreBase.isEligible'))
          .value;
  Computed<String?>? _$messageEligibiliteComputed;

  @override
  String? get messageEligibilite => (_$messageEligibiliteComputed ??=
          Computed<String?>(() => super.messageEligibilite,
              name: 'CandidatureStoreBase.messageEligibilite'))
      .value;
  Computed<String>? _$statusLibelleComputed;

  @override
  String get statusLibelle =>
      (_$statusLibelleComputed ??= Computed<String>(() => super.statusLibelle,
              name: 'CandidatureStoreBase.statusLibelle'))
          .value;

  late final _$electionTypeAtom =
      Atom(name: 'CandidatureStoreBase.electionType', context: context);

  @override
  ElectionType? get electionType {
    _$electionTypeAtom.reportRead();
    return super.electionType;
  }

  @override
  set electionType(ElectionType? value) {
    _$electionTypeAtom.reportWrite(value, super.electionType, () {
      super.electionType = value;
    });
  }

  late final _$declarationCandidatureAtom = Atom(
      name: 'CandidatureStoreBase.declarationCandidature', context: context);

  @override
  File? get declarationCandidature {
    _$declarationCandidatureAtom.reportRead();
    return super.declarationCandidature;
  }

  @override
  set declarationCandidature(File? value) {
    _$declarationCandidatureAtom
        .reportWrite(value, super.declarationCandidature, () {
      super.declarationCandidature = value;
    });
  }

  late final _$dateDeclarationCandidatureAtom = Atom(
      name: 'CandidatureStoreBase.dateDeclarationCandidature',
      context: context);

  @override
  DateTime? get dateDeclarationCandidature {
    _$dateDeclarationCandidatureAtom.reportRead();
    return super.dateDeclarationCandidature;
  }

  @override
  set dateDeclarationCandidature(DateTime? value) {
    _$dateDeclarationCandidatureAtom
        .reportWrite(value, super.dateDeclarationCandidature, () {
      super.dateDeclarationCandidature = value;
    });
  }

  late final _$nomAtom =
      Atom(name: 'CandidatureStoreBase.nom', context: context);

  @override
  String get nom {
    _$nomAtom.reportRead();
    return super.nom;
  }

  @override
  set nom(String value) {
    _$nomAtom.reportWrite(value, super.nom, () {
      super.nom = value;
    });
  }

  late final _$prenomsAtom =
      Atom(name: 'CandidatureStoreBase.prenoms', context: context);

  @override
  String get prenoms {
    _$prenomsAtom.reportRead();
    return super.prenoms;
  }

  @override
  set prenoms(String value) {
    _$prenomsAtom.reportWrite(value, super.prenoms, () {
      super.prenoms = value;
    });
  }

  late final _$dateNaissanceAtom =
      Atom(name: 'CandidatureStoreBase.dateNaissance', context: context);

  @override
  DateTime? get dateNaissance {
    _$dateNaissanceAtom.reportRead();
    return super.dateNaissance;
  }

  @override
  set dateNaissance(DateTime? value) {
    _$dateNaissanceAtom.reportWrite(value, super.dateNaissance, () {
      super.dateNaissance = value;
    });
  }

  late final _$lieuNaissanceAtom =
      Atom(name: 'CandidatureStoreBase.lieuNaissance', context: context);

  @override
  String get lieuNaissance {
    _$lieuNaissanceAtom.reportRead();
    return super.lieuNaissance;
  }

  @override
  set lieuNaissance(String value) {
    _$lieuNaissanceAtom.reportWrite(value, super.lieuNaissance, () {
      super.lieuNaissance = value;
    });
  }

  late final _$nationaliteAtom =
      Atom(name: 'CandidatureStoreBase.nationalite', context: context);

  @override
  String get nationalite {
    _$nationaliteAtom.reportRead();
    return super.nationalite;
  }

  @override
  set nationalite(String value) {
    _$nationaliteAtom.reportWrite(value, super.nationalite, () {
      super.nationalite = value;
    });
  }

  late final _$professionAtom =
      Atom(name: 'CandidatureStoreBase.profession', context: context);

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

  late final _$domicileAtom =
      Atom(name: 'CandidatureStoreBase.domicile', context: context);

  @override
  String get domicile {
    _$domicileAtom.reportRead();
    return super.domicile;
  }

  @override
  set domicile(String value) {
    _$domicileAtom.reportWrite(value, super.domicile, () {
      super.domicile = value;
    });
  }

  late final _$sexeAtom =
      Atom(name: 'CandidatureStoreBase.sexe', context: context);

  @override
  String? get sexe {
    _$sexeAtom.reportRead();
    return super.sexe;
  }

  @override
  set sexe(String? value) {
    _$sexeAtom.reportWrite(value, super.sexe, () {
      super.sexe = value;
    });
  }

  late final _$emailContactAtom =
      Atom(name: 'CandidatureStoreBase.emailContact', context: context);

  @override
  String get emailContact {
    _$emailContactAtom.reportRead();
    return super.emailContact;
  }

  @override
  set emailContact(String value) {
    _$emailContactAtom.reportWrite(value, super.emailContact, () {
      super.emailContact = value;
    });
  }

  late final _$telephoneContactAtom =
      Atom(name: 'CandidatureStoreBase.telephoneContact', context: context);

  @override
  String get telephoneContact {
    _$telephoneContactAtom.reportRead();
    return super.telephoneContact;
  }

  @override
  set telephoneContact(String value) {
    _$telephoneContactAtom.reportWrite(value, super.telephoneContact, () {
      super.telephoneContact = value;
    });
  }

  late final _$appartientPartiPolitiqueAtom = Atom(
      name: 'CandidatureStoreBase.appartientPartiPolitique', context: context);

  @override
  bool? get appartientPartiPolitique {
    _$appartientPartiPolitiqueAtom.reportRead();
    return super.appartientPartiPolitique;
  }

  @override
  set appartientPartiPolitique(bool? value) {
    _$appartientPartiPolitiqueAtom
        .reportWrite(value, super.appartientPartiPolitique, () {
      super.appartientPartiPolitique = value;
    });
  }

  late final _$partiPolitiqueAtom =
      Atom(name: 'CandidatureStoreBase.partiPolitique', context: context);

  @override
  String? get partiPolitique {
    _$partiPolitiqueAtom.reportRead();
    return super.partiPolitique;
  }

  @override
  set partiPolitique(String? value) {
    _$partiPolitiqueAtom.reportWrite(value, super.partiPolitique, () {
      super.partiPolitique = value;
    });
  }

  late final _$siglePartiAtom =
      Atom(name: 'CandidatureStoreBase.sigleParti', context: context);

  @override
  String get sigleParti {
    _$siglePartiAtom.reportRead();
    return super.sigleParti;
  }

  @override
  set sigleParti(String value) {
    _$siglePartiAtom.reportWrite(value, super.sigleParti, () {
      super.sigleParti = value;
    });
  }

  late final _$numeroCartePartiAtom =
      Atom(name: 'CandidatureStoreBase.numeroCarteParti', context: context);

  @override
  String get numeroCarteParti {
    _$numeroCartePartiAtom.reportRead();
    return super.numeroCarteParti;
  }

  @override
  set numeroCarteParti(String value) {
    _$numeroCartePartiAtom.reportWrite(value, super.numeroCarteParti, () {
      super.numeroCarteParti = value;
    });
  }

  late final _$couleurPartiAtom =
      Atom(name: 'CandidatureStoreBase.couleurParti', context: context);

  @override
  String get couleurParti {
    _$couleurPartiAtom.reportRead();
    return super.couleurParti;
  }

  @override
  set couleurParti(String value) {
    _$couleurPartiAtom.reportWrite(value, super.couleurParti, () {
      super.couleurParti = value;
    });
  }

  late final _$logoPartiAtom =
      Atom(name: 'CandidatureStoreBase.logoParti', context: context);

  @override
  File? get logoParti {
    _$logoPartiAtom.reportRead();
    return super.logoParti;
  }

  @override
  set logoParti(File? value) {
    _$logoPartiAtom.reportWrite(value, super.logoParti, () {
      super.logoParti = value;
    });
  }

  late final _$estCandidatIndependantAtom = Atom(
      name: 'CandidatureStoreBase.estCandidatIndependant', context: context);

  @override
  bool get estCandidatIndependant {
    _$estCandidatIndependantAtom.reportRead();
    return super.estCandidatIndependant;
  }

  @override
  set estCandidatIndependant(bool value) {
    _$estCandidatIndependantAtom
        .reportWrite(value, super.estCandidatIndependant, () {
      super.estCandidatIndependant = value;
    });
  }

  late final _$filiationPereAtom =
      Atom(name: 'CandidatureStoreBase.filiationPere', context: context);

  @override
  String get filiationPere {
    _$filiationPereAtom.reportRead();
    return super.filiationPere;
  }

  @override
  set filiationPere(String value) {
    _$filiationPereAtom.reportWrite(value, super.filiationPere, () {
      super.filiationPere = value;
    });
  }

  late final _$dateNaissancePereAtom =
      Atom(name: 'CandidatureStoreBase.dateNaissancePere', context: context);

  @override
  DateTime? get dateNaissancePere {
    _$dateNaissancePereAtom.reportRead();
    return super.dateNaissancePere;
  }

  @override
  set dateNaissancePere(DateTime? value) {
    _$dateNaissancePereAtom.reportWrite(value, super.dateNaissancePere, () {
      super.dateNaissancePere = value;
    });
  }

  late final _$lieuNaissancePereAtom =
      Atom(name: 'CandidatureStoreBase.lieuNaissancePere', context: context);

  @override
  String get lieuNaissancePere {
    _$lieuNaissancePereAtom.reportRead();
    return super.lieuNaissancePere;
  }

  @override
  set lieuNaissancePere(String value) {
    _$lieuNaissancePereAtom.reportWrite(value, super.lieuNaissancePere, () {
      super.lieuNaissancePere = value;
    });
  }

  late final _$nationalitePereAtom =
      Atom(name: 'CandidatureStoreBase.nationalitePere', context: context);

  @override
  String get nationalitePere {
    _$nationalitePereAtom.reportRead();
    return super.nationalitePere;
  }

  @override
  set nationalitePere(String value) {
    _$nationalitePereAtom.reportWrite(value, super.nationalitePere, () {
      super.nationalitePere = value;
    });
  }

  late final _$filiationMereAtom =
      Atom(name: 'CandidatureStoreBase.filiationMere', context: context);

  @override
  String get filiationMere {
    _$filiationMereAtom.reportRead();
    return super.filiationMere;
  }

  @override
  set filiationMere(String value) {
    _$filiationMereAtom.reportWrite(value, super.filiationMere, () {
      super.filiationMere = value;
    });
  }

  late final _$dateNaissanceMereAtom =
      Atom(name: 'CandidatureStoreBase.dateNaissanceMere', context: context);

  @override
  DateTime? get dateNaissanceMere {
    _$dateNaissanceMereAtom.reportRead();
    return super.dateNaissanceMere;
  }

  @override
  set dateNaissanceMere(DateTime? value) {
    _$dateNaissanceMereAtom.reportWrite(value, super.dateNaissanceMere, () {
      super.dateNaissanceMere = value;
    });
  }

  late final _$lieuNaissanceMereAtom =
      Atom(name: 'CandidatureStoreBase.lieuNaissanceMere', context: context);

  @override
  String get lieuNaissanceMere {
    _$lieuNaissanceMereAtom.reportRead();
    return super.lieuNaissanceMere;
  }

  @override
  set lieuNaissanceMere(String value) {
    _$lieuNaissanceMereAtom.reportWrite(value, super.lieuNaissanceMere, () {
      super.lieuNaissanceMere = value;
    });
  }

  late final _$nationaliteMereAtom =
      Atom(name: 'CandidatureStoreBase.nationaliteMere', context: context);

  @override
  String get nationaliteMere {
    _$nationaliteMereAtom.reportRead();
    return super.nationaliteMere;
  }

  @override
  set nationaliteMere(String value) {
    _$nationaliteMereAtom.reportWrite(value, super.nationaliteMere, () {
      super.nationaliteMere = value;
    });
  }

  late final _$couleurBulletinAtom =
      Atom(name: 'CandidatureStoreBase.couleurBulletin', context: context);

  @override
  String? get couleurBulletin {
    _$couleurBulletinAtom.reportRead();
    return super.couleurBulletin;
  }

  @override
  set couleurBulletin(String? value) {
    _$couleurBulletinAtom.reportWrite(value, super.couleurBulletin, () {
      super.couleurBulletin = value;
    });
  }

  late final _$sigleChoisiAtom =
      Atom(name: 'CandidatureStoreBase.sigleChoisi', context: context);

  @override
  String? get sigleChoisi {
    _$sigleChoisiAtom.reportRead();
    return super.sigleChoisi;
  }

  @override
  set sigleChoisi(String? value) {
    _$sigleChoisiAtom.reportWrite(value, super.sigleChoisi, () {
      super.sigleChoisi = value;
    });
  }

  late final _$symboleChoisiAtom =
      Atom(name: 'CandidatureStoreBase.symboleChoisi', context: context);

  @override
  File? get symboleChoisi {
    _$symboleChoisiAtom.reportRead();
    return super.symboleChoisi;
  }

  @override
  set symboleChoisi(File? value) {
    _$symboleChoisiAtom.reportWrite(value, super.symboleChoisi, () {
      super.symboleChoisi = value;
    });
  }

  late final _$documentsRequisAtom =
      Atom(name: 'CandidatureStoreBase.documentsRequis', context: context);

  @override
  ObservableMap<String, DocumentRequis> get documentsRequis {
    _$documentsRequisAtom.reportRead();
    return super.documentsRequis;
  }

  @override
  set documentsRequis(ObservableMap<String, DocumentRequis> value) {
    _$documentsRequisAtom.reportWrite(value, super.documentsRequis, () {
      super.documentsRequis = value;
    });
  }

  late final _$modePaiementCautionnementAtom = Atom(
      name: 'CandidatureStoreBase.modePaiementCautionnement', context: context);

  @override
  String? get modePaiementCautionnement {
    _$modePaiementCautionnementAtom.reportRead();
    return super.modePaiementCautionnement;
  }

  @override
  set modePaiementCautionnement(String? value) {
    _$modePaiementCautionnementAtom
        .reportWrite(value, super.modePaiementCautionnement, () {
      super.modePaiementCautionnement = value;
    });
  }

  late final _$preuveCautionnementAtom =
      Atom(name: 'CandidatureStoreBase.preuveCautionnement', context: context);

  @override
  File? get preuveCautionnement {
    _$preuveCautionnementAtom.reportRead();
    return super.preuveCautionnement;
  }

  @override
  set preuveCautionnement(File? value) {
    _$preuveCautionnementAtom.reportWrite(value, super.preuveCautionnement, () {
      super.preuveCautionnement = value;
    });
  }

  late final _$datePaiementCautionnementAtom = Atom(
      name: 'CandidatureStoreBase.datePaiementCautionnement', context: context);

  @override
  DateTime? get datePaiementCautionnement {
    _$datePaiementCautionnementAtom.reportRead();
    return super.datePaiementCautionnement;
  }

  @override
  set datePaiementCautionnement(DateTime? value) {
    _$datePaiementCautionnementAtom
        .reportWrite(value, super.datePaiementCautionnement, () {
      super.datePaiementCautionnement = value;
    });
  }

  late final _$montantCautionnementAtom =
      Atom(name: 'CandidatureStoreBase.montantCautionnement', context: context);

  @override
  double? get montantCautionnement {
    _$montantCautionnementAtom.reportRead();
    return super.montantCautionnement;
  }

  @override
  set montantCautionnement(double? value) {
    _$montantCautionnementAtom.reportWrite(value, super.montantCautionnement,
        () {
      super.montantCautionnement = value;
    });
  }

  late final _$circonscriptionElectoraleAtom = Atom(
      name: 'CandidatureStoreBase.circonscriptionElectorale', context: context);

  @override
  CirconscriptionModel? get circonscriptionElectorale {
    _$circonscriptionElectoraleAtom.reportRead();
    return super.circonscriptionElectorale;
  }

  @override
  set circonscriptionElectorale(CirconscriptionModel? value) {
    _$circonscriptionElectoraleAtom
        .reportWrite(value, super.circonscriptionElectorale, () {
      super.circonscriptionElectorale = value;
    });
  }

  late final _$colistiersAtom =
      Atom(name: 'CandidatureStoreBase.colistiers', context: context);

  @override
  ObservableList<String> get colistiers {
    _$colistiersAtom.reportRead();
    return super.colistiers;
  }

  @override
  set colistiers(ObservableList<String> value) {
    _$colistiersAtom.reportWrite(value, super.colistiers, () {
      super.colistiers = value;
    });
  }

  late final _$estListeCompleteAtom =
      Atom(name: 'CandidatureStoreBase.estListeComplete', context: context);

  @override
  bool get estListeComplete {
    _$estListeCompleteAtom.reportRead();
    return super.estListeComplete;
  }

  @override
  set estListeComplete(bool value) {
    _$estListeCompleteAtom.reportWrite(value, super.estListeComplete, () {
      super.estListeComplete = value;
    });
  }

  late final _$currentStepAtom =
      Atom(name: 'CandidatureStoreBase.currentStep', context: context);

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

  late final _$isSubmittingAtom =
      Atom(name: 'CandidatureStoreBase.isSubmitting', context: context);

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

  late final _$candidatureStatusAtom =
      Atom(name: 'CandidatureStoreBase.candidatureStatus', context: context);

  @override
  CandidatureStatus get candidatureStatus {
    _$candidatureStatusAtom.reportRead();
    return super.candidatureStatus;
  }

  @override
  set candidatureStatus(CandidatureStatus value) {
    _$candidatureStatusAtom.reportWrite(value, super.candidatureStatus, () {
      super.candidatureStatus = value;
    });
  }

  late final _$numeroDossierCandidatureAtom = Atom(
      name: 'CandidatureStoreBase.numeroDossierCandidature', context: context);

  @override
  String? get numeroDossierCandidature {
    _$numeroDossierCandidatureAtom.reportRead();
    return super.numeroDossierCandidature;
  }

  @override
  set numeroDossierCandidature(String? value) {
    _$numeroDossierCandidatureAtom
        .reportWrite(value, super.numeroDossierCandidature, () {
      super.numeroDossierCandidature = value;
    });
  }

  late final _$dateDepotCandidatureAtom =
      Atom(name: 'CandidatureStoreBase.dateDepotCandidature', context: context);

  @override
  DateTime? get dateDepotCandidature {
    _$dateDepotCandidatureAtom.reportRead();
    return super.dateDepotCandidature;
  }

  @override
  set dateDepotCandidature(DateTime? value) {
    _$dateDepotCandidatureAtom.reportWrite(value, super.dateDepotCandidature,
        () {
      super.dateDepotCandidature = value;
    });
  }

  late final _$dateLimiteDepotAtom =
      Atom(name: 'CandidatureStoreBase.dateLimiteDepot', context: context);

  @override
  DateTime? get dateLimiteDepot {
    _$dateLimiteDepotAtom.reportRead();
    return super.dateLimiteDepot;
  }

  @override
  set dateLimiteDepot(DateTime? value) {
    _$dateLimiteDepotAtom.reportWrite(value, super.dateLimiteDepot, () {
      super.dateLimiteDepot = value;
    });
  }

  late final _$motifRejetAtom =
      Atom(name: 'CandidatureStoreBase.motifRejet', context: context);

  @override
  String? get motifRejet {
    _$motifRejetAtom.reportRead();
    return super.motifRejet;
  }

  @override
  set motifRejet(String? value) {
    _$motifRejetAtom.reportWrite(value, super.motifRejet, () {
      super.motifRejet = value;
    });
  }

  late final _$certificationCEIAtom =
      Atom(name: 'CandidatureStoreBase.certificationCEI', context: context);

  @override
  bool get certificationCEI {
    _$certificationCEIAtom.reportRead();
    return super.certificationCEI;
  }

  @override
  set certificationCEI(bool value) {
    _$certificationCEIAtom.reportWrite(value, super.certificationCEI, () {
      super.certificationCEI = value;
    });
  }

  late final _$declarationHonneurAtom =
      Atom(name: 'CandidatureStoreBase.declarationHonneur', context: context);

  @override
  bool get declarationHonneur {
    _$declarationHonneurAtom.reportRead();
    return super.declarationHonneur;
  }

  @override
  set declarationHonneur(bool value) {
    _$declarationHonneurAtom.reportWrite(value, super.declarationHonneur, () {
      super.declarationHonneur = value;
    });
  }

  late final _$accepteConditionsAtom =
      Atom(name: 'CandidatureStoreBase.accepteConditions', context: context);

  @override
  bool get accepteConditions {
    _$accepteConditionsAtom.reportRead();
    return super.accepteConditions;
  }

  @override
  set accepteConditions(bool value) {
    _$accepteConditionsAtom.reportWrite(value, super.accepteConditions, () {
      super.accepteConditions = value;
    });
  }

  late final _$accepteTraitementDonneesAtom = Atom(
      name: 'CandidatureStoreBase.accepteTraitementDonnees', context: context);

  @override
  bool get accepteTraitementDonnees {
    _$accepteTraitementDonneesAtom.reportRead();
    return super.accepteTraitementDonnees;
  }

  @override
  set accepteTraitementDonnees(bool value) {
    _$accepteTraitementDonneesAtom
        .reportWrite(value, super.accepteTraitementDonnees, () {
      super.accepteTraitementDonnees = value;
    });
  }

  late final _$submitCandidatureAsyncAction =
      AsyncAction('CandidatureStoreBase.submitCandidature', context: context);

  @override
  Future<void> submitCandidature() {
    return _$submitCandidatureAsyncAction.run(() => super.submitCandidature());
  }

  late final _$saveCandidatureDataAsyncAction =
      AsyncAction('CandidatureStoreBase.saveCandidatureData', context: context);

  @override
  Future<void> saveCandidatureData() {
    return _$saveCandidatureDataAsyncAction
        .run(() => super.saveCandidatureData());
  }

  late final _$loadSavedCandidatureDataAsyncAction = AsyncAction(
      'CandidatureStoreBase.loadSavedCandidatureData',
      context: context);

  @override
  Future<void> loadSavedCandidatureData() {
    return _$loadSavedCandidatureDataAsyncAction
        .run(() => super.loadSavedCandidatureData());
  }

  late final _$checkCandidatureStatusAsyncAction = AsyncAction(
      'CandidatureStoreBase.checkCandidatureStatus',
      context: context);

  @override
  Future<void> checkCandidatureStatus() {
    return _$checkCandidatureStatusAsyncAction
        .run(() => super.checkCandidatureStatus());
  }

  late final _$cancelCandidatureAsyncAction =
      AsyncAction('CandidatureStoreBase.cancelCandidature', context: context);

  @override
  Future<void> cancelCandidature() {
    return _$cancelCandidatureAsyncAction.run(() => super.cancelCandidature());
  }

  late final _$CandidatureStoreBaseActionController =
      ActionController(name: 'CandidatureStoreBase', context: context);

  @override
  void setElectionType(ElectionType type) {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.setElectionType');
    try {
      return super.setElectionType(type);
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDeclarationCandidature(File file) {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.setDeclarationCandidature');
    try {
      return super.setDeclarationCandidature(file);
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStep1Data(
      {required String nom,
      required String prenoms,
      required DateTime? dateNaissance,
      required String lieuNaissance,
      required String nationalite,
      required String profession,
      required String domicile,
      required String? sexe,
      required String emailContact,
      required String telephoneContact}) {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.setStep1Data');
    try {
      return super.setStep1Data(
          nom: nom,
          prenoms: prenoms,
          dateNaissance: dateNaissance,
          lieuNaissance: lieuNaissance,
          nationalite: nationalite,
          profession: profession,
          domicile: domicile,
          sexe: sexe,
          emailContact: emailContact,
          telephoneContact: telephoneContact);
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStep3Data(
      {required String filiationPere,
      required DateTime? dateNaissancePere,
      required String lieuNaissancePere,
      required String nationalitePere,
      required String filiationMere,
      required DateTime? dateNaissanceMere,
      required String lieuNaissanceMere,
      required String nationaliteMere}) {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.setStep3Data');
    try {
      return super.setStep3Data(
          filiationPere: filiationPere,
          dateNaissancePere: dateNaissancePere,
          lieuNaissancePere: lieuNaissancePere,
          nationalitePere: nationalitePere,
          filiationMere: filiationMere,
          dateNaissanceMere: dateNaissanceMere,
          lieuNaissanceMere: lieuNaissanceMere,
          nationaliteMere: nationaliteMere);
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStep4Data(
      {required String? couleurBulletin,
      required String? sigleChoisi,
      File? symboleChoisi,
      String? partiPolitique,
      bool? estCandidatIndependant}) {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.setStep4Data');
    try {
      return super.setStep4Data(
          couleurBulletin: couleurBulletin,
          sigleChoisi: sigleChoisi,
          symboleChoisi: symboleChoisi,
          partiPolitique: partiPolitique,
          estCandidatIndependant: estCandidatIndependant);
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void uploadDocument(String codeDocument, File fichier) {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.uploadDocument');
    try {
      return super.uploadDocument(codeDocument, fichier);
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCautionnementData(
      {required String? modePaiement,
      File? preuveCautionnement,
      required DateTime? datePaiement}) {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.setCautionnementData');
    try {
      return super.setCautionnementData(
          modePaiement: modePaiement,
          preuveCautionnement: preuveCautionnement,
          datePaiement: datePaiement);
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDeclarations(
      {required bool declarationHonneur,
      required bool accepteConditions,
      required bool accepteTraitementDonnees}) {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.setDeclarations');
    try {
      return super.setDeclarations(
          declarationHonneur: declarationHonneur,
          accepteConditions: accepteConditions,
          accepteTraitementDonnees: accepteTraitementDonnees);
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextStep() {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.nextStep');
    try {
      return super.nextStep();
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void previousStep() {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.previousStep');
    try {
      return super.previousStep();
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToStep(int step) {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.goToStep');
    try {
      return super.goToStep(step);
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetCandidature() {
    final _$actionInfo = _$CandidatureStoreBaseActionController.startAction(
        name: 'CandidatureStoreBase.resetCandidature');
    try {
      return super.resetCandidature();
    } finally {
      _$CandidatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
electionType: ${electionType},
declarationCandidature: ${declarationCandidature},
dateDeclarationCandidature: ${dateDeclarationCandidature},
nom: ${nom},
prenoms: ${prenoms},
dateNaissance: ${dateNaissance},
lieuNaissance: ${lieuNaissance},
nationalite: ${nationalite},
profession: ${profession},
domicile: ${domicile},
sexe: ${sexe},
emailContact: ${emailContact},
telephoneContact: ${telephoneContact},
appartientPartiPolitique: ${appartientPartiPolitique},
partiPolitique: ${partiPolitique},
sigleParti: ${sigleParti},
numeroCarteParti: ${numeroCarteParti},
couleurParti: ${couleurParti},
logoParti: ${logoParti},
estCandidatIndependant: ${estCandidatIndependant},
filiationPere: ${filiationPere},
dateNaissancePere: ${dateNaissancePere},
lieuNaissancePere: ${lieuNaissancePere},
nationalitePere: ${nationalitePere},
filiationMere: ${filiationMere},
dateNaissanceMere: ${dateNaissanceMere},
lieuNaissanceMere: ${lieuNaissanceMere},
nationaliteMere: ${nationaliteMere},
couleurBulletin: ${couleurBulletin},
sigleChoisi: ${sigleChoisi},
symboleChoisi: ${symboleChoisi},
documentsRequis: ${documentsRequis},
modePaiementCautionnement: ${modePaiementCautionnement},
preuveCautionnement: ${preuveCautionnement},
datePaiementCautionnement: ${datePaiementCautionnement},
montantCautionnement: ${montantCautionnement},
circonscriptionElectorale: ${circonscriptionElectorale},
colistiers: ${colistiers},
estListeComplete: ${estListeComplete},
currentStep: ${currentStep},
isSubmitting: ${isSubmitting},
candidatureStatus: ${candidatureStatus},
numeroDossierCandidature: ${numeroDossierCandidature},
dateDepotCandidature: ${dateDepotCandidature},
dateLimiteDepot: ${dateLimiteDepot},
motifRejet: ${motifRejet},
certificationCEI: ${certificationCEI},
declarationHonneur: ${declarationHonneur},
accepteConditions: ${accepteConditions},
accepteTraitementDonnees: ${accepteTraitementDonnees},
documentsSelonElection: ${documentsSelonElection},
montantCautionnementRequis: ${montantCautionnementRequis},
isStep0Valid: ${isStep0Valid},
isStep1Valid: ${isStep1Valid},
isStep2Valid: ${isStep2Valid},
isStep3Valid: ${isStep3Valid},
isStep4Valid: ${isStep4Valid},
isStep5Valid: ${isStep5Valid},
isStep6Valid: ${isStep6Valid},
isStep7Valid: ${isStep7Valid},
isCandidatureComplete: ${isCandidatureComplete},
hasActiveCandidature: ${hasActiveCandidature},
ageMinimumRequis: ${ageMinimumRequis},
isEligible: ${isEligible},
messageEligibilite: ${messageEligibilite},
statusLibelle: ${statusLibelle}
    ''';
  }
}
