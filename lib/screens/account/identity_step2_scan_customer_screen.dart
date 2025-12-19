// lib/features/enrollment/screens/enrollment_step2_screen.dart

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cei_mobile/common_widgets/indicator_dot.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/services/regula_service.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class IdentityStep2ScanCustomerScreen extends StatefulWidget {
  const IdentityStep2ScanCustomerScreen({super.key});

  @override
  State<IdentityStep2ScanCustomerScreen> createState() => _IdentityStep2ScanCustomerScreenState();
}

class _IdentityStep2ScanCustomerScreenState extends State<IdentityStep2ScanCustomerScreen> {
  File? _idPhoto;
  File? _documentFacePhoto;
  bool _photoTaken = false;
  bool _isCapturing = false;
  bool _livenessVerified = false;

  // Face comparison variables
  bool _isComparingFaces = false;
  bool _faceMatchResult = false;
  bool _hasAttemptedFaceMatch = false;
  double _faceMatchScore = 0.0;
  bool _isSdkInitializing = true;

  final RegulaService _regulaService = RegulaService();

  @override
  void initState() {
    super.initState();
    _initializeFaceSDK();
    _loadSavedData();
  }

  void _loadSavedData() {
    // Load existing photo if available
    if (scanCustomerStore.idPhoto != null) {
      setState(() {
        _idPhoto = scanCustomerStore.idPhoto;
        _photoTaken = scanCustomerStore.photoTaken;
        if (_idPhoto != null) {
          _livenessVerified = true;
        }
        _faceMatchResult = scanCustomerStore.faceVerified;
      });
    }

    // Load document face photo if available
    final documentFacePath = getStringAsync('document_face_photo_path');
    if (documentFacePath.isNotEmpty) {
      final documentFaceFile = File(documentFacePath);
      if (documentFaceFile.existsSync()) {
        setState(() {
          _documentFacePhoto = documentFaceFile;
        });
      }
    }

    // Load face verification status if previously verified
    final wasVerified = getBoolAsync('face_verification_result', defaultValue: false);
    if (wasVerified && _documentFacePhoto != null && _idPhoto != null) {
      setState(() {
        _faceMatchResult = true;
        _hasAttemptedFaceMatch = true;
        _faceMatchScore = getDoubleAsync('face_verification_score', defaultValue: 0.7);
      });
    }
  }

  Future<void> _initializeFaceSDK() async {
    setState(() {
      _isSdkInitializing = true;
    });

    try {
      bool initialized = await _regulaService.initializeFaceSdk();
      if (!initialized) {
        toast('Échec de l\'initialisation du système de vérification faciale');
      }
    } catch (e) {
      print('Erreur d\'initialisation: $e');
      toast('Erreur lors de l\'initialisation du système de vérification faciale');
    } finally {
      // Even if initialization failed, mark it as completed to allow retry
      setState(() {
        _isSdkInitializing = false;
      });
    }
  }

  // Méthode pour effectuer une vérification de liveness et capturer un selfie
  Future<void> _captureFaceWithLiveness() async {
    setState(() {
      _isCapturing = true;
      // Reset face match status when taking a new photo
      _hasAttemptedFaceMatch = false;
      _faceMatchResult = false;
    });

    try {
      // Lancer la vérification de liveness
      final result = await _regulaService.performLivenessCheck();

      if (result['success']) {
        if (result['livenessPassed'] == true) {
          setState(() {
            _livenessVerified = true;
          });

          if (result['image'] != null) {
            final Uint8List imageBytes = result['image'];
            final tempDir = Directory.systemTemp;

            // Generate random file name with timestamp to avoid conflicts
            final timestamp = DateTime.now().millisecondsSinceEpoch;
            final randomSuffix = (100000 + Random().nextInt(900000)); // 6-digit random number
            final fileName = 'selfie_${timestamp}_$randomSuffix.jpg';

            final selfieFile = File('${tempDir.path}/$fileName');
            await selfieFile.writeAsBytes(imageBytes);

            setState(() {
              _idPhoto = selfieFile;
              _photoTaken = true;
            });

            // Store in the enrollment store with the new method
            scanCustomerStore.setStep2Data(
              idPhoto: selfieFile,
              photoTaken: true,
              faceVerified: false,  // Reset verification status since we took a new photo
            );

            toast('Photo capturée et vérifiée avec succès!', gravity: ToastGravity.TOP);

            // Automatically compare with document face if available
            if (_documentFacePhoto != null) {
              await _compareFaces();
            }
          }
        } else {
          // Échec de la vérification de liveness
          toast('Vérification de vivacité échouée. Veuillez réessayer.', gravity: ToastGravity.TOP);
        }
      } else {
        // Erreur lors de la vérification
        toast(result['message'] ?? 'Une erreur s\'est produite', gravity: ToastGravity.TOP);
      }
    } catch (e) {
      print('Erreur lors de la vérification faciale: $e');
      toast('Une erreur s\'est produite lors de la vérification', gravity: ToastGravity.TOP);
    } finally {
      setState(() {
        _isCapturing = false;
      });
    }
  }

  // Méthode pour capturer uniquement un selfie sans liveness
  Future<void> _captureFaceOnly() async {
    setState(() {
      _isCapturing = true;
      // Reset face match status when taking a new photo
      _hasAttemptedFaceMatch = false;
      _faceMatchResult = false;
    });

    try {
      // Lancer la capture de visage simple
      final result = await _regulaService.captureFace();

      if (result['success']) {
        // Convertir l'image en fichier
        if (result['image'] != null) {
          final Uint8List imageBytes = result['image'];
          final tempDir = Directory.systemTemp;
          final selfieFile = File('${tempDir.path}/selfie.jpg');
          await selfieFile.writeAsBytes(imageBytes);

          setState(() {
            _idPhoto = selfieFile;
            _photoTaken = true;
            _livenessVerified = false;
          });

          // Store in the enrollment store with the new method
          scanCustomerStore.setStep2Data(
            idPhoto: selfieFile,
            photoTaken: true,
            faceVerified: false,  // Reset verification status since we took a new photo
          );

          toast('Photo capturée avec succès!', gravity: ToastGravity.TOP);
        }
      } else {
        toast(result['message'] ?? 'Une erreur s\'est produite', gravity: ToastGravity.TOP);
      }
    } catch (e) {
      print('Erreur lors de la capture faciale: $e');
      toast('Une erreur s\'est produite lors de la capture', gravity: ToastGravity.TOP);
    } finally {
      setState(() {
        _isCapturing = false;
      });
    }
  }

  // Comparer les visages entre la photo du selfie et la photo du document
  Future<void> _compareFaces() async {
    if (_idPhoto == null || _documentFacePhoto == null) {
      // If either photo is missing, notify the user and do not proceed
      toast('Photos manquantes. Impossible de vérifier l\'identité.', gravity: ToastGravity.TOP);
      return;
    }

    setState(() {
      _isComparingFaces = true;
    });

    try {
      // Read the image bytes
      final Uint8List selfieBytes = await _idPhoto!.readAsBytes();
      final Uint8List docFaceBytes = await _documentFacePhoto!.readAsBytes();

      // Compare faces with Regula
      final result = await _regulaService.compareFaces(selfieBytes, docFaceBytes);

      if (result['success']) {
        setState(() {
          _faceMatchScore = result['similarity'] ?? 0.0;
          _faceMatchResult = result['matched'] ?? false;
          _hasAttemptedFaceMatch = true;
          _isComparingFaces = false;
        });

        // Store the verification result in the store
        scanCustomerStore.setStep2Data(
          faceVerified: _faceMatchResult,
        );

        // Store the scores in preferences for future reference
        setValue('face_verification_result', _faceMatchResult);
        setValue('face_verification_score', _faceMatchScore);

        // Show feedback message
        String message = _faceMatchResult
            ? 'Identité vérifiée avec succès!'
            : 'Échec de la vérification. Veuillez reprendre votre photo.';
        toast(message, gravity: ToastGravity.CENTER, length: Toast.LENGTH_LONG);
      } else {
        // On error, do not proceed but show error message
        setState(() {
          _isComparingFaces = false;
        });
        toast(result['message'] ?? 'Erreur lors de la comparaison faciale');
      }
    } catch (e) {
      setState(() {
        _isComparingFaces = false;
      });
      print('Erreur lors de la comparaison faciale: $e');
      toast('Erreur lors de la comparaison faciale: $e');
    }
  }

  void _showFullScreenPreview() {
    if (_idPhoto == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text('Prévisualisation', style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                  _captureFaceWithLiveness();
                },
              ),
            ],
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4,
                child: Image.file(_idPhoto!),
              ),
            ),
          ),
        ),
      ),
    );
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
                    const IndicatorDot(
                      currentPage: 1,
                      totalItems: 6,
                      selectedDotWidth: 45,
                      unselectedDotWidth: 45,
                    ),
                    30.height,
                    Text("Photo",
                        style: boldTextStyle(
                            size: 36, letterSpacing: 2, color: Colors.black)),
                    Text("d'identité",
                        style: boldTextStyle(
                            size: 36, letterSpacing: 2, color: Colors.black)),
                    50.height,

                    // Section de prévisualisation de la photo
                    _buildPhotoPreviewSection(),

                    30.height,

                    // Section d'instructions
                    _buildInstructionsPanel(),

                    // Compare faces button if we have a document photo
                    if (_photoTaken && _documentFacePhoto != null && !_hasAttemptedFaceMatch)
                      _buildCompareButton(),
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

  Widget _buildCompareButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.compare, color: Colors.white),
          label: Text(
            _isComparingFaces ? 'Comparaison en cours...' : 'Vérifier l\'identité',
            style: boldTextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: _isComparingFaces ? null : _compareFaces,
        ),
      ),
    );
  }

  Widget _buildPhotoPreviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.info_outline,
              color: _hasAttemptedFaceMatch && !_faceMatchResult ? Colors.red : AppColors.primary,
              size: 20,
            ),
            8.width,
            Expanded(
              child: Text(
                _hasAttemptedFaceMatch && !_faceMatchResult
                    ? 'La photo ne correspond pas au document d\'identité'
                    : (_livenessVerified
                    ? 'Photo d\'identité avec vérification de vivacité'
                    : 'Photo d\'identité (sans lunettes, visage net)'),
                style: AppTextStyles.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _hasAttemptedFaceMatch && !_faceMatchResult ? Colors.red : null,
                ),
              ),
            ),
          ],
        ),
        20.height,

        // Container de prévisualisation photo
        Center(
          child: Stack(
            children: [
              // Container pour la photo
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
                  border: _hasAttemptedFaceMatch && !_faceMatchResult
                      ? Border.all(color: Colors.red, width: 2)
                      : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _isSdkInitializing
                        ? null  // Disable tapping while initializing
                        : (_idPhoto != null ? _showFullScreenPreview : _captureFaceWithLiveness),
                    borderRadius: BorderRadius.circular(16),
                    child: _idPhoto != null
                        ? Stack(
                      fit: StackFit.expand,
                      children: [
                        // Photo
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            _idPhoto!,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Badge de liveness si vérifié
                        if (_livenessVerified)
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.verified_user,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  4.width,
                                  const Text(
                                    'Vivacité vérifiée',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // Face match indicator (success or failure)
                        if (_hasAttemptedFaceMatch)
                          Positioned(
                            top: _livenessVerified ? 40 : 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _faceMatchResult
                                    ? Colors.blue.withOpacity(0.8)
                                    : Colors.red.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _faceMatchResult ? Icons.check_circle : Icons.error,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  4.width,
                                  Text(
                                    _faceMatchResult
                                        ? 'Identité vérifiée'
                                        : 'Non vérifié',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                    )
                        : _isCapturing
                        ? Center(
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
                    )
                        : _isSdkInitializing  // Add this condition to handle SDK initialization
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(color: AppColors.primary),
                          16.height,
                          Text(
                            'Initialisation du système...',
                            style: secondaryTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          8.height,
                          Text(
                            'Veuillez patienter',
                            style: secondaryTextStyle(size: 12, color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                        : Column(
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
                    ),
                  ),
                ),
              ),

              if (_idPhoto != null)
                Positioned(
                  top: -5,
                  right: -5,
                  child: Material(
                    color: Colors.white,
                    elevation: 4,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: _isSdkInitializing ? null : _captureFaceWithLiveness,  // Disable edit while initializing
                      customBorder: const CircleBorder(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: _isSdkInitializing ? Colors.grey : AppColors.primary,  // Grey out when initializing
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Status Message based on verification state
        if (_photoTaken)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _getStatusColor()[0],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _getStatusColor()[1],
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(),
                      color: _getStatusColor()[2],
                      size: 20,
                    ),
                    8.width,
                    Text(
                      _getStatusText(),
                      style: TextStyle(
                        color: _getStatusColor()[2],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Detailed verification message
        if (_hasAttemptedFaceMatch)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _faceMatchResult ? Colors.green[50] : Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _faceMatchResult ? Colors.green[200]! : Colors.red[200]!,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          _faceMatchResult ? Icons.check_circle : Icons.error,
                          color: _faceMatchResult ? Colors.green[700] : Colors.red[700],
                          size: 20,
                        ),
                        8.width,
                        Expanded(
                          child: Text(
                            _faceMatchResult
                                ? 'Identité vérifiée avec succès'
                                : 'Échec de la vérification d\'identité',
                            style: boldTextStyle(
                              color: _faceMatchResult ? Colors.green[700] : Colors.red[700],
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    8.height,
                    if (_faceMatchScore > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Score de correspondance: ${(_faceMatchScore * 100).toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: _faceMatchResult ? Colors.green[700] : Colors.red[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    10.height,
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _faceMatchResult
                              ? 'Votre visage correspond à celui de votre pièce d\'identité.'
                              : 'Votre visage ne correspond pas suffisamment à celui de votre pièce d\'identité. Veuillez reprendre votre photo avec une meilleure luminosité et une expression neutre.',
                          style: TextStyle(
                            color: _faceMatchResult ? Colors.green[700] : Colors.red[700],
                          ),
                        ),
                      ),
                    ),
                    if (!_faceMatchResult) ...[
                      10.height,
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.camera_alt, size: 16, color: Colors.white,),
                          label: const Text('Reprendre la photo'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: _isSdkInitializing ? null : _captureFaceWithLiveness,  // Disable when initializing
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  IconData _getStatusIcon() {
    if (_hasAttemptedFaceMatch) {
      return _faceMatchResult ? Icons.verified_outlined : Icons.error;
    } else if (_livenessVerified) {
      return Icons.verified_user;
    } else {
      return Icons.check_circle;
    }
  }

  String _getStatusText() {
    if (_hasAttemptedFaceMatch) {
      return _faceMatchResult ? 'Photo vérifiée' : 'Vérification échouée';
    } else if (_livenessVerified) {
      return 'Photo avec vivacité vérifiée';
    } else {
      return 'Photo ajoutée avec succès';
    }
  }

  List<Color> _getStatusColor() {
    // Return [background, border, text]
    if (_hasAttemptedFaceMatch && !_faceMatchResult) {
      return [Colors.red[50]!, Colors.red[200]!, Colors.red[700]!];
    } else if (_hasAttemptedFaceMatch && _faceMatchResult) {
      return [Colors.green[50]!, Colors.green[200]!, Colors.green[700]!];
    } else if (_livenessVerified) {
      return [Colors.green[50]!, Colors.green[200]!, Colors.green[700]!];
    } else {
      return [Colors.blue[50]!, Colors.blue[200]!, Colors.blue[700]!];
    }
  }

  Widget _buildInstructionsPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
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
                size: 24,
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
          // New instruction for document photos
          if (_documentFacePhoto != null)
            _buildInstructionItem(
              icon: Icons.compare,
              text: 'Cette photo sera comparée à celle de votre pièce d\'identité pour vérification',
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
              style: AppTextStyles.body2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
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
          Expanded(
            child: AppButton(
              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onTap: () {
                scanCustomerStore.previousStep();
              },
              elevation: 0.0,
              color: Colors.grey[200],
              child: Text('Précédent', style: boldTextStyle(color: Colors.black87)),
            ),
          ),
          16.width,
          Expanded(
            child: AppButton(
              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
             // enabled: _faceMatchResult,
              onTap: () {
                // if (_idPhoto == null) {
                //   toast('Veuillez prendre ou choisir une photo d\'identité');
                //   return;
                // }

                // Si une photo de document est disponible mais pas encore comparée
                // if (_documentFacePhoto != null && !_hasAttemptedFaceMatch) {
                //   toast('Veuillez vérifier votre identité en comparant les photos');
                //   return;
                // }

                // if (_hasAttemptedFaceMatch && !_faceMatchResult) {
                //   toast('La vérification d\'identité a échoué. Veuillez reprendre votre photo.');
                //   return;
                // }

                // Enregistrer les données dans le store avec la nouvelle méthode
                scanCustomerStore.setStep2Data(
                  idPhoto: _idPhoto,
                  photoTaken: true,
                  faceVerified: _faceMatchResult,
                );

                // Passer à l'étape suivante
                scanCustomerStore.nextStep();
              },
              elevation: 0.0,
              color: AppColors.primary,
              child: _isComparingFaces
                  ? const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                    ),
                  ))
                  : Text('Suivant', style: boldTextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}