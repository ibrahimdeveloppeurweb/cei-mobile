import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/main.dart';

import 'candidature_eligibility_checker.dart';
import 'models/election_type.dart';

class CandidatureEnrollmentVerificationResultScreen extends StatefulWidget {
  final EnrollmentData enrollmentData;
  final ElectionType? selectedElection;
  final bool returnToCandidature;

  const CandidatureEnrollmentVerificationResultScreen({
    Key? key,
    required this.enrollmentData,
    this.selectedElection,
    this.returnToCandidature = false,
  }) : super(key: key);

  @override
  State<CandidatureEnrollmentVerificationResultScreen> createState() => _CandidatureEnrollmentVerificationResultScreenState();
}

class _CandidatureEnrollmentVerificationResultScreenState extends State<CandidatureEnrollmentVerificationResultScreen> {

  String _getPollingStationName() {
    if (widget.enrollmentData.centre?.name != null) {
      return "Bureau de vote #${widget.enrollmentData.centre!.id}";
    }
    return "Bureau de vote non défini";
  }

  String _getFormattedDateOfBirth() {
    if (widget.enrollmentData.birthdate != null) {
      return "${widget.enrollmentData.birthdate!.day}/${widget.enrollmentData.birthdate!.month}/${widget.enrollmentData.birthdate!.year}";
    }
    return "Date non disponible";
  }

  String _getFormattedFatherDateOfBirth() {
    if (widget.enrollmentData.birthdateFather != null) {
      return "${widget.enrollmentData.birthdateFather!.day}/${widget.enrollmentData.birthdateFather!.month}/${widget.enrollmentData.birthdateFather!.year}";
    }
    return "Date non disponible";
  }

  String _getFormattedMotherDateOfBirth() {
    if (widget.enrollmentData.birthdateMother != null) {
      return "${widget.enrollmentData.birthdateMother!.day}/${widget.enrollmentData.birthdateMother!.month}/${widget.enrollmentData.birthdateMother!.year}";
    }
    return "Date non disponible";
  }

  String _getEnrollmentCenter() {
    if (widget.enrollmentData.centre != null) {
      final ps = widget.enrollmentData.centre!;
      if (ps.name != null && ps.commune?.name != null) {
        return "${ps.name} - ${ps.commune!.name}";
      } else if (ps.name != null) {
        return ps.name!;
      }
    }
    return "Centre d'enrôlement non défini";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Informations Electeur'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              toast('Partage de données électorales');
            },
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              toast('Impression des données électorales');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header banner
            Container(
              width: double.infinity,
              color: AppColors.secondary,
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Vous êtes inscrit sur la liste électorale',
                      style: boldTextStyle(color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
            ),

            // Candidature context banner if applicable  
            // if (widget.returnToCandidature && widget.selectedElection != null)
            //   _buildCandidatureContextBanner(),

            // Card with voter information
            Container(
              margin: const EdgeInsets.all(16),
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
                  // Profile header with photo
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile picture
                        Container(
                          width: 120,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey2, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: widget.enrollmentData.photoIdentite.isEmptyOrNull
                                ? Image.asset(
                              'assets/images/profile_placeholder.png',
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                              widget.enrollmentData.photoIdentite!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        16.width,
                        // Basic identification
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.enrollmentData.lastName.validate()} ${widget.enrollmentData.firstName.validate()}',
                                style: boldTextStyle(size: 20),
                              ),
                              12.height,
                              _buildDetailRow('N° d\'ordre:', widget.enrollmentData.numOrder.validate()),
                              8.height,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'N° d\'électeur:',
                                    style: secondaryTextStyle(size: 14),
                                  ),
                                  4.width,
                                  Text(
                                    widget.enrollmentData.numEnregister.validate(),
                                    style: boldTextStyle(size: 14),
                                  ),
                                ],
                              ),
                              8.height,
                              _buildDetailRow('Genre:', widget.enrollmentData.gender.validate()),
                              8.height,
                              _buildDetailRow('Profession:', widget.enrollmentData.profession.validate()),
                              8.height,
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.location_on, size: 18, color: AppColors.primary),
                                    4.width,
                                    Expanded(
                                      child: Text(
                                        _getPollingStationName(),
                                        style: boldTextStyle(color: AppColors.primary, size: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Personal Information Section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('INFORMATIONS PERSONNELLES'),
                        12.height,
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoBox(
                                'Date de naissance:',
                                _getFormattedDateOfBirth(),
                                Icons.calendar_today,
                              ),
                            ),
                            12.width,
                            Expanded(
                              child: _buildInfoBox(
                                'Lieu de naissance:',
                                widget.enrollmentData.birthplace.validate(),
                                Icons.place,
                              ),
                            ),
                          ],
                        ),
                        12.height,
                        _buildInfoBox(
                          'Domicile:',
                          widget.enrollmentData.address.validate(),
                          Icons.home,
                        ),
                      ],
                    ),
                  ),

                  // Parents Information Section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('INFORMATIONS FAMILIALES'),
                        12.height,

                        // Father's information
                        _buildParentInfo(
                          'Père:',
                          '${widget.enrollmentData.lastNameFather.validate()} ${widget.enrollmentData.firstNameFather.validate()}',
                          _getFormattedFatherDateOfBirth(),
                          widget.enrollmentData.birthplaceFather.validate(),
                          Icons.person,
                        ),
                        16.height,

                        // Mother's information
                        _buildParentInfo(
                          'Mère:',
                          '${widget.enrollmentData.lastNameMother.validate()} ${widget.enrollmentData.firstNameMother.validate()}',
                          _getFormattedMotherDateOfBirth(),
                          widget.enrollmentData.birthplaceMother.validate(),
                          Icons.person_outline,
                        ),
                      ],
                    ),
                  ),

                  // Enrollment Information
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('INFORMATION D\'ENRÔLEMENT'),
                        12.height,
                        _buildInfoBox(
                          'Centre d\'enrôlement:',
                          _getEnrollmentCenter(),
                          Icons.how_to_vote,
                        ),
                      ],
                    ),
                  ),

                  // QR Code Section
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'CODE QR D\'IDENTIFICATION',
                          style: boldTextStyle(size: 16),
                          textAlign: TextAlign.center,
                        ),
                        8.height,
                        Text(
                          'Présentez ce code lors du vote',
                          style: secondaryTextStyle(size: 14),
                          textAlign: TextAlign.center,
                        ),
                        20.height,
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: QrImageView(
                              data: '${widget.enrollmentData.numEnregister}:${widget.enrollmentData.firstName} ${widget.enrollmentData.lastName}',
                              version: QrVersions.auto,
                              size: 200.0,
                              embeddedImage: const AssetImage('assets/images/cei_logo_small.png'),
                              embeddedImageStyle: const QrEmbeddedImageStyle(
                                size: Size(30, 30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Important notice
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Colors.orange.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(8),
            //     border: Border.all(color: Colors.orange.shade300),
            //   ),
            //   child: Row(
            //     children: [
            //       const Icon(Icons.info_outline, color: Colors.orange),
            //       12.width,
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               'Information importante',
            //               style: boldTextStyle(color: Colors.orange.shade800, size: 14),
            //             ),
            //             8.height,
            //             Text(
            //               'N\'oubliez pas de vous munir d\'une pièce d\'identité valide (CNI, passeport, permis de conduire) le jour du scrutin.',
            //               style: primaryTextStyle(size: 13),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // 20.height
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildCandidatureContextBanner() {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                widget.selectedElection!.icon,
                color: Colors.white,
                size: 24,
              ),
              12.width,
              Expanded(
                child: Text(
                  'Candidature: ${widget.selectedElection!.title}',
                  style: boldTextStyle(color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          8.height,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Inscription vérifiée - Prêt pour l\'étape suivante',
              style: boldTextStyle(color: Colors.white, size: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    if (widget.returnToCandidature && widget.selectedElection != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(
                  widget.selectedElection!.icon,
                  color: Colors.white,
                ),
                label: const Text('Continuer ma candidature'),
                onPressed: () => _proceedToCandidature(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.navigate_next, color: Colors.white),
                label: const Text('Continuer'),
                onPressed: () => _saveAndProceedToCandidature(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          color: AppColors.primary,
        ),
        8.width,
        Text(
          title,
          style: boldTextStyle(size: 16),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: secondaryTextStyle(size: 14),
        ),
        4.width,
        Expanded(
          child: Text(
            value,
            style: boldTextStyle(size: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.primary,
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: secondaryTextStyle(size: 13),
                ),
                4.height,
                Text(
                  value,
                  style: boldTextStyle(size: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParentInfo(String label, String name, String dob, String pob, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: AppColors.primary,
              ),
              8.width,
              Text(
                label,
                style: secondaryTextStyle(size: 13),
              ),
            ],
          ),
          8.height,
          Text(
            name,
            style: boldTextStyle(size: 15),
          ),
          8.height,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date de naissance:',
                      style: secondaryTextStyle(size: 12),
                    ),
                    4.height,
                    Text(
                      dob,
                      style: primaryTextStyle(size: 14),
                    ),
                  ],
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lieu de naissance:',
                      style: secondaryTextStyle(size: 12),
                    ),
                    4.height,
                    Text(
                      pob,
                      style: primaryTextStyle(size: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _proceedToCandidature() {
    // Save enrollment data to app store and proceed to eligibility check
    appStore.setEnrollmentData(widget.enrollmentData);
    _checkElectionEligibility();
  }

  void _saveAndProceedToCandidature() {
    // Save enrollment data to app store and go to election selection
    appStore.setEnrollmentData(widget.enrollmentData);
    context.pushNamed(AppRoutes.candidatureSelectionScreen);
  }

  void _checkElectionEligibility() {
    final user = userStore.user;

    if (user == null) {
      _showErrorMessage('Données utilisateur non disponibles');
      return;
    }

    final result = CandidatureEligibilityChecker.checkEligibility(
      enrollmentData: widget.enrollmentData,
      user: user,
      candidatureType: widget.selectedElection!.type,
    );

    if (result.isEligible) {
      _proceedToFaceVerification();
    } else {
      CandidatureEligibilityChecker.showIneligibilityDialog(
        context,
        result,
        widget.selectedElection!.type,
      );
    }
  }

  void _proceedToFaceVerification() {
    context.pushNamed(
      AppRoutes.faceVerificationScreen,
      extra: {
        'election': widget.selectedElection,
        'enrollmentData': widget.enrollmentData,
      },
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            8.width,
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}