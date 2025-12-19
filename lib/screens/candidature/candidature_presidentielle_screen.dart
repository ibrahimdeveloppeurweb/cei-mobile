import 'dart:io';

import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/model/partie_model.dart';
import 'package:cei_mobile/repository/parties_repository.dart';
import 'package:cei_mobile/screens/candidature/payment_step.dart';
import 'package:cei_mobile/screens/candidature/personnal_info_step.dart';
import 'package:cei_mobile/screens/candidature/visual_identity_step.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';
import 'package:cei_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import 'candidature_status_step.dart';
import 'declaration_candidature_step.dart';
import 'documents_step.dart';
import 'filiation_step.dart';
import 'final_validation_step.dart';
import 'widgets/step_indicator.dart';
import 'widgets/navigation_buttons.dart';

import 'utils/validation_utils.dart';

class CandidaturePresidentiellePage extends StatefulWidget {
  const CandidaturePresidentiellePage({super.key});

  @override
  _CandidaturePresidentiellePageState createState() => _CandidaturePresidentiellePageState();
}

class _CandidaturePresidentiellePageState extends State<CandidaturePresidentiellePage> {
  final CandidatureStore store = candidatureStore;
  final PageController _pageController = PageController();

  // Parties state
  List<Partie> parties = [];
  bool isLoadingParties = false;
  String? partiesError;
  Partie? selectedPartie;

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    // Load saved data first
    await store.loadSavedCandidatureData();

    // Set election type
    store.setElectionType(ElectionType.presidentielle);

    // Populate with enrollment data if available
    _populateWithEnrollmentData();

    // Load parties
    await _loadParties();

    // Navigate to saved step
    if (store.currentStep > 0 && _pageController.hasClients) {
      _pageController.jumpToPage(store.currentStep);
    }

    setState(() {});
  }

  Future<void> _loadParties() async {
    setState(() {
      isLoadingParties = true;
      partiesError = null;
    });

    try {
      final partiesData = await getParties();
      print('Loaded parties: $partiesData');
      parties.clear();
      for (var partie in partiesData['data']) {
        parties.add(Partie.fromJson(partie['list']));
      }
      setState(() {
        isLoadingParties = false;
      });
    } catch (e) {
      setState(() {
        partiesError = 'Erreur lors du chargement des partis: $e';
        isLoadingParties = false;
      });
      print('Error loading parties: $e');
    }
  }

  void _populateWithEnrollmentData() {
    final enrollmentData = appStore.enrollmentData;

    if (enrollmentData != null) {
      // Personal Information
      if (store.nom.isEmpty && enrollmentData.lastName?.isNotEmpty == true) {
        store.nom = enrollmentData.lastName!;
      }
      if (store.prenoms.isEmpty && enrollmentData.firstName?.isNotEmpty == true) {
        store.prenoms = enrollmentData.firstName!;
      }

      // Date of birth
      if (store.dateNaissance == null && enrollmentData.birthdate != null) {
        store.dateNaissance = enrollmentData.birthdate;
      }

      // Place of birth
      if (store.lieuNaissance.isEmpty && enrollmentData.birthplace?.isNotEmpty == true) {
        store.lieuNaissance = enrollmentData.birthplace!;
      }

      // Gender conversion
      if (store.sexe == null && enrollmentData.gender?.isNotEmpty == true) {
        switch (enrollmentData.gender?.toLowerCase()) {
          case 'masculin':
          case 'homme':
          case 'male':
          case 'm':
            store.sexe = 'M';
            break;
          case 'féminin':
          case 'femme':
          case 'female':
          case 'f':
            store.sexe = 'F';
            break;
          default:
            if (enrollmentData.gender == 'M' || enrollmentData.gender == 'F') {
              store.sexe = enrollmentData.gender;
            }
            break;
        }
      }

      // Profession
      if (store.profession.isEmpty && enrollmentData.profession?.isNotEmpty == true) {
        store.profession = enrollmentData.profession!;
      }

      // Address/Domicile
      if (store.domicile.isEmpty) {
        List<String> addressParts = [];
        if (enrollmentData.address?.isNotEmpty == true) {
          addressParts.add(enrollmentData.address!);
        }
        if (enrollmentData.quartier?.isNotEmpty == true) {
          addressParts.add(enrollmentData.quartier!);
        }

        if (addressParts.isNotEmpty) {
          store.domicile = addressParts.join(', ');
        }
      }

      // Parent information (filiation)
      if (store.filiationPere.isEmpty && enrollmentData.firstNameFather?.isNotEmpty == true) {
        store.filiationPere = '${enrollmentData.lastNameFather ?? ''} ${enrollmentData.firstNameFather ?? ''}'.trim();
      }

      if (store.filiationMere.isEmpty && enrollmentData.firstNameMother?.isNotEmpty == true) {
        store.filiationMere = '${enrollmentData.lastNameMother ?? ''} ${enrollmentData.firstNameMother ?? ''}'.trim();
      }

      // Parent birth dates
      if (store.dateNaissancePere == null && enrollmentData.birthdateFather != null) {
        store.dateNaissancePere = enrollmentData.birthdateFather;
      }

      if (store.dateNaissanceMere == null && enrollmentData.birthdateMother != null) {
        store.dateNaissanceMere = enrollmentData.birthdateMother;
      }

      // Parent birth places
      if (store.lieuNaissancePere.isEmpty && enrollmentData.birthplaceFather?.isNotEmpty == true) {
        store.lieuNaissancePere = enrollmentData.birthplaceFather!;
      }

      if (store.lieuNaissanceMere.isEmpty && enrollmentData.birthplaceMother?.isNotEmpty == true) {
        store.lieuNaissanceMere = enrollmentData.birthplaceMother!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidature presidentielle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadParties,
            tooltip: 'Actualiser les partis',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            StepIndicator(store: store),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DeclarationCandidatureStep(store: store), // NEW: Declaration step
                  PersonalInfoStep(store: store),
                  CandidatureStatusStep(
                    store: store,
                    parties: parties,
                    isLoadingParties: isLoadingParties,
                    partiesError: partiesError,
                    selectedPartie: selectedPartie,
                    onPartieSelected: (partie) => setState(() => selectedPartie = partie),
                    onReloadParties: _loadParties,
                  ),
                  FiliationStep(store: store),
                  VisualIdentityStep(store: store),
                  DocumentsStep(store: store),
                  PaymentStep(store: store),
                  FinalValidationStep(store: store, selectedPartie: selectedPartie),
                ],
              ),
            ),
            NavigationButtons(
              store: store,
              pageController: _pageController,
              onValidateStep: _validateCurrentStep,
            ),
          ],
        ),
      ),
    );
  }

  bool _validateCurrentStep() {
    return ValidationUtils.validateStep(store, selectedPartie);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}