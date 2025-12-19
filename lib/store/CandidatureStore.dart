import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nb_utils/nb_utils.dart';

// Génération du fichier part
part 'CandidatureStore.g.dart';

// Définition du store avec MobX
class CandidatureStore = CandidatureStoreBase with _$CandidatureStore;

// Types d'élections supportés
enum ElectionType {
  presidentielle,
  legislative,
  senatoriale,
  regionale,
  municipale
}

// Status de la candidature
enum CandidatureStatus {
  brouillon,
  soumise,
  enCoursDeTraitement,
  validee,
  rejetee,
  annulee
}

// Modèle pour les circonscriptions électorales
class CirconscriptionModel {
  final String id;
  final String nom;
  final String type; // département, région, commune, etc.
  final int sieges;
  final String? parentId; // pour hiérarchie administrative

  CirconscriptionModel({
    required this.id,
    required this.nom,
    required this.type,
    required this.sieges,
    this.parentId
  });
}

// Modèle pour les documents requis
class DocumentRequis {
  final String code;
  final String nom;
  final String description;
  final bool obligatoire;
  final String? articleLegal;
  File? fichier;
  DateTime? dateUpload;

  DocumentRequis({
    required this.code,
    required this.nom,
    required this.description,
    required this.obligatoire,
    this.articleLegal,
    this.fichier,
    this.dateUpload,
  });
}

// Store de base pour la candidature
abstract class CandidatureStoreBase with Store {
  // Type d'élection choisie
  @observable
  ElectionType? electionType;

  // STEP 0: Déclaration de candidature (Article 51)
  @observable
  File? declarationCandidature;

  @observable
  DateTime? dateDeclarationCandidature;

  // STEP 1: Informations personnelles du candidat (Article 53)
  @observable
  String nom = '';

  @observable
  String prenoms = '';

  @observable
  DateTime? dateNaissance;

  @observable
  String lieuNaissance = '';

  @observable
  String nationalite = 'Ivoirienne';

  @observable
  String profession = '';

  @observable
  String domicile = '';

  @observable
  String? sexe;

  @observable
  String emailContact = '';

  @observable
  String telephoneContact = '';

  // STEP 2: Political Party Information (Statut de candidature)
  @observable
  bool? appartientPartiPolitique; // null = not selected, true = party member, false = independent

  @observable
  String? partiPolitique; // Party name

  @observable
  String sigleParti = ''; // Party acronym/sigle

  @observable
  String numeroCarteParti = ''; // Party membership card number

  @observable
  String couleurParti = ''; // Party color

  @observable
  File? logoParti; // Party logo

  @observable
  bool estCandidatIndependant = false; // Keep for backward compatibility

  // STEP 3: Filiation (Article 53 - obligatoire pour présidentielle)
  @observable
  String filiationPere = ''; // Nom complet du père

  @observable
  DateTime? dateNaissancePere;

  @observable
  String lieuNaissancePere = '';

  @observable
  String nationalitePere = '';

  @observable
  String filiationMere = ''; // Nom complet de la mère

  @observable
  DateTime? dateNaissanceMere;

  @observable
  String lieuNaissanceMere = '';

  @observable
  String nationaliteMere = '';

  // STEP 4: Identité visuelle de candidature (Articles 25-26)
  @observable
  String? couleurBulletin;

  @observable
  String? sigleChoisi;

  @observable
  File? symboleChoisi;

  // STEP 5: Documents requis selon l'Article 54
  @observable
  ObservableMap<String, DocumentRequis> documentsRequis = ObservableMap<String, DocumentRequis>();

  // STEP 6: Cautionnement (Article 55)
  @observable
  String? modePaiementCautionnement;

  @observable
  File? preuveCautionnement;

  @observable
  DateTime? datePaiementCautionnement;

  @observable
  double? montantCautionnement;

  // Informations électorales
  @observable
  CirconscriptionModel? circonscriptionElectorale;

  @observable
  ObservableList<String> colistiers = ObservableList<String>();

  @observable
  bool estListeComplete = false;

  // Statut de la candidature
  @observable
  int currentStep = 0;

  @observable
  bool isSubmitting = false;

  @observable
  CandidatureStatus candidatureStatus = CandidatureStatus.brouillon;

  @observable
  String? numeroDossierCandidature;

  @observable
  DateTime? dateDepotCandidature;

  @observable
  DateTime? dateLimiteDepot;

  @observable
  String? motifRejet;

  @observable
  bool certificationCEI = false;

  // STEP 7: Déclarations légales (Final validation)
  @observable
  bool declarationHonneur = false;

  @observable
  bool accepteConditions = false;

  @observable
  bool accepteTraitementDonnees = false;

  // Calculé: Documents requis selon le type d'élection
  @computed
  Map<String, DocumentRequis> get documentsSelonElection {
    Map<String, DocumentRequis> docs = {};

    // Documents communs à tous les types d'élections
    docs['photoIdentite'] = DocumentRequis(
      code: 'photoIdentite',
      nom: 'Photo d\'identité',
      description: 'Photo récente, fond blanc, format portrait',
      obligatoire: true,
      articleLegal: 'Article 20',
    );

    docs['pieceIdentite'] = DocumentRequis(
      code: 'pieceIdentite',
      nom: 'Pièce d\'identité',
      description: 'CNI, Passeport ou Attestation d\'identité en cours de validité',
      obligatoire: true,
      articleLegal: 'Article 12',
    );

    docs['certificatNationalite'] = DocumentRequis(
      code: 'certificatNationalite',
      nom: 'Certificat de nationalité',
      description: 'Certificat de nationalité ivoirienne',
      obligatoire: true,
      articleLegal: 'Article 15',
    );

    docs['certificatResidence'] = DocumentRequis(
      code: 'certificatResidence',
      nom: 'Certificat de résidence',
      description: 'Justificatif de résidence de moins de 3 mois',
      obligatoire: true,
      articleLegal: 'Article 18',
    );

    // Documents spécifiques à l'élection présidentielle
    if (electionType == ElectionType.presidentielle) {
      docs['extraitNaissance'] = DocumentRequis(
        code: 'extraitNaissance',
        nom: 'Extrait d\'acte de naissance',
        description: 'Ou jugement supplétif en tenant lieu',
        obligatoire: true,
        articleLegal: 'Article 54',
      );

      docs['declarationNonRenonciation'] = DocumentRequis(
        code: 'declarationNonRenonciation',
        nom: 'Déclaration de non-renonciation',
        description: 'Déclaration sur l\'honneur de non-renonciation à la nationalité',
        obligatoire: true,
        articleLegal: 'Article 54',
      );

      docs['extraitCasier'] = DocumentRequis(
        code: 'extraitCasier',
        nom: 'Extrait du casier judiciaire',
        description: 'Casier judiciaire de moins de 3 mois',
        obligatoire: true,
        articleLegal: 'Article 54',
      );

      docs['attestationFiscale'] = DocumentRequis(
        code: 'attestationFiscale',
        nom: 'Attestation de régularité fiscale',
        description: 'Attestation de moins de 3 mois',
        obligatoire: true,
        articleLegal: 'Article 54',
      );

      // Letter of investiture required if candidate belongs to a party
      if (appartientPartiPolitique == true) {
        docs['lettreInvestiture'] = DocumentRequis(
          code: 'lettreInvestiture',
          nom: 'Lettre d\'investiture',
          description: 'Lettre d\'investiture du parti politique',
          obligatoire: true,
          articleLegal: 'Article 54',
        );
      }
    }

    return docs;
  }

  // Montant du cautionnement selon le type d'élection
  @computed
  double get montantCautionnementRequis {
    switch (electionType) {
      case ElectionType.presidentielle:
        return 20000000; // 20 millions FCFA (Article 55)
      case ElectionType.legislative:
        return 500000; // 500 000 FCFA
      case ElectionType.senatoriale:
        return 1000000; // 1 million FCFA
      case ElectionType.regionale:
        return 300000; // 300 000 FCFA
      case ElectionType.municipale:
        return 200000; // 200 000 FCFA
      default:
        return 0;
    }
  }

  // STEP VALIDATIONS (Updated for 8-step process)

  // Step 0: Declaration validation
  @computed
  bool get isStep0Valid => declarationCandidature != null;

  // Step 1: Personal information validation
  @computed
  bool get isStep1Valid =>
      nom.isNotEmpty &&
          prenoms.isNotEmpty &&
          dateNaissance != null &&
          lieuNaissance.isNotEmpty &&
          nationalite.isNotEmpty &&
          profession.isNotEmpty &&
          domicile.isNotEmpty &&
          sexe != null &&
          emailContact.isNotEmpty &&
          telephoneContact.isNotEmpty &&
          verifierEligibiliteAge();

  // Step 2: Party information validation
  @computed
  bool get isStep2Valid => _isPartyInfoValid();

  // Step 3: Filiation validation
  @computed
  bool get isStep3Valid {
    // Pour l'élection présidentielle, la filiation est obligatoire
    if (electionType == ElectionType.presidentielle) {
      return filiationPere.isNotEmpty &&
          dateNaissancePere != null &&
          lieuNaissancePere.isNotEmpty &&
          nationalitePere.isNotEmpty &&
          filiationMere.isNotEmpty &&
          dateNaissanceMere != null &&
          lieuNaissanceMere.isNotEmpty &&
          nationaliteMere.isNotEmpty;
    }
    return true; // Pour les autres élections, cette étape est optionnelle
  }

  // Step 4: Visual identity validation
  @computed
  bool get isStep4Valid {
    if (electionType == ElectionType.presidentielle) {
      return couleurBulletin != null &&
          couleurBulletin!.isNotEmpty &&
          sigleChoisi != null &&
          sigleChoisi!.isNotEmpty &&
          !isUtilisationCouleursInterdites() &&
          symboleChoisi != null;
    }
    return true;
  }

  // Step 5: Documents validation
  @computed
  bool get isStep5Valid {
    bool allRequiredDocsUploaded = true;

    documentsSelonElection.forEach((key, doc) {
      if (doc.obligatoire && doc.fichier == null) {
        allRequiredDocsUploaded = false;
      }
    });

    return true;
  }

  // Step 6: Payment validation
  @computed
  bool get isStep6Valid {
    bool cautionnementValide = preuveCautionnement != null &&
        modePaiementCautionnement != null &&
        datePaiementCautionnement != null;

    return true;
  }

  // Step 7: Final declarations validation
  @computed
  bool get isStep7Valid {
    return declarationHonneur &&
        accepteConditions &&
        accepteTraitementDonnees;
  }

  @computed
  bool get isCandidatureComplete {
    return isStep0Valid &&
        isStep1Valid &&
        isStep2Valid &&
        isStep3Valid &&
        isStep4Valid &&
        isStep5Valid &&
        isStep6Valid &&
        isStep7Valid;
  }

  @computed
  bool get hasActiveCandidature =>
      numeroDossierCandidature != null &&
          numeroDossierCandidature!.isNotEmpty;

  // Validate party information
  bool _isPartyInfoValid() {
    if (appartientPartiPolitique == null) return false; // Must choose

    if (appartientPartiPolitique == true) {
      // If party member, party name and sigle are required
      return partiPolitique != null &&
          partiPolitique!.isNotEmpty &&
          sigleParti.isNotEmpty;
    }

    return true; // Independent candidate - no additional requirements
  }

  // Vérification d'éligibilité selon l'âge
  bool verifierEligibiliteAge() {
    if (dateNaissance == null) return false;

    final age = DateTime.now().year - dateNaissance!.year;

    // Ajuster si l'anniversaire n'est pas encore passé cette année
    if (DateTime.now().month < dateNaissance!.month ||
        (DateTime.now().month == dateNaissance!.month &&
            DateTime.now().day < dateNaissance!.day)) {
      return (age - 1) >= ageMinimumRequis;
    }

    return age >= ageMinimumRequis;
  }

  // Âge minimum selon le type d'élection
  @computed
  int get ageMinimumRequis {
    switch (electionType) {
      case ElectionType.presidentielle:
        return 35; // Article 53
      case ElectionType.legislative:
      case ElectionType.senatoriale:
      case ElectionType.regionale:
      case ElectionType.municipale:
        return 25; // Articles 71, 112, 150, 178
      default:
        return 18;
    }
  }

  // Vérification des couleurs interdites (Article 26)
  bool isUtilisationCouleursInterdites() {
    if (couleurBulletin == null) return false;

    String couleur = couleurBulletin!.toLowerCase();

    // Vérifier l'utilisation combinée des couleurs nationales
    List<String> couleursNationales = ['orange', 'blanc', 'vert', '#ff8c00', '#ffffff', '#008000'];

    // Cette vérification peut être plus sophistiquée selon les besoins
    return couleursNationales.any((c) => couleur.contains(c));
  }

  // Actions pour mettre à jour les données
  @action
  void setElectionType(ElectionType type) {
    electionType = type;
    montantCautionnement = montantCautionnementRequis;

    // Initialize documentsRequis with templates from documentsSelonElection
    documentsRequis.clear();
    documentsSelonElection.forEach((key, docTemplate) {
      documentsRequis[key] = DocumentRequis(
        code: docTemplate.code,
        nom: docTemplate.nom,
        description: docTemplate.description,
        obligatoire: docTemplate.obligatoire,
        articleLegal: docTemplate.articleLegal,
        fichier: null, // No file initially
        dateUpload: null,
      );
    });
  }

  @action
  void setDeclarationCandidature(File file) {
    declarationCandidature = file;
    dateDeclarationCandidature = DateTime.now();
  }

  @action
  void setStep1Data({
    required String nom,
    required String prenoms,
    required DateTime? dateNaissance,
    required String lieuNaissance,
    required String nationalite,
    required String profession,
    required String domicile,
    required String? sexe,
    required String emailContact,
    required String telephoneContact,
  }) {
    this.nom = nom;
    this.prenoms = prenoms;
    this.dateNaissance = dateNaissance;
    this.lieuNaissance = lieuNaissance;
    this.nationalite = nationalite;
    this.profession = profession;
    this.domicile = domicile;
    this.sexe = sexe;
    this.emailContact = emailContact;
    this.telephoneContact = telephoneContact;
  }

  @action
  void setStep3Data({
    required String filiationPere,
    required DateTime? dateNaissancePere,
    required String lieuNaissancePere,
    required String nationalitePere,
    required String filiationMere,
    required DateTime? dateNaissanceMere,
    required String lieuNaissanceMere,
    required String nationaliteMere,
  }) {
    this.filiationPere = filiationPere;
    this.dateNaissancePere = dateNaissancePere;
    this.lieuNaissancePere = lieuNaissancePere;
    this.nationalitePere = nationalitePere;
    this.filiationMere = filiationMere;
    this.dateNaissanceMere = dateNaissanceMere;
    this.lieuNaissanceMere = lieuNaissanceMere;
    this.nationaliteMere = nationaliteMere;
  }

  @action
  void setStep4Data({
    required String? couleurBulletin,
    required String? sigleChoisi,
    File? symboleChoisi,
    String? partiPolitique,
    bool? estCandidatIndependant,
  }) {
    this.couleurBulletin = couleurBulletin;
    this.sigleChoisi = sigleChoisi;
    if (symboleChoisi != null) this.symboleChoisi = symboleChoisi;
    this.partiPolitique = partiPolitique;
    if (estCandidatIndependant != null) {
      this.estCandidatIndependant = estCandidatIndependant;
    }
  }

  @action
  void uploadDocument(String codeDocument, File fichier) {
    // Update the document in documentsRequis
    if (documentsRequis.containsKey(codeDocument)) {
      // Create a new DocumentRequis instance to trigger MobX reactivity
      final existingDoc = documentsRequis[codeDocument]!;
      documentsRequis[codeDocument] = DocumentRequis(
        code: existingDoc.code,
        nom: existingDoc.nom,
        description: existingDoc.description,
        obligatoire: existingDoc.obligatoire,
        articleLegal: existingDoc.articleLegal,
        fichier: fichier,
        dateUpload: DateTime.now(),
      );
    } else {
      // If document doesn't exist in documentsRequis, get it from documentsSelonElection
      final docTemplate = documentsSelonElection[codeDocument];
      if (docTemplate != null) {
        final newDoc = DocumentRequis(
          code: docTemplate.code,
          nom: docTemplate.nom,
          description: docTemplate.description,
          obligatoire: docTemplate.obligatoire,
          articleLegal: docTemplate.articleLegal,
          fichier: fichier,
          dateUpload: DateTime.now(),
        );
        documentsRequis[codeDocument] = newDoc;
      }
    }

    // Force update of the observable map
    documentsRequis = ObservableMap.of(documentsRequis);
  }

  @action
  void setCautionnementData({
    required String? modePaiement,
    File? preuveCautionnement,
    required DateTime? datePaiement,
  }) {
    this.modePaiementCautionnement = modePaiement;
    if (preuveCautionnement != null) this.preuveCautionnement = preuveCautionnement;
    this.datePaiementCautionnement = datePaiement;
  }

  @action
  void setDeclarations({
    required bool declarationHonneur,
    required bool accepteConditions,
    required bool accepteTraitementDonnees,
  }) {
    this.declarationHonneur = declarationHonneur;
    this.accepteConditions = accepteConditions;
    this.accepteTraitementDonnees = accepteTraitementDonnees;
  }

  @action
  void nextStep() {
    if (currentStep < 7) { // 8 steps total (0-7)
      currentStep++;
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
    if (step >= 0 && step <= 7) { // 8 steps total (0-7)
      currentStep = step;
    }
  }

  @action
  Future<void> submitCandidature() async {
    isSubmitting = true;

    try {
      // Vérifications finales
      if (!isCandidatureComplete) {
        throw Exception('La candidature n\'est pas complète');
      }

      if (!verifierDelaiDepot()) {
        throw Exception('Le délai de dépôt des candidatures est dépassé');
      }

      // Simulation d'un délai d'API
      await Future.delayed(Duration(seconds: 3));

      // Générer un numéro de référence unique
      final String prefixe = _getPrefixeNumero();
      final String referenceNumber = '$prefixe-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

      // Mettre à jour le statut
      numeroDossierCandidature = referenceNumber;
      dateDepotCandidature = DateTime.now();
      candidatureStatus = CandidatureStatus.soumise;

      // Sauvegarder les données
      await saveCandidatureData();

      toast('Candidature soumise avec succès. Numéro de référence: $referenceNumber');

    } catch (e) {
      print('Erreur lors de la soumission de la candidature: $e');
      toast('Erreur lors de la soumission: ${e.toString()}');
      candidatureStatus = CandidatureStatus.brouillon;
    } finally {
      isSubmitting = false;
    }
  }

  String _getPrefixeNumero() {
    switch (electionType) {
      case ElectionType.presidentielle:
        return 'PRES-CI';
      case ElectionType.legislative:
        return 'LEG-CI';
      case ElectionType.senatoriale:
        return 'SEN-CI';
      case ElectionType.regionale:
        return 'REG-CI';
      case ElectionType.municipale:
        return 'MUN-CI';
      default:
        return 'CAND-CI';
    }
  }

  bool verifierDelaiDepot() {
    if (dateLimiteDepot == null) return true;
    return DateTime.now().isBefore(dateLimiteDepot!);
  }

  @action
  void resetCandidature() {
    // Réinitialiser toutes les données
    declarationCandidature = null;
    dateDeclarationCandidature = null;

    nom = '';
    prenoms = '';
    dateNaissance = null;
    lieuNaissance = '';
    nationalite = 'Ivoirienne';
    profession = '';
    domicile = '';
    sexe = null;
    emailContact = '';
    telephoneContact = '';

    filiationPere = '';
    dateNaissancePere = null;
    lieuNaissancePere = '';
    nationalitePere = '';
    filiationMere = '';
    dateNaissanceMere = null;
    lieuNaissanceMere = '';
    nationaliteMere = '';

    // Reset party information
    appartientPartiPolitique = null;
    partiPolitique = null;
    sigleParti = '';
    numeroCarteParti = '';
    couleurParti = '';
    logoParti = null;
    estCandidatIndependant = false;

    couleurBulletin = null;
    sigleChoisi = null;
    symboleChoisi = null;

    documentsRequis.clear();

    modePaiementCautionnement = null;
    preuveCautionnement = null;
    datePaiementCautionnement = null;

    declarationHonneur = false;
    accepteConditions = false;
    accepteTraitementDonnees = false;

    electionType = null;
    currentStep = 0;
    candidatureStatus = CandidatureStatus.brouillon;
    isSubmitting = false;
    numeroDossierCandidature = null;
    dateDepotCandidature = null;

    // Effacer les préférences
    removeKey('candidatureDataKey');
  }

  @action
  Future<void> saveCandidatureData() async {
    // Save document file paths
    Map<String, dynamic> documentsData = {};
    documentsRequis.forEach((key, doc) {
      documentsData[key] = {
        'fichier': doc.fichier?.path,
        'dateUpload': doc.dateUpload?.toIso8601String(),
      };
    });

    Map<String, dynamic> data = {
      'electionType': electionType?.index,
      'declarationCandidature': declarationCandidature?.path,
      'dateDeclarationCandidature': dateDeclarationCandidature?.toIso8601String(),
      'nom': nom,
      'prenoms': prenoms,
      'dateNaissance': dateNaissance?.toIso8601String(),
      'lieuNaissance': lieuNaissance,
      'nationalite': nationalite,
      'profession': profession,
      'domicile': domicile,
      'sexe': sexe,
      'emailContact': emailContact,
      'telephoneContact': telephoneContact,
      'filiationPere': filiationPere,
      'dateNaissancePere': dateNaissancePere?.toIso8601String(),
      'lieuNaissancePere': lieuNaissancePere,
      'nationalitePere': nationalitePere,
      'filiationMere': filiationMere,
      'dateNaissanceMere': dateNaissanceMere?.toIso8601String(),
      'lieuNaissanceMere': lieuNaissanceMere,
      'nationaliteMere': nationaliteMere,
      // Party information
      'appartientPartiPolitique': appartientPartiPolitique,
      'partiPolitique': partiPolitique,
      'sigleParti': sigleParti,
      'numeroCarteParti': numeroCarteParti,
      'couleurParti': couleurParti,
      'estCandidatIndependant': estCandidatIndependant,
      // Visual identity
      'couleurBulletin': couleurBulletin,
      'sigleChoisi': sigleChoisi,
      // Documents
      'documentsData': documentsData,
      'modePaiementCautionnement': modePaiementCautionnement,
      'datePaiementCautionnement': datePaiementCautionnement?.toIso8601String(),
      'declarationHonneur': declarationHonneur,
      'accepteConditions': accepteConditions,
      'accepteTraitementDonnees': accepteTraitementDonnees,
      'currentStep': currentStep,
      'candidatureStatus': candidatureStatus.index,
      'numeroDossierCandidature': numeroDossierCandidature,
      'dateDepotCandidature': dateDepotCandidature?.toIso8601String(),
    };

    await setValue('candidatureDataKey', data);
  }

  @action
  Future<void> loadSavedCandidatureData() async {
    try {
      Map<String, dynamic>? data = getJSONAsync('candidatureDataKey');

      if (data != null) {
        electionType = data['electionType'] != null
            ? ElectionType.values[data['electionType']]
            : null;

        if (data['declarationCandidature'] != null) {
          declarationCandidature = File(data['declarationCandidature']);
        }
        dateDeclarationCandidature = data['dateDeclarationCandidature'] != null
            ? DateTime.parse(data['dateDeclarationCandidature'])
            : null;

        nom = data['nom'] ?? '';
        prenoms = data['prenoms'] ?? '';
        dateNaissance = data['dateNaissance'] != null
            ? DateTime.parse(data['dateNaissance'])
            : null;
        lieuNaissance = data['lieuNaissance'] ?? '';
        nationalite = data['nationalite'] ?? 'Ivoirienne';
        profession = data['profession'] ?? '';
        domicile = data['domicile'] ?? '';
        sexe = data['sexe'];
        emailContact = data['emailContact'] ?? '';
        telephoneContact = data['telephoneContact'] ?? '';

        filiationPere = data['filiationPere'] ?? '';
        dateNaissancePere = data['dateNaissancePere'] != null
            ? DateTime.parse(data['dateNaissancePere'])
            : null;
        lieuNaissancePere = data['lieuNaissancePere'] ?? '';
        nationalitePere = data['nationalitePere'] ?? '';
        filiationMere = data['filiationMere'] ?? '';
        dateNaissanceMere = data['dateNaissanceMere'] != null
            ? DateTime.parse(data['dateNaissanceMere'])
            : null;
        lieuNaissanceMere = data['lieuNaissanceMere'] ?? '';
        nationaliteMere = data['nationaliteMere'] ?? '';

        // Load party information
        appartientPartiPolitique = data['appartientPartiPolitique'];
        partiPolitique = data['partiPolitique'];
        sigleParti = data['sigleParti'] ?? '';
        numeroCarteParti = data['numeroCarteParti'] ?? '';
        couleurParti = data['couleurParti'] ?? '';
        estCandidatIndependant = data['estCandidatIndependant'] ?? false;

        couleurBulletin = data['couleurBulletin'];
        sigleChoisi = data['sigleChoisi'];

        modePaiementCautionnement = data['modePaiementCautionnement'];
        datePaiementCautionnement = data['datePaiementCautionnement'] != null
            ? DateTime.parse(data['datePaiementCautionnement'])
            : null;

        declarationHonneur = data['declarationHonneur'] ?? false;
        accepteConditions = data['accepteConditions'] ?? false;
        accepteTraitementDonnees = data['accepteTraitementDonnees'] ?? false;

        currentStep = data['currentStep'] ?? 0;
        candidatureStatus = data['candidatureStatus'] != null
            ? CandidatureStatus.values[data['candidatureStatus']]
            : CandidatureStatus.brouillon;
        numeroDossierCandidature = data['numeroDossierCandidature'];
        dateDepotCandidature = data['dateDepotCandidature'] != null
            ? DateTime.parse(data['dateDepotCandidature'])
            : null;

        // Réinitialiser les documents selon le type d'élection
        if (electionType != null) {
          montantCautionnement = montantCautionnementRequis;
          // Initialize documentsRequis with fresh templates
          documentsRequis.clear();
          documentsSelonElection.forEach((key, docTemplate) {
            documentsRequis[key] = DocumentRequis(
              code: docTemplate.code,
              nom: docTemplate.nom,
              description: docTemplate.description,
              obligatoire: docTemplate.obligatoire,
              articleLegal: docTemplate.articleLegal,
              fichier: null, // Will be loaded from saved data
              dateUpload: null,
            );
          });

          // Load saved document files
          final documentsData = data['documentsData'] as Map<String, dynamic>?;
          if (documentsData != null) {
            documentsData.forEach((key, docData) {
              if (documentsRequis.containsKey(key) && docData['fichier'] != null) {
                documentsRequis[key]!.fichier = File(docData['fichier']);
                documentsRequis[key]!.dateUpload = docData['dateUpload'] != null
                    ? DateTime.parse(docData['dateUpload'])
                    : null;
              }
            });
          }
        }
      }
    } catch (e) {
      print('Erreur lors du chargement des données de candidature: $e');
    }
  }

  @action
  Future<void> checkCandidatureStatus() async {
    if (numeroDossierCandidature == null || numeroDossierCandidature!.isEmpty) {
      return;
    }

    try {
      // Simuler un appel API pour vérifier le statut
      await Future.delayed(Duration(seconds: 1));

      // Simuler différents statuts selon l'ancienneté
      if (dateDepotCandidature != null) {
        final daysSinceSubmission = DateTime.now().difference(dateDepotCandidature!).inDays;

        if (daysSinceSubmission < 3) {
          candidatureStatus = CandidatureStatus.enCoursDeTraitement;
        } else if (daysSinceSubmission < 7) {
          candidatureStatus = CandidatureStatus.validee;
          certificationCEI = true;
        }
      }

      await saveCandidatureData();
    } catch (e) {
      print('Erreur lors de la vérification du statut: $e');
    }
  }

  @action
  Future<void> cancelCandidature() async {
    try {
      // Simuler un appel API pour annuler la candidature
      await Future.delayed(Duration(milliseconds: 500));

      candidatureStatus = CandidatureStatus.annulee;
      await saveCandidatureData();

      toast('Candidature annulée avec succès');
    } catch (e) {
      print('Erreur lors de l\'annulation de la candidature: $e');
      toast('Erreur lors de l\'annulation');
    }
  }

  // Fonction pour vérifier l'éligibilité complète
  @computed
  bool get isEligible {
    if (dateNaissance == null || nationalite != 'Ivoirienne') {
      return false;
    }

    return verifierEligibiliteAge();
  }

  // Messages d'erreur pour l'éligibilité
  @computed
  String? get messageEligibilite {
    if (dateNaissance == null) {
      return 'Date de naissance requise';
    }

    if (nationalite != 'Ivoirienne') {
      return 'Seuls les citoyens ivoiriens peuvent se porter candidat';
    }

    if (!verifierEligibiliteAge()) {
      return 'Âge minimum requis: $ageMinimumRequis ans';
    }

    return null;
  }

  // Statut lisible de la candidature
  @computed
  String get statusLibelle {
    switch (candidatureStatus) {
      case CandidatureStatus.brouillon:
        return 'Brouillon';
      case CandidatureStatus.soumise:
        return 'Soumise';
      case CandidatureStatus.enCoursDeTraitement:
        return 'En cours de traitement';
      case CandidatureStatus.validee:
        return 'Validée';
      case CandidatureStatus.rejetee:
        return 'Rejetée';
      case CandidatureStatus.annulee:
        return 'Annulée';
    }
  }
}