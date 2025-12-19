import 'dart:io';
import 'dart:typed_data';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/services/regula_service.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import 'election_selection_screen.dart';
import 'models/election_type.dart';

class CandidatureFaceVerificationScreen extends StatefulWidget {
  final ElectionType election;
  final EnrollmentData? enrollmentData;

  const CandidatureFaceVerificationScreen({
    super.key,
    required this.election,
    this.enrollmentData,
  });

  @override
  State<CandidatureFaceVerificationScreen> createState() => _CandidatureFaceVerificationScreenState();
}

class _CandidatureFaceVerificationScreenState extends State<CandidatureFaceVerificationScreen> {
  File? _capturedPhoto;
  bool _isCapturing = false;
  bool _isComparingFaces = false;
  bool _faceMatchResult = false;
  bool _hasAttemptedFaceMatch = false;
  double _faceMatchScore = 0.0;
  bool _isSdkInitializing = true;
  String? _enrollmentPhotoPath;
  String _debugMessage = ''; // Added for debugging

  final RegulaService _regulaService = RegulaService();

  @override
  void initState() {
    super.initState();
    _initializeFaceSDK();
    _loadEnrollmentPhoto();
    _debugEnrollmentData(); // Added debug method
  }

  // Debug method to check enrollment data
  void _debugEnrollmentData() {
    print('=== DEBUG ENROLLMENT DATA ===');
    print('EnrollmentData is null: ${widget.enrollmentData == null}');
    if (widget.enrollmentData != null) {
      print('PhotoIdentite: ${widget.enrollmentData!.photoIdentite}');
      print('NumEnregister: ${widget.enrollmentData!.numEnregister}');
      print('FirstName: ${widget.enrollmentData!.firstName}');
      print('LastName: ${widget.enrollmentData!.lastName}');
    }
    print('============================');
  }

  Future<void> _initializeFaceSDK() async {
    setState(() {
      _isSdkInitializing = true;
      _debugMessage = 'Initialisation du SDK...';
    });

    try {
      bool initialized = await _regulaService.initializeFaceSdk();
      setState(() {
        _debugMessage = initialized ? 'SDK initialisé avec succès' : 'Échec initialisation SDK';
      });
      if (!initialized) {
        toast('Échec de l\'initialisation du système de vérification faciale');
      }
    } catch (e) {
      print('Erreur d\'initialisation: $e');
      setState(() {
        _debugMessage = 'Erreur initialisation: $e';
      });
      toast('Erreur lors de l\'initialisation du système de vérification faciale');
    } finally {
      setState(() {
        _isSdkInitializing = false;
      });
    }
  }

  void _loadEnrollmentPhoto() {
    print('=== LOADING ENROLLMENT PHOTO ===');
    if (widget.enrollmentData?.photoIdentite != null &&
        widget.enrollmentData!.photoIdentite!.isNotEmpty) {
      setState(() {
        _enrollmentPhotoPath = widget.enrollmentData!.photoIdentite!;
        _debugMessage = 'Photo d\'enrôlement chargée: $_enrollmentPhotoPath';
      });
      print('Enrollment photo path set: $_enrollmentPhotoPath');
    } else {
      setState(() {
        _debugMessage = 'Aucune photo d\'enrôlement trouvée';
      });
      print('No enrollment photo found');
    }
    print('================================');
  }

  Future<void> _captureFaceWithLiveness() async {
    print('=== STARTING FACE CAPTURE ===');
    setState(() {
      _isCapturing = true;
      _hasAttemptedFaceMatch = false;
      _faceMatchResult = false;
      _debugMessage = 'Capture de photo en cours...';
    });

    try {
      final result = await _regulaService.performLivenessCheck();
      print('Liveness check result: $result');

      if (result['success']) {
        if (result['livenessPassed'] == true) {
          if (result['image'] != null) {
            final Uint8List imageBytes = result['image'];
            final tempDir = Directory.systemTemp;
            final timestamp = DateTime.now().millisecondsSinceEpoch;
            final selfieFile = File('${tempDir.path}/candidature_selfie_$timestamp.jpg');
            await selfieFile.writeAsBytes(imageBytes);

            setState(() {
              _capturedPhoto = selfieFile;
              _debugMessage = 'Photo capturée, préparation de la comparaison...';
            });
            print('Photo captured successfully: ${selfieFile.path}');

            toast('Photo capturée avec succès!', gravity: ToastGravity.TOP);

            // Vérifier si on peut comparer
            if (_enrollmentPhotoPath != null && _enrollmentPhotoPath!.isNotEmpty) {
              print('Starting face comparison...');
              await _compareFaces();
            } else {
              setState(() {
                _debugMessage = 'Impossible de comparer: photo d\'enrôlement manquante';
              });
              print('Cannot compare: no enrollment photo');
              toast('Photo d\'enrôlement manquante. Impossible de vérifier l\'identité.',
                  gravity: ToastGravity.CENTER);
            }
          } else {
            setState(() {
              _debugMessage = 'Échec capture: pas d\'image retournée';
            });
            print('No image returned from liveness check');
          }
        } else {
          setState(() {
            _debugMessage = 'Échec vérification de vivacité';
          });
          toast('Vérification de vivacité échouée. Veuillez réessayer.', gravity: ToastGravity.TOP);
        }
      } else {
        setState(() {
          _debugMessage = 'Échec capture: ${result['message'] ?? 'erreur inconnue'}';
        });
        toast(result['message'] ?? 'Une erreur s\'est produite', gravity: ToastGravity.TOP);
      }
    } catch (e) {
      print('Erreur lors de la vérification faciale: $e');
      setState(() {
        _debugMessage = 'Erreur capture: $e';
      });
      toast('Une erreur s\'est produite lors de la vérification', gravity: ToastGravity.TOP);
    } finally {
      setState(() {
        _isCapturing = false;
      });
    }
  }

  Future<void> _compareFaces() async {
    print('=== STARTING FACE COMPARISON ===');

    if (_capturedPhoto == null) {
      print('No captured photo available');
      setState(() {
        _debugMessage = 'Erreur: photo capturée manquante';
      });
      toast('Photo capturée manquante. Veuillez reprendre votre photo.', gravity: ToastGravity.TOP);
      return;
    }

    if (_enrollmentPhotoPath == null || _enrollmentPhotoPath!.isEmpty) {
      print('No enrollment photo path available');
      setState(() {
        _debugMessage = 'Erreur: chemin photo d\'enrôlement manquant';
      });
      toast('Photo d\'enrôlement manquante. Impossible de vérifier l\'identité.', gravity: ToastGravity.TOP);
      return;
    }

    setState(() {
      _isComparingFaces = true;
      _debugMessage = 'Comparaison des visages en cours...';
    });

    try {
      // Lire la photo capturée
      final Uint8List capturedBytes = await _capturedPhoto!.readAsBytes();
      print('Captured photo size: ${capturedBytes.length} bytes');

      // Charger la photo d'enrôlement
      Uint8List enrollmentBytes;

      if (_enrollmentPhotoPath!.startsWith('http')) {
        // Télécharger depuis URL
        print('Downloading enrollment photo from URL: $_enrollmentPhotoPath');
        setState(() {
          _debugMessage = 'Téléchargement photo d\'enrôlement...';
        });

        try {
          final response = await http.get(Uri.parse(_enrollmentPhotoPath!));
          if (response.statusCode == 200) {
            enrollmentBytes = response.bodyBytes;
            print('Downloaded enrollment photo: ${enrollmentBytes.length} bytes');
          } else {
            throw Exception('Échec téléchargement: ${response.statusCode}');
          }
        } catch (e) {
          print('Error downloading enrollment photo: $e');
          setState(() {
            _debugMessage = 'Erreur téléchargement: $e';
            _isComparingFaces = false;
          });
          toast('Impossible de télécharger votre photo d\'enrôlement');
          return;
        }
      } else {
        // Lire depuis fichier local
        print('Reading enrollment photo from local path: $_enrollmentPhotoPath');
        final enrollmentFile = File(_enrollmentPhotoPath!);
        if (!enrollmentFile.existsSync()) {
          print('Enrollment file does not exist');
          setState(() {
            _debugMessage = 'Fichier photo d\'enrôlement introuvable';
            _isComparingFaces = false;
          });
          toast('Photo d\'enrôlement introuvable');
          return;
        }
        enrollmentBytes = await enrollmentFile.readAsBytes();
        print('Read enrollment photo: ${enrollmentBytes.length} bytes');
      }

      // Effectuer la comparaison
      print('Calling compareFaces API...');
      setState(() {
        _debugMessage = 'Analyse des visages...';
      });

      final result = await _regulaService.compareFaces(capturedBytes, enrollmentBytes);
      print('Face comparison result: $result');

      if (result['success']) {
        final similarity = result['similarity'] ?? 0.0;
        final matched = result['matched'] ?? false;

        setState(() {
          _faceMatchScore = similarity;
          _faceMatchResult = matched;
          _hasAttemptedFaceMatch = true;
          _isComparingFaces = false;
          _debugMessage = 'Comparaison terminée: ${matched ? 'succès' : 'échec'} (${(similarity * 100).toStringAsFixed(1)}%)';
        });

        String message = matched
            ? 'Identité vérifiée avec succès! (${(similarity * 100).toStringAsFixed(1)}%)'
            : 'Échec de la vérification. Correspondance: ${(similarity * 100).toStringAsFixed(1)}%';

        toast(message, gravity: ToastGravity.CENTER, length: Toast.LENGTH_LONG);

        if (matched) {
          // Attendre un peu puis procéder à la candidature
          Future.delayed(const Duration(seconds: 2), () {
            _proceedToCandidature();
          });
        }
      } else {
        setState(() {
          _isComparingFaces = false;
          _debugMessage = 'Erreur comparaison: ${result['message'] ?? 'inconnue'}';
        });
        toast(result['message'] ?? 'Erreur lors de la comparaison faciale');
      }
    } catch (e) {
      setState(() {
        _isComparingFaces = false;
        _debugMessage = 'Exception comparaison: $e';
      });
      print('Erreur lors de la comparaison faciale: $e');
      toast('Erreur lors de la comparaison faciale: $e');
    }

    print('=== FACE COMPARISON ENDED ===');
  }

  void _proceedToCandidature() {
    // Naviguer vers l'écran de soumission de candidature
    context.pushReplacementNamed(
      AppRoutes.candidature,
      extra: {
        'election': widget.election,
        'verifiedPhoto': _capturedPhoto,
        'matchScore': _faceMatchScore,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vérification d\'identité',
          style: AppTextStyles.h3.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Information sur l'élection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.election.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: widget.election.color.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.election.icon,
                    color: widget.election.color,
                    size: 24,
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Candidature pour:',
                          style: AppTextStyles.body2.copyWith(
                            color: widget.election.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.election.title,
                          style: AppTextStyles.h4.copyWith(
                            color: widget.election.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            24.height,

            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.security, color: Colors.blue[700]),
                      12.width,
                      Text(
                        'Vérification d\'identité requise',
                        style: AppTextStyles.h4.copyWith(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  12.height,
                  Text(
                    'Pour des raisons de sécurité, nous devons vérifier que vous êtes bien la personne qui s\'est enrôlée. Votre photo sera comparée à celle de votre enrôlement.',
                    style: AppTextStyles.body2.copyWith(
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
            ),
            24.height,

            // Section de capture photo
            _buildPhotoSection(),
            24.height,

            // Instructions pour la photo
            _buildInstructionsPanel(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Photo de vérification',
          style: AppTextStyles.h3.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        12.height,
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
                  border: _hasAttemptedFaceMatch && !_faceMatchResult
                      ? Border.all(color: Colors.red, width: 2)
                      : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _isSdkInitializing ? null : _captureFaceWithLiveness,
                    borderRadius: BorderRadius.circular(16),
                    child: _capturedPhoto != null
                        ? Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            _capturedPhoto!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (_hasAttemptedFaceMatch)
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _faceMatchResult
                                    ? Colors.green.withOpacity(0.8)
                                    : Colors.red.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _faceMatchResult
                                        ? Icons.check_circle
                                        : Icons.error,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  4.width,
                                  Text(
                                    _faceMatchResult
                                        ? 'Vérifiée'
                                        : 'Échec',
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
                      ],
                    )
                        : _isCapturing
                        ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Capture en cours...',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                        : _isSdkInitializing
                        ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Initialisation...',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
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
                            Icons.camera_alt,
                            size: 40,
                            color: AppColors.primary,
                          ),
                        ),
                        16.height,
                        Text(
                          'Prendre une photo',
                          style: boldTextStyle(
                            color: AppColors.primary,
                          ),
                        ),
                        8.height,
                        const Text(
                          'Appuyez ici',
                          style: TextStyle(
                            color: Colors.grey,
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

        if (_hasAttemptedFaceMatch) ...[
          16.height,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
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
                      size: 24,
                    ),
                    12.width,
                    Expanded(
                      child: Text(
                        _faceMatchResult
                            ? 'Identité vérifiée avec succès!'
                            : 'Échec de la vérification d\'identité',
                        style: AppTextStyles.h4.copyWith(
                          color: _faceMatchResult ? Colors.green[700] : Colors.red[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                12.height,
                Text(
                  _faceMatchResult
                      ? 'Votre identité a été confirmée. Vous pouvez maintenant procéder à votre candidature.'
                      : 'Votre visage ne correspond pas suffisamment à celui de votre enrôlement. Veuillez reprendre votre photo.',
                  style: AppTextStyles.body2.copyWith(
                    color: _faceMatchResult ? Colors.green[700] : Colors.red[700],
                  ),
                ),
                if (_faceMatchScore > 0) ...[
                  8.height,
                  Text(
                    'Score de correspondance: ${(_faceMatchScore * 100).toStringAsFixed(1)}%',
                    style: AppTextStyles.body2.copyWith(
                      color: _faceMatchResult ? Colors.green[600] : Colors.red[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],

        if (_isComparingFaces) ...[
          16.height,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                16.width,
                const Expanded(
                  child: Text(
                    'Comparaison avec votre photo d\'enrôlement en cours...',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
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
                style: AppTextStyles.h4.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
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
            icon: Icons.wb_sunny,
            text: 'Bonne luminosité sans ombres',
          ),
          _buildInstructionItem(
            icon: Icons.sentiment_neutral,
            text: 'Expression similaire à celle de votre enrôlement',
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

  Widget _buildBottomActions() {
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
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Annuler'),
            ),
          ),
          16.width,
          Expanded(
            child: ElevatedButton(
              onPressed: _faceMatchResult ? _proceedToCandidature : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Continuer',
                style: boldTextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}