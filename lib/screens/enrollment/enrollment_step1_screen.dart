// lib/features/enrollment/screens/enrollment_step1_screen.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:cei_mobile/common_widgets/file_picker_widget.dart';
import 'package:cei_mobile/common_widgets/indicator_dot.dart';
import 'package:cei_mobile/core/theme/app_theme.dart';
import 'package:cei_mobile/core/utils/document_utils.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/screens/enrollment/utils/document_utils.dart';
import 'package:cei_mobile/screens/enrollment/widgets/document_info_section.dart';
import 'package:cei_mobile/screens/enrollment/widgets/document_scan_section.dart';
import 'package:cei_mobile/services/regula_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class EnrollmentStep1Screen extends StatefulWidget {
  const EnrollmentStep1Screen({super.key});

  @override
  State<EnrollmentStep1Screen> createState() => _EnrollmentStep1ScreenState();
}

class _EnrollmentStep1ScreenState extends State<EnrollmentStep1Screen> {
  File? _idFrontPhoto;
  File? _idBackPhoto;
  File? _userFacePhoto;
  String? _selectedIdType;
  String? _gender;
  String? _birthplace;
  String? _profession;
  String? _personalNumber;
  String? _height;
  String? _age;
  String? _issuePlace;
  String? _cardAccessNumber;

  bool _isDocReaderInitializing = true;
  String _initStatusMessage = 'Initialisation du lecteur de document...';

  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();
  DateTime? _selectedIssueDate;
  DateTime? _selectedExpireDate;

  final List<PlatformFile> _selectedFiles = [];

  // Variables pour les informations extraites
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  // Indicateurs d'état
  bool _isScanning = false;
  bool _hasScannedDocument = false;

  // Variables pour l'éligibilité
  bool? _isEligible;
  String? _eligibilityMessage;
  DateTime? _birthDate;

  // Variables pour les vérifications légales
  bool? _isDocumentValid;
  String? _documentValidationMessage;

  // Service Regula
  final RegulaService _regulaService = RegulaService();

  final List<String> idTypes = [
    'Carte Nationale d\'Identité',
    'Passeport',
    'Permis de conduire',
    'Carte de séjour',
    'Attestation d\'identité',
  ];

  @override
  void initState() {
    super.initState();
    _setDefaultValues();
    _initializeDocumentReader();
  }

  // Initialisation du Document Reader de Regula
  Future<void> _initializeDocumentReader() async {
    setState(() {
      _isDocReaderInitializing = true;
      _initStatusMessage = 'Initialisation du lecteur de document...';
    });

    try {
      // Create a modified version of prepareDatabase in the RegulaService that supports status updates
      // We'll use a callback to get progress updates
      bool initialized = await _regulaService.initializeDocumentReader(
          onProgress: (message, progress) {
            setState(() {
              if (progress != null) {
                _initStatusMessage = '$message (${progress.toStringAsFixed(0)}%)';
              } else {
                _initStatusMessage = message;
              }
            });
          }
      );

      if (!initialized) {
        toast('Échec de l\'initialisation du lecteur de document');
      }
    } catch (e) {
      print('Erreur d\'initialisation: $e');
      toast('Erreur lors de l\'initialisation du lecteur de document');
    } finally {
      setState(() {
        _isDocReaderInitializing = false;
      });
    }
  }

  // Méthode pour vérifier le type de document selon la loi
  void _checkDocumentValidity() {
    setState(() {
      if (_selectedIdType != null) {
        // Utiliser la nouvelle méthode utilitaire
        if (IdDocumentUtils.isEligibleForEnrollment(_selectedIdType)) {
          _isDocumentValid = true;
          _documentValidationMessage = null;
        } else {
          _isDocumentValid = false;
          // Utiliser le message d'erreur spécifique
          _documentValidationMessage = IdDocumentUtils.getDocumentErrorMessage(_selectedIdType);
        }
      }
    });
  }

  // Méthode mise à jour pour calculer l'âge et vérifier l'éligibilité avec références légales
  void _checkEligibility() {
    if (_birthDate != null) {
      final now = DateTime.now();
      final age = now.year - _birthDate!.year;
      final hasHadBirthdayThisYear = now.month > _birthDate!.month ||
          (now.month == _birthDate!.month && now.day >= _birthDate!.day);

      final currentAge = hasHadBirthdayThisYear ? age : age - 1;

      setState(() {
        if (currentAge >= 18) {
          _isEligible = true;
          _eligibilityMessage = 'Félicitations ! Vous êtes éligible à l\'inscription sur la liste électorale.\n\n'
              '📋 Référence légale : Article 3 du Code Électoral de la République de Côte d\'Ivoire '
              '(Ordonnance N° 2020-356 du 08 avril 2020) :\n\n'
              '"Sont électeurs les ivoiriens des deux sexes et les personnes ayant acquis la nationalité ivoirienne '
              'soit par naturalisation soit par mariage, âgés de dix-huit ans accomplis, inscrits sur une liste électorale, '
              'jouissant de leurs droits civils et politiques et ne se trouvant dans aucun des cas d\'incapacité prévus par la loi."\n\n'
             ;
        } else {
          _isEligible = false;
          final yearsUntil18 = 18 - currentAge;
          final nextBirthday = DateTime(_birthDate!.year + 18, _birthDate!.month, _birthDate!.day);
          final formattedDate = "${nextBirthday.day.toString().padLeft(2, '0')}/"
              "${nextBirthday.month.toString().padLeft(2, '0')}/"
              "${nextBirthday.year}";

          _eligibilityMessage = '⚠️ Vous n\'êtes pas encore éligible à l\'inscription sur la liste électorale.\n\n'
              '📋 Référence légale : Article 3 du Code Électoral de la République de Côte d\'Ivoire '
              '(Ordonnance N° 2020-356 du 08 avril 2020) stipule que les électeurs doivent être '
              '"âgés de dix-huit ans accomplis".\n\n'
              '💡 Vous êtes sur la liste d\'attente.\n\n'
              '📅 Vous serez inscris automatiquement sur la liste électorale à partir du $formattedDate '
              '(dans $yearsUntil18 an${yearsUntil18 > 1 ? 's' : ''}).'
              ;
        }
      });
    }
  }

  // Récupérer les valeurs par défaut du store
  void _setDefaultValues() {
    final store = enrollmentStore;

    setState(() {
      // Load ID document data
      _selectedIdType = store.idType;
      _idNumberController.text = store.idNumber;
      _serialNumberController.text = store.serialNumber;

      print(store.issueDate);
      print(store.expireDate);
      if (store.issueDate != null) {
        _selectedIssueDate = store.issueDate;
        _issueDateController.text = "${store.issueDate!.day.toString().padLeft(2, '0')}/"
            "${store.issueDate!.month.toString().padLeft(2, '0')}/"
            "${store.issueDate!.year}";
      }

      if (store.expireDate != null) {
        _selectedExpireDate = store.expireDate;
        _expireDateController.text = "${store.expireDate!.day.toString().padLeft(2, '0')}/"
            "${store.expireDate!.month.toString().padLeft(2, '0')}/"
            "${store.expireDate!.year}";
      }

      // Load photos
      _idFrontPhoto = store.idFrontPhoto;
      _idBackPhoto = store.idBackPhoto;
      _userFacePhoto = store.documentFacePhoto;

      // Load the birth certificate files
      if (store.step1Files.isNotEmpty) {
        _selectedFiles.clear(); // Clear any existing files first
        _selectedFiles.addAll(store.step1Files);
      }

      // Update scanned document state if we have photos loaded
      _hasScannedDocument = (_idFrontPhoto != null && _idBackPhoto != null);

      // If document face photo is not set but we have a path in prefs, try to load it
      if (_userFacePhoto == null) {
        final path = getStringAsync('document_face_photo_path');
        if (path.isNotEmpty) {
          final faceFile = File(path);
          if (faceFile.existsSync()) {
            _userFacePhoto = faceFile;
          }
        }
      }

      if (store.firstName.isNotEmpty) {
        _firstNameController.text = store.firstName;
      }

      if (store.lastName.isNotEmpty) {
        _lastNameController.text = store.lastName;
      }

      if (store.nationality.isNotEmpty) {
        _nationalityController.text = store.nationality;
      }

      if (store.address.isNotEmpty) {
        _addressController.text = store.address;
      }

      if (store.dob.isNotEmpty) {
        _dobController.text = store.dob;
        // Parse the existing date for eligibility check
        _birthDate = IdDocumentUtils.parseDate(store.dob);
        if (_birthDate != null) {
          _checkEligibility();
        }
      }

      // Vérifier la validité du document si on a déjà un type
      if (_selectedIdType != null) {
        _checkDocumentValidity();
      }
    });
  }

  // Scanner le document avec Regula Document Reader
  Future<void> scanWithCamera() async {
    // Don't allow scanning if the document reader is still initializing
    if (_isDocReaderInitializing) {
      toast('Veuillez attendre l\'initialisation du lecteur de document');
      return;
    }

    setState(() {
      _isScanning = true;
    });

    try {
      final result = await _regulaService.scanDocument();

      if (result['success']) {
        // Traiter les résultats
        await _processRegulaScanResults(result['results']);
        setState(() {
          _hasScannedDocument = true;
        });
        toast('Document analysé avec succès!');
      } else {
        toast(result['message'] ?? 'Échec du scan de document');
      }
    } catch (e) {
      print('Erreur lors du scan: $e');
      toast('Une erreur s\'est produite lors du scan: $e');
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }

  // Traiter les résultats renvoyés par Regula
  Future<void> _processRegulaScanResults(Map<String, dynamic> results) async {
    try {
      // Extract images (code existant conservé)
      Uint8List? documentFrontImage = results['documentFrontImage'];
      Uint8List? documentBackImage = results['documentBackImage'];
      Uint8List? portraitImage = results['portraitImage'];

      if (documentFrontImage != null) {
        _idFrontPhoto = await IdDocumentUtils.createTempFileWithRandomName(
            documentFrontImage,
            'front_id'
        );
      }

      if (documentBackImage != null) {
        _idBackPhoto = await IdDocumentUtils.createTempFileWithRandomName(
            documentBackImage,
            'back_id'
        );
      }

      if (portraitImage != null) {
        _userFacePhoto = await IdDocumentUtils.createTempFileWithRandomName(
            portraitImage,
            'face_photo'
        );

        if (_userFacePhoto != null) {
          setValue('document_face_photo_path', _userFacePhoto!.path);
        }
      }

      final fields = results['fields'];
      if (fields != null) {
        setState(() {
          // Log all fields for debugging
          print("Processing extracted fields: ${fields.keys.join(', ')}");

          // Basic ID information
          _idNumberController.text = IdDocumentUtils.getFieldValue(
              fields,
              ['documentNumber', 'Numéro de document', 'DOCUMENT_NUMBER']
          );

          _serialNumberController.text = IdDocumentUtils.getFieldValue(
              fields,
              ['serialNumber', 'Numéro de série', 'SERIAL_NUMBER']
          );

          // Personal information
          _firstNameController.text = IdDocumentUtils.getFieldValue(
              fields,
              ['firstName', 'Prénom', 'FIRST_NAME', 'GIVEN_NAMES']
          );

          _lastNameController.text = IdDocumentUtils.getFieldValue(
              fields,
              ['lastName', 'Nom de famille', 'LAST_NAME', 'SURNAME']
          );

          _addressController.text = IdDocumentUtils.getFieldValue(
              fields,
              ['address', 'Adresse', 'ADDRESS']
          );

          _nationalityController.text = IdDocumentUtils.getFieldValue(
              fields,
              ['nationality', 'Nationalité', 'NATIONALITY']
          );

          // Document type extraction - utiliser directement les valeurs de Regula
          String docType = IdDocumentUtils.getFieldValue(
              fields,
              ['documentType', 'Type de document', 'DOCUMENT_CLASS_NAME']
          );

          // Mapper le type de document selon les valeurs Regula
          if (docType == 'CNI') {
            _selectedIdType = 'Carte Nationale d\'Identité';
          } else if (docType == 'PASSPORT') {
            _selectedIdType = 'Passeport';
          } else if (docType == 'PERMIS') {
            _selectedIdType = 'Permis de conduire';
          } else {
            _selectedIdType = IdDocumentUtils.mapDocumentType(docType);
          }

          // Vérifier la validité du document après l'extraction
          _checkDocumentValidity();

          // Date extraction (code existant conservé)
          String dob = IdDocumentUtils.getFieldValue(
              fields,
              ['dateOfBirth', 'Date de naissance', 'DATE_OF_BIRTH']
          );

          if (dob.isNotEmpty) {
            print("Original DOB value: $dob");
            _dobController.text = dob.contains('/') ? dob : IdDocumentUtils.formatDate(dob);

            // Parse birth date for eligibility check
            _birthDate = IdDocumentUtils.parseDate(dob);
            if (_birthDate != null) {
              _checkEligibility();
            }
          }

          // Dates d'expiry et d'issue (code existant conservé)
          String expireDate = IdDocumentUtils.getFieldValue(
              fields,
              ['dateOfExpiry', "Date d'expiration", 'DATE_OF_EXPIRY']
          );
          if (expireDate.isNotEmpty) {
            _expireDateController.text = expireDate.contains('/') ? expireDate : IdDocumentUtils.formatDate(expireDate);
            _selectedExpireDate = IdDocumentUtils.parseDate(expireDate);
          }

          String issueDate = IdDocumentUtils.getFieldValue(
              fields,
              ['issueDate', "Date de délivrance", 'DATE_OF_ISSUE', 'dateOfIssue']
          );
          if (issueDate.isNotEmpty) {
            _issueDateController.text = issueDate.contains('/') ? issueDate : IdDocumentUtils.formatDate(issueDate);
            _selectedIssueDate = IdDocumentUtils.parseDate(issueDate);
          }

          // Additional fields (code existant conservé)
          _gender = IdDocumentUtils.getFieldValue(fields, ['gender', 'Sexe', 'SEX']);
          _birthplace = IdDocumentUtils.getFieldValue(fields, ['birthplace', 'Lieu de naissance', 'PLACE_OF_BIRTH', 'placeOfBirth']);
          _profession = IdDocumentUtils.getFieldValue(fields, ['profession', 'Profession', 'PROFESSION']);
          _personalNumber = IdDocumentUtils.getFieldValue(fields, ['personalNumber', 'N° personnel', 'PERSONAL_NUMBER']);
          _height = IdDocumentUtils.getFieldValue(fields, ['height', 'Hauteur', 'HEIGHT']);
          _age = IdDocumentUtils.getFieldValue(fields, ['age', 'Âge', 'AGE']);
          _issuePlace = IdDocumentUtils.getFieldValue(fields, ['issuePlace', 'Lieu de délivrance', 'PLACE_OF_ISSUE']);
          _cardAccessNumber = IdDocumentUtils.getFieldValue(fields, ['cardAccessNumber', 'Numéro de carte', 'CARD_ACCESS_NUMBER']);
        });
      }
    } catch (e) {
      print('Erreur lors du traitement des résultats: $e');
      toast('Erreur lors du traitement des résultats: $e');
    }
  }

  Widget _buildInitializingSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(),
          ),
          20.height,
          Text(
            'Préparation du système',
            style: boldTextStyle(size: 18),
            textAlign: TextAlign.center,
          ),
          8.height,
          Text(
            _initStatusMessage,
            style: secondaryTextStyle(),
            textAlign: TextAlign.center,
          ),
          16.height,
          Text(
            'Cette opération peut prendre quelques minutes la première fois.',
            style: secondaryTextStyle(size: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Widget pour afficher le message de validation du document
  Widget _buildDocumentValidationCard() {
    if (_isDocumentValid == null) {
      return const SizedBox.shrink();
    }

    if (_isDocumentValid!) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green[300]!, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.verified_outlined,
              color: Colors.green[600],
              size: 24,
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Document accepté ✅',
                    style: boldTextStyle(
                      size: 16,
                      color: Colors.green[700],
                    ),
                  ),
                  8.height,
                  Text(
                    IdDocumentUtils.getDocumentDescription(_selectedIdType),
                    style: primaryTextStyle(
                      size: 14,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red[300]!, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.cancel_outlined,
                  color: Colors.red[600],
                  size: 24,
                ),
                12.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Document non accepté ❌',
                        style: boldTextStyle(
                          size: 16,
                          color: Colors.red[700],
                        ),
                      ),
                      4.height,
                      Text(
                        'Type détecté: ${IdDocumentUtils.getDocumentDescription(_selectedIdType)}',
                        style: primaryTextStyle(
                          size: 13,
                          color: Colors.red[600],
                          weight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            12.height,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Text(
                _documentValidationMessage!,
                style: primaryTextStyle(
                  size: 14,
                  color: Colors.red[800],
                  height: 1.5,
                ),
              ),
            ),

          ],
        ),
      );
    }
  }

  // Widget mis à jour pour afficher le message d'éligibilité avec références légales
  Widget _buildEligibilityCard() {
    if (_isEligible == null || _eligibilityMessage == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: _isEligible! ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isEligible! ? Colors.green[300]! : Colors.orange[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _isEligible! ? Icons.gavel : Icons.schedule,
                color: _isEligible! ? Colors.green[600] : Colors.orange[600],
                size: 24,
              ),
              12.width,
              Expanded(
                child: Text(
                  _isEligible!
                      ? 'Éligible selon la loi ⚖️'
                      : 'Non éligible actuellement ⏳',
                  style: boldTextStyle(
                    size: 16,
                    color: _isEligible! ? Colors.green[700] : Colors.orange[700],
                  ),
                ),
              ),
            ],
          ),
          16.height,
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isEligible!
                  ? Colors.green[100]
                  : Colors.orange[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _eligibilityMessage!,
              style: primaryTextStyle(
                size: 13,
                color: _isEligible! ? Colors.green[800] : Colors.orange[800],
                height: 1.4,
              ),
            ),
          ),
          if (!_isEligible!) ...[
            12.height,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: Colors.blue[700],
                    size: 16,
                  ),
                  8.width,
                  Expanded(
                    child: Text(
                      'Nous vous enverrons une notification automatique dès que vous serez éligible.',
                      style: primaryTextStyle(
                        size: 12,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _idNumberController.dispose();
    _serialNumberController.dispose();
    _issueDateController.dispose();
    _expireDateController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _nationalityController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IndicatorDot(
                      currentPage: 0,
                      totalItems: 7,
                      selectedDotWidth: 45,
                      unselectedDotWidth: 45,
                    ),
                    30.height,
                    Text("Pièces",
                        style: Theme.of(context).textTheme.displaySmall),
                    Text("d'identité",
                        style: Theme.of(context).textTheme.displaySmall),
                    30.height,

                    // Show initialization progress if still initializing
                    if (_isDocReaderInitializing)
                      _buildInitializingSection()
                    // Otherwise show normal document scan or info sections
                    else if (!_hasScannedDocument)
                      DocumentScanSection(
                        isScanning: _isScanning,
                        onScanPressed: scanWithCamera,
                      )
                    else
                      Column(
                        children: [
                          // Afficher la validation du document après le scan
                          if (_hasScannedDocument && _selectedIdType != null)
                            _buildDocumentValidationCard(),
                          if (_hasScannedDocument && _isEligible != null && _isDocumentValid == true)
                            _buildEligibilityCard(),

                          // Section fichier - seulement visible si document valide et éligible
                          if (_isDocumentValid == true && _isEligible != true) ...[
                            // Si pas éligible par l'âge mais document valide, montrer un message d'information
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.blue[300]!, width: 1),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: Colors.blue[600],
                                    size: 32,
                                  ),
                                  12.height,
                                  Text(
                                    'Inscription différée',
                                    style: boldTextStyle(
                                      size: 16,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  8.height,
                                  Text(
                                    'Votre document est valide mais vous n\'avez pas encore l\'âge requis. '
                                        'Votre inscription sera automatiquement activée dès vos 18 ans.',
                                    style: primaryTextStyle(
                                      size: 14,
                                      color: Colors.blue[700],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ] else if (_isDocumentValid == true && _isEligible == true) ...[
                            // Section de sélection de fichier seulement si tout est valide

                          ],
                          10.height,
                          DocumentInfoSection(
                            idFrontPhoto: _idFrontPhoto,
                            idBackPhoto: _idBackPhoto,
                            userFacePhoto: _userFacePhoto,
                            hasProfilePhoto: false, // Pas encore pris à cette étape
                            selectedIdType: _selectedIdType,
                            idNumber: _idNumberController.text,
                            serialNumber: _serialNumberController.text,
                            issueDate: _issueDateController.text,
                            expireDate: _expireDateController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            dob: _dobController.text,
                            nationality: _nationalityController.text,
                            address: _addressController.text,
                            onRescanPressed: scanWithCamera,
                            isScanning: _isScanning,
                            age: _age.validate(),
                          ),
                        ],
                      ),

                    // Afficher le message d'éligibilité seulement si le document est valide

                    30.height,
                    Text(
                      "Sélectionner votre extrait d'acte de naissance",
                      style: boldTextStyle(size: 18),
                    ),
                    16.height,
                    FilePickerWidget(
                      selectedFiles: _selectedFiles,
                      onFilesSelected: (files) {
                        setState(() {
                          _selectedFiles.addAll(files);
                        });
                      },
                      onFileRemoved: (file) {
                        setState(() {
                          _selectedFiles.remove(file);
                        });
                      },
                      buttonText: "Sélectionner un fichier",
                      infoText: '',
                      allowedExtensions: const ['pdf', 'jpg', 'png'],
                      maxFileSize: 5, // 5MB limit
                      allowMultiple: true,
                      showFilesList: true,
                      filesListTitle: 'Extrait d\'acte de naissance',
                    ),
                  ],
                ),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onTap: _isDocReaderInitializing ||
                  _isScanning ||
                  _isDocumentValid == false ||
                  _isEligible == false
                  ? (){
                // Disable button when not ready
              }
                  : () {
                // Vérifications avec messages spécifiques
                if (!_hasScannedDocument) {
                  toast('Veuillez scanner votre pièce d\'identité');
                  return;
                }

                // Vérification du type de document avec la nouvelle méthode
                if (!IdDocumentUtils.isEligibleForEnrollment(_selectedIdType)) {
                  final errorMsg = IdDocumentUtils.getDocumentErrorMessage(_selectedIdType);
                  toast(errorMsg.length > 80
                      ? 'Seule la CNI est acceptée pour l\'enrôlement électoral'
                      : errorMsg);
                  return;
                }

                // Vérification de l'éligibilité d'âge
                if (_isEligible == false) {
                  toast('Vous devez avoir au moins 18 ans pour vous inscrire (Article 3 du Code Électoral)');
                  return;
                }

                if (_idNumberController.text.isEmpty) {
                  toast('Numéro de pièce non détecté. Veuillez re-scanner');
                  return;
                }

                if (_idFrontPhoto == null) {
                  toast('Image du recto non détectée. Veuillez re-scanner');
                  return;
                }

                if (_idBackPhoto == null) {
                  toast('Image du verso non détectée. Veuillez re-scanner');
                  return;
                }

                if (_selectedFiles.isEmpty) {
                  toast('Veuillez sélectionner votre extrait d\'acte de naissance');
                  return;
                }

                // Enregistrer les données si toutes les vérifications passent
                enrollmentStore.setStep1Data(
                  idFrontPhoto: _idFrontPhoto,
                  idBackPhoto: _idBackPhoto,
                  documentFacePhoto: _userFacePhoto,
                  idType: _selectedIdType,
                  idNumber: _idNumberController.text,
                  serialNumber: _serialNumberController.text,
                  expireDate: _selectedExpireDate,
                  issueDate: _selectedIssueDate,
                  lastName: _lastNameController.text,
                  firstName: _firstNameController.text,
                  gender: _gender,
                  birthplace: _birthplace,
                  nationality: _nationalityController.text,
                  dob: _dobController.text,
                  placeOfBirth: _birthplace,
                  profession: _profession,
                  personalNumber: _personalNumber,
                  height: _height,
                  age: _age,
                  issuePlace: _issuePlace,
                  cardAccessNumber: _cardAccessNumber,
                  files: _selectedFiles,
                );

                // Passer à l'étape suivante
                enrollmentStore.nextStep();
              },
              elevation: 0.0,
              color: _isDocReaderInitializing ||
                  _isScanning ||
                  _isDocumentValid == false ||
                  _isEligible == false
                  ? Colors.grey[400]
                  : CEIColors.ceiOrange,
              child: _isDocReaderInitializing
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  8.width,
                  Text('Initialisation...', style: boldTextStyle(color: Colors.white)),
                ],
              )
                  : Text('Suivant', style: boldTextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}