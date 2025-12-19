import 'package:cei_mobile/store/CandidatureStore.dart';
import 'package:flutter/material.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/model/user/user_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class CandidatureInitScreen extends StatefulWidget {
  const CandidatureInitScreen({Key? key}) : super(key: key);

  @override
  _CandidatureInitScreenState createState() => _CandidatureInitScreenState();
}

class _CandidatureInitScreenState extends State<CandidatureInitScreen> {
  // Étape actuelle du processus d'initialisation de candidature
  int _currentInitStep = 0;

  // Données de l'utilisateur une fois qu'il est vérifié
  UserModel? _verifiedUser;

  // Indique si la correspondance faciale a été effectuée
  bool _faceVerified = false;

  // Contrôle l'affichage du chargement
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Charger les données sauvegardées si disponibles
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    // Vérifier si des données de vérification ont déjà été sauvegardées
    final hasVerifiedUser = getBoolAsync('has_verified_user', defaultValue: false);
    if (hasVerifiedUser) {
      final userData = getStringAsync('verified_user_data');
      if (userData.isNotEmpty) {
        try {
          // Tenter de reconstruire l'objet UserModel
          setState(() {
            // Logique pour reconstruire UserModel à partir des données sauvegardées
            // _verifiedUser = UserModel.fromJson(jsonDecode(userData));
            _currentInitStep = 1; // Passer à l'étape de vérification faciale
          });
        } catch (e) {
          print('Erreur lors du chargement des données utilisateur: $e');
        }
      }
    }

    // Vérifier si la vérification faciale a déjà été effectuée
    final hasFaceVerification = getBoolAsync('face_verification_completed', defaultValue: false);
    if (hasFaceVerification && _verifiedUser != null) {
      setState(() {
        _faceVerified = true;
        _currentInitStep = 2; // Passer à l'étape de sélection d'élection
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          _getScreenTitle(),
          style: boldTextStyle(size: 20, color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildCurrentStep(),
          ),
          if (_currentInitStep < 2) _buildNavigationButtons(context),
        ],
      ),
    );
  }

  String _getScreenTitle() {
    switch (_currentInitStep) {
      case 0:
        return 'Vérification d\'enrôlement';
      case 1:
        return 'Vérification d\'identité';
      case 2:
        return 'Sélection d\'élection';
      default:
        return 'Candidature';
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentInitStep) {
      case 0:
        return _buildEnrollmentVerificationStep();
      case 1:
        return _buildFaceVerificationStep();
      case 2:
        return _buildElectionSelectionStep();
      default:
        return _buildEnrollmentVerificationStep();
    }
  }

  // Étape 1: Vérification d'enrôlement
  Widget _buildEnrollmentVerificationStep() {
    // Cette partie est inspirée de EnrollmentVerificationScreen
    TextEditingController formNumberController = TextEditingController();
    TextEditingController voterNumberController = TextEditingController();
    TextEditingController familyNameController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();

    // Date de naissance pour la recherche par nom
    String? selectedDay;
    String? selectedMonth;
    String? selectedYear;

    // Onglet de recherche actif
    int currentTab = 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Vérification",
              style: boldTextStyle(
                  size: 36, letterSpacing: 2, color: Colors.black)),
          Text("enrôlement",
              style: boldTextStyle(
                size: 36,
                letterSpacing: 2,
                color: Colors.black,
              )),
          30.height,

          // Header info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColors.primary,
                  size: 24,
                ),
                12.width,
                Expanded(
                  child: Text(
                    'Pour poser votre candidature, vous devez d\'abord vérifier votre enrôlement sur la liste électorale.',
                    style: primaryTextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          25.height,

          // Section title
          Text(
            'CHOISISSEZ UN MODE DE RECHERCHE',
            style: boldTextStyle(size: 14),
          ),
          20.height,

          // Onglets de recherche
          StatefulBuilder(
            builder: (context, setTabState) {
              return Column(
                children: [
                  // Onglets
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Tabs header
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => setTabState(() => currentTab = 0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: currentTab == 0
                                              ? AppColors.primary
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.description_outlined,
                                          size: 16,
                                          color: currentTab == 0 ? AppColors.primary : Colors.grey,
                                        ),
                                        8.width,
                                        Text(
                                          'Formulaire',
                                          style: TextStyle(
                                            fontWeight: currentTab == 0 ? FontWeight.bold : FontWeight.normal,
                                            color: currentTab == 0 ? AppColors.primary : Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => setTabState(() => currentTab = 1),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: currentTab == 1
                                              ? AppColors.primary
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.credit_card_outlined,
                                          size: 16,
                                          color: currentTab == 1 ? AppColors.primary : Colors.grey,
                                        ),
                                        8.width,
                                        Text(
                                          'N° Électeur',
                                          style: TextStyle(
                                            fontWeight: currentTab == 1 ? FontWeight.bold : FontWeight.normal,
                                            color: currentTab == 1 ? AppColors.primary : Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => setTabState(() => currentTab = 2),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: currentTab == 2
                                              ? AppColors.primary
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person_outline,
                                          size: 16,
                                          color: currentTab == 2 ? AppColors.primary : Colors.grey,
                                        ),
                                        8.width,
                                        Text(
                                          'Nom/Prénom',
                                          style: TextStyle(
                                            fontWeight: currentTab == 2 ? FontWeight.bold : FontWeight.normal,
                                            color: currentTab == 2 ? AppColors.primary : Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tab content
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: [
                            // Tab 1: Recherche par numéro de formulaire
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RECHERCHER PAR LE NUMÉRO FORMULAIRE',
                                  style: boldTextStyle(size: 14),
                                ),
                                16.height,
                                Text(
                                  'NUMÉRO FORMULAIRE 2025',
                                  style: secondaryTextStyle(size: 12),
                                ),
                                8.height,
                                AppTextField(
                                  controller: formNumberController,
                                  textFieldType: TextFieldType.NUMBER,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    hintText: '0000000000',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.primary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Tab 2: Recherche par numéro d'électeur
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RECHERCHER PAR LE NUMÉRO D\'ÉLECTEUR',
                                  style: boldTextStyle(size: 14),
                                ),
                                16.height,
                                Text(
                                  'NUMÉRO D\'ÉLECTEUR',
                                  style: secondaryTextStyle(size: 12),
                                ),
                                8.height,
                                AppTextField(
                                  controller: voterNumberController,
                                  textFieldType: TextFieldType.NAME,
                                  decoration: InputDecoration(
                                    hintText: 'V 0000 0000 00',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.primary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Tab 3: Recherche par nom et prénom
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RECHERCHER PAR NOM, PRÉNOM(S) ET DATE DE NAISSANCE',
                                  style: boldTextStyle(size: 14),
                                ),
                                16.height,
                                Text(
                                  'NOM DE FAMILLE',
                                  style: secondaryTextStyle(size: 12),
                                ),
                                8.height,
                                AppTextField(
                                  controller: familyNameController,
                                  textFieldType: TextFieldType.NAME,
                                  decoration: InputDecoration(
                                    hintText: 'Nom de famille',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.primary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                16.height,
                                Text(
                                  'PRÉNOM(S)',
                                  style: secondaryTextStyle(size: 12),
                                ),
                                8.height,
                                AppTextField(
                                  controller: firstNameController,
                                  textFieldType: TextFieldType.NAME,
                                  decoration: InputDecoration(
                                    hintText: 'Vos prénoms',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.primary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                16.height,
                                Text(
                                  'DATE DE NAISSANCE',
                                  style: secondaryTextStyle(size: 12),
                                ),
                                4.height,
                                StatefulBuilder(
                                  builder: (context, setDateState) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              hintText: 'Jour',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                            ),
                                            hint: const Text('- Jour -'),
                                            value: selectedDay,
                                            items: List.generate(31, (index) => index + 1)
                                                .map((day) => DropdownMenuItem(
                                              value: day.toString(),
                                              child: Text(day.toString()),
                                            ))
                                                .toList(),
                                            onChanged: (value) {
                                              setDateState(() {
                                                selectedDay = value;
                                              });
                                            },
                                          ),
                                        ),
                                        8.width,
                                        Expanded(
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              hintText: 'Mois',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                            ),
                                            hint: const Text('- Mois -'),
                                            value: selectedMonth,
                                            items: List.generate(12, (index) => index + 1)
                                                .map((month) => DropdownMenuItem(
                                              value: month.toString(),
                                              child: Text(month.toString()),
                                            ))
                                                .toList(),
                                            onChanged: (value) {
                                              setDateState(() {
                                                selectedMonth = value;
                                              });
                                            },
                                          ),
                                        ),
                                        8.width,
                                        Expanded(
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              hintText: 'Année',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                            ),
                                            hint: const Text('- Année -'),
                                            value: selectedYear,
                                            items: List.generate(100, (index) => 2025 - index)
                                                .map((year) => DropdownMenuItem(
                                              value: year.toString(),
                                              child: Text(year.toString()),
                                            ))
                                                .toList(),
                                            onChanged: (value) {
                                              setDateState(() {
                                                selectedYear = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ][currentTab],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Étape 2: Vérification faciale
  Widget _buildFaceVerificationStep() {
    if (_verifiedUser == null) {
      // Si pour une raison quelconque l'utilisateur n'est pas vérifié, retourner à l'étape précédente
      Future.microtask(() {
        setState(() {
          _currentInitStep = 0;
        });
      });
      return const Center(child: CircularProgressIndicator());
    }

    // Variable pour suivre l'état de la photo
    final ValueNotifier<File?> idPhotoNotifier = ValueNotifier<File?>(null);
    final ValueNotifier<bool> isCapturingNotifier = ValueNotifier<bool>(false);
    final ValueNotifier<bool> livenessVerifiedNotifier = ValueNotifier<bool>(false);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Vérification",
              style: boldTextStyle(
                  size: 36, letterSpacing: 2, color: Colors.black)),
          Text("d'identité",
              style: boldTextStyle(
                size: 36,
                letterSpacing: 2,
                color: Colors.black,
              )),
          30.height,

          // Header info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColors.primary,
                  size: 24,
                ),
                12.width,
                Expanded(
                  child: Text(
                    'Veuillez prendre une photo de votre visage pour confirmer votre identité.',
                    style: primaryTextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          25.height,

          // Information d'enrôlement vérifiée (Card)
          _buildSectionCard(
            title: 'Informations d\'enrôlement vérifiées',
            icon: Icons.verified_user,
            content: [
              _buildDetailRow('Nom:', _verifiedUser!.lastName),
              _buildDetailRow('Prénom(s):', _verifiedUser!.firstName),
              _buildDetailRow('Genre:', _verifiedUser!.gender == 'M' ? 'Masculin' : 'Féminin'),
              _buildDetailRow('Date de naissance:', _formatDate(_verifiedUser!.dob)),
              _buildDetailRow('Numéro d\'électeur:', _verifiedUser!.uniqueRegistrationNumber),
              _buildDetailRow('Ville:', _verifiedUser!.city),
              _buildDetailRow('Commune:', _verifiedUser!.commune),
            ],
            onEdit: null, // No edit button here
          ),
          20.height,

          // Section de prise de photo
          ValueListenableBuilder<File?>(
            valueListenable: idPhotoNotifier,
            builder: (context, idPhoto, child) {
              return _buildSectionCard(
                title: 'Photo d\'identité',
                icon: Icons.camera_alt,
                content: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 220,
                          height: 280,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (idPhoto == null) {
                                  // Lancer la capture photo avec vérification de liveness
                                  _captureFace(idPhotoNotifier, isCapturingNotifier, livenessVerifiedNotifier);
                                } else {
                                  // Afficher l'aperçu en plein écran
                                  _showFullScreenPreview(context, idPhoto);
                                }
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: ValueListenableBuilder<bool>(
                                valueListenable: isCapturingNotifier,
                                builder: (context, isCapturing, _) {
                                  if (idPhoto != null) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.file(
                                            idPhoto,
                                            fit: BoxFit.cover,
                                          ),
                                          // Statut de vérification
                                          ValueListenableBuilder<bool>(
                                            valueListenable: livenessVerifiedNotifier,
                                            builder: (context, livenessVerified, _) {
                                              return Positioned(
                                                top: 10,
                                                right: 10,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: livenessVerified
                                                        ? Colors.green.withOpacity(0.8)
                                                        : Colors.orange.withOpacity(0.8),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        livenessVerified ? Icons.verified_user : Icons.warning,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      4.width,
                                                      Text(
                                                        livenessVerified
                                                            ? 'Vivacité vérifiée'
                                                            : 'Sans vivacité',
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          // Indication "Appuyer pour agrandir"
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              decoration: const BoxDecoration(
                                                color: Colors.black54,
                                                borderRadius: BorderRadius.vertical(
                                                  bottom: Radius.circular(16),
                                                ),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.zoom_in,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Appuyer pour agrandir',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else if (isCapturing) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const CircularProgressIndicator(color: AppColors.primary),
                                          16.height,
                                          Text(
                                            'Vérification en cours...',
                                            style: secondaryTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        16.height,
                                        Text(
                                          'Ajouter une photo',
                                          style: boldTextStyle(color: AppColors.primary),
                                        ),
                                        8.height,
                                        Text(
                                          'Appuyez ici',
                                          style: secondaryTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        if (idPhoto != null)
                          Positioned(
                            top: -5,
                            right: -5,
                            child: Material(
                              color: Colors.white,
                              elevation: 4,
                              shape: const CircleBorder(),
                              child: InkWell(
                                onTap: () {
                                  _captureFace(idPhotoNotifier, isCapturingNotifier, livenessVerifiedNotifier);
                                },
                                customBorder: const CircleBorder(),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  20.height,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.lightbulb_outline,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            12.width,
                            Text(
                              'Instructions pour la photo',
                              style: boldTextStyle(color: AppColors.primary, size: 16),
                            ),
                          ],
                        ),
                        12.height,
                        _buildInstructionItem(
                          icon: Icons.face,
                          text: 'Visage centré et entièrement visible',
                        ),
                        _buildInstructionItem(
                          icon: Icons.remove_red_eye,
                          text: 'Pas de lunettes ni d\'accessoires',
                        ),
                        _buildInstructionItem(
                          icon: Icons.wallpaper,
                          text: 'Fond neutre et uni',
                        ),
                        _buildInstructionItem(
                          icon: Icons.wb_sunny,
                          text: 'Bonne luminosité sans ombres',
                        ),
                        _buildInstructionItem(
                          icon: Icons.sentiment_neutral,
                          text: 'Expression neutre, bouche fermée',
                        ),
                      ],
                    ),
                  ),
                ],
                onEdit: null, // No edit button here
              );
            },
          ),
        ],
      ),
    );
  }

  // Étape 3: Sélection d'élection pour la candidature
  Widget _buildElectionSelectionStep() {
    if (_verifiedUser == null) {
      // Si pour une raison quelconque l'utilisateur n'est pas vérifié, retourner à l'étape précédente
      Future.microtask(() {
        setState(() {
          _currentInitStep = 0;
        });
      });
      return const Center(child: CircularProgressIndicator());
    }

    // Liste des élections disponibles
    final List<Map<String, dynamic>> availableElections = [
      {
        'id': '1',
        'title': 'Élection Présidentielle 2025',
        'date': '26 octobre 2025',
        'type': ElectionType.presidentielle,
        'icon': Icons.stars,
        'color': Colors.purple,
        'description': 'Pour les citoyens ivoiriens âgés d\'au moins 35 ans',
        'minAge': 35,
        'registrationDeadline': '30 juillet 2025',
      },
      {
        'id': '2',
        'title': 'Élections Législatives 2025',
        'date': '30 novembre 2025',
        'type': ElectionType.legislative,
        'icon': Icons.account_balance,
        'color': Colors.blue,
        'description': 'Pour les citoyens ivoiriens âgés d\'au moins 25 ans',
        'minAge': 25,
        'registrationDeadline': '15 août 2025',
      },
      {
        'id': '3',
        'title': 'Élections Sénatoriales 2025',
        'date': '7 décembre 2025',
        'type': ElectionType.senatoriale,
        'icon': Icons.business,
        'color': Colors.teal,
        'description': 'Pour les citoyens ivoiriens âgés d\'au moins 35 ans',
        'minAge': 35,
        'registrationDeadline': '22 août 2025',
      },
      {
        'id': '4',
        'title': 'Élections Régionales 2025',
        'date': '14 décembre 2025',
        'type': ElectionType.regionale,
        'icon': Icons.location_city,
        'color': Colors.orange,
        'description': 'Pour les citoyens ivoiriens âgés d\'au moins 25 ans',
        'minAge': 25,
        'registrationDeadline': '30 août 2025',
      },
      {
        'id': '5',
        'title': 'Élections Municipales 2025',
        'date': '14 décembre 2025',
        'type': ElectionType.municipale,
        'icon': Icons.home_work,
        'color': Colors.green,
        'description': 'Pour les citoyens ivoiriens âgés d\'au moins 25 ans',
        'minAge': 25,
        'registrationDeadline': '30 août 2025',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sélection",
              style: boldTextStyle(
                  size: 36, letterSpacing: 2, color: Colors.black)),
          Text("d'élection",
              style: boldTextStyle(
                size: 36,
                letterSpacing: 2,
                color: Colors.black,
              )),
          30.height,

          // Header info card with verification success
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
                16.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Identité vérifiée',
                        style: boldTextStyle(color: Colors.green.shade800, size: 16),
                      ),
                      4.height,
                      Text(
                        'Votre identité a été confirmée. Vous pouvez maintenant poursuivre votre candidature.',
                        style: TextStyle(color: Colors.green.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          25.height,

          // Elections title
          Text(
            'Choisissez une élection',
            style: boldTextStyle(size: 18),
          ),
          16.height,

          // Liste des élections disponibles
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: availableElections.length,
            itemBuilder: (context, index) {
              final election = availableElections[index];
              final bool isEligible = _checkEligibility(election);

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: isEligible ? () {
                    // Configuration du store de candidature avec les informations de l'utilisateur
                    _initCandidatureWithUserData(election);
                  } : null,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: isEligible
                            ? election['color'].withOpacity(0.3)
                            : Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isEligible
                                ? election['color'].withOpacity(0.05)
                                : Colors.grey.shade50,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isEligible
                                      ? election['color'].withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  election['icon'],
                                  color: isEligible
                                      ? election['color']
                                      : Colors.grey,
                                  size: 24,
                                ),
                              ),
                              16.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      election['title'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isEligible
                                            ? election['color']
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isEligible)
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                            ],
                          ),
                        ),

                        // Content
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('Date:', election['date']),
                              _buildDetailRow('Clôture des candidatures:', election['registrationDeadline']),
                              _buildDetailRow('Éligibilité:', 'Citoyens âgés d\'au moins ${election['minAge']} ans'),

                              if (!isEligible) ...[
                                12.height,
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.red.shade200),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                      8.width,
                                      Expanded(
                                        child: Text(
                                          'Vous ne remplissez pas les critères d\'éligibilité pour cette élection. Âge minimum requis: ${election['minAge']} ans.',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentInitStep > 0)
            Expanded(
              child: AppButton(
                shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onTap: () {
                  setState(() {
                    _currentInitStep--;
                  });
                },
                elevation: 0.0,
                color: Colors.grey[300],
                child: Text('Précédent',
                    style: boldTextStyle(color: Colors.black)),
              ),
            ),
          if (_currentInitStep > 0) 8.width,
          Expanded(
            child: AppButton(
              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onTap: () {
                // Si nous sommes à l'étape de vérification d'enrôlement
                if (_currentInitStep == 0) {
                  // Simuler une recherche réussie
                  setState(() {
                    _isLoading = true;
                  });

                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      _isLoading = false;
                      // Simuler un utilisateur vérifié
                      _verifiedUser = UserModel(
                        id: "12345",
                        firstName: "Jean",
                        lastName: "Dupont",
                        uniqueRegistrationNumber: "V1234567890",
                        gender: "M",
                        dob: "1985-05-15",
                        nationality: "Ivoirienne",
                        city: "Abidjan",
                        commune: "Cocody",
                        quarter: "Angré",
                      );
                      _currentInitStep = 1; // Passer à l'étape de vérification faciale
                    });
                  });
                }
                // Si nous sommes à l'étape de vérification faciale
                else if (_currentInitStep == 1) {
                  // Simuler la vérification faciale réussie
                  setState(() {
                    _isLoading = true;
                  });

                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      _isLoading = false;
                      _faceVerified = true;
                      _currentInitStep = 2; // Passer à l'étape de sélection d'élection
                    });
                  });
                }
              },
              elevation: 0.0,
              color: _isLoading ? Colors.grey : AppColors.primary,
              child: _isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : Text(
                  _currentInitStep == 0 ? 'Vérifier' : 'Continuer',
                  style: boldTextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget réutilisable pour construire une section card comme dans EnrollmentRecapScreen
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> content,
    required VoidCallback? onEdit,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: AppColors.primary, size: 20),
                    8.width,
                    Text(
                      title,
                      style: boldTextStyle(size: 16),
                    ),
                  ],
                ),
                if (onEdit != null)
                  TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Modifier'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.secondary,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: secondaryTextStyle(),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: primaryTextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem({
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.black87,
          ),
          8.width,
          Expanded(
            child: Text(
              text,
              style: primaryTextStyle(size: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _showFullScreenPreview(BuildContext context, File photoFile) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text('Prévisualisation', style: TextStyle(color: Colors.white)),
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4,
                child: Image.file(photoFile),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Simuler la capture de photo avec liveness
  void _captureFace(
      ValueNotifier<File?> photoNotifier,
      ValueNotifier<bool> isCapturingNotifier,
      ValueNotifier<bool> livenessVerifiedNotifier
      ) async {
    isCapturingNotifier.value = true;

    try {
      // Simuler une capture réussie
      await Future.delayed(const Duration(seconds: 2));

      // Dans une implémentation réelle, vous utiliserez une caméra pour capturer l'image
      // livenessVerifiedNotifier.value = true;

      // Pour le moment, définir simplement livenessVerifiedNotifier comme true
      livenessVerifiedNotifier.value = true;

      // Pour le moment, nous ne pouvons pas simuler une photo
      // Dans une implémentation réelle, photoNotifier.value = capturedImageFile
    } catch (e) {
      print('Erreur lors de la capture du visage: $e');
      toast('Une erreur s\'est produite. Veuillez réessayer.');
    } finally {
      isCapturingNotifier.value = false;
    }
  }

  // Vérifier l'éligibilité pour une élection
  bool _checkEligibility(Map<String, dynamic> election) {
    if (_verifiedUser == null || _verifiedUser!.dob.isEmpty) return false;

    try {
      final dob = DateTime.parse(_verifiedUser!.dob);
      final int age = DateTime.now().year - dob.year;
      return age >= election['minAge'];
    } catch (e) {
      print('Erreur de calcul d\'âge: $e');
      return false;
    }
  }

  // Initialiser le store de candidature avec les informations de l'utilisateur
  void _initCandidatureWithUserData(Map<String, dynamic> election) {
    // Simulation du chargement
    setState(() {
      _isLoading = true;
    });

    // Simuler un délai pour l'initialisation
    Future.delayed(const Duration(seconds: 2), () {
      // Initialiser le store avec les données de l'utilisateur vérifié
      candidatureStore.setElectionType(election['type']);

      // Informations personnelles
      // candidatureStore.setStep1Data(
      //   nom: _verifiedUser!.lastName,
      //   prenoms: _verifiedUser!.firstName,
      //   dateNaissance: _verifiedUser!.dob.isNotEmpty ? DateTime.parse(_verifiedUser!.dob) : null,
      //   lieuNaissance: '',  // Information à compléter par l'utilisateur
      //   nationalite: 'Ivoirienne',
      //   profession: '',  // Information à compléter par l'utilisateur
      //   adresse: '',  // Information à compléter par l'utilisateur
      //   genre: _verifiedUser!.gender,
      //   emailContact: '',  // Information à compléter par l'utilisateur
      //   telephoneContact: '',  // Information à compléter par l'utilisateur
      // );

      // Sauvegarder les données
      candidatureStore.saveCandidatureData();

      // Rediriger vers l'écran de candidature
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const CandidatureFormScreen(),
      //   ),
      // );

      setState(() {
        _isLoading = false;
      });
    });
  }

  // Formater une date
  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return isoDate;
    }
  }
}

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String uniqueRegistrationNumber;
  final String gender;
  final String dob;
  final String nationality;
  final String city;
  final String commune;
  final String? quarter;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.uniqueRegistrationNumber,
    required this.gender,
    required this.dob,
    required this.nationality,
    required this.city,
    required this.commune,
    this.quarter,
  });
}